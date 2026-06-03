#!/usr/bin/env python3
"""
Minimal changelog fixer for Linwood Butterfly.

What it does:
- Adds the missing CHANGELOG.md section for 2.5.3-rc.0 from metadata changelog 183.txt.
- Fixes the wrong 2.2.0-rc.3 "Read more" URL.
- Fixes a few obvious spelling mistakes.
- Optionally applies the same spelling/link fixes to metadata/en-US/changelogs/*.txt.

What it intentionally does NOT do:
- It does not normalize casing, so entries such as "flutter", "pdf", "webdav", etc. stay as written.
- It does not rewrite wording or grammar broadly.
"""

from __future__ import annotations

import argparse
from pathlib import Path

SECTION_253_RC0 = """## 2.5.3-rc.0 (2026-05-30)

* Change min iOS version to 14.0
* Upgrade to flutter 3.44 (Add stylus support for windows)
* Use nearest corner hit for selection transforms
* Add duplicate layer to multi select options in layers navigator
* Add automatic first template selection on desktop
* Fix jagged rendering after changing orientation ([#1094](https://github.com/LinwoodDev/Butterfly/issues/1094))
* Fix texture tool configuration scrolling getting stuck ([#1092](https://github.com/LinwoodDev/Butterfly/issues/1092))
* Fix temporary tools being cleared after canvas gestures ([#1093](https://github.com/LinwoodDev/Butterfly/issues/1093))
* Fix image operations temporarily showing gray boxes ([#1097](https://github.com/LinwoodDev/Butterfly/issues/1097))
* Fix title and description fields clearing on focus loss ([#1101](https://github.com/LinwoodDev/Butterfly/issues/1101))
* Fix pressure not used for inverted stylus
* Fix close dialog to offer save, discard, and cancel actions
* Fix top corner menu doesn't have navigator menu buttons on full screen
* Fix image export quality changes showing stale previews
* Fix duplicate layer button in layers dialog not working ([#1105](https://github.com/LinwoodDev/Butterfly/issues/1105))
* Fix moving PDFs with spacer tools freezing the canvas ([#1106](https://github.com/LinwoodDev/Butterfly/issues/1106))
* Fix stamp tool hover preview looks strange on touch ([#1107](https://github.com/LinwoodDev/Butterfly/issues/1107))
* Fix horizontal and vertical wrongly named in texture background dialog
* Fix offset list tile refreshes on same value
* Fix shapes with identical start and end points being created ([#1112](https://github.com/LinwoodDev/Butterfly/issues/1112))
* Fix very small selections being hard to transform or open context menus for ([#1112](https://github.com/LinwoodDev/Butterfly/issues/1112))

Read more here: https://linwood.dev/butterfly/2.5.3-rc.0

"""

SPELLING_REPLACEMENTS = {
    "desyncronization": "desynchronization",
    "resistence": "resistance",
    "utilties": "utilities",
    "initializaton": "initialization",
}


def replace_obvious_spelling(text: str) -> str:
    for old, new in SPELLING_REPLACEMENTS.items():
        text = text.replace(old, new)
    return text


def fix_changelog(path: Path) -> bool:
    original = path.read_text(encoding="utf-8")
    text = original

    if "## 2.5.3-rc.0" not in text and "## 2.5.2 (2026-05-23)" in text:
        text = text.replace(
            "## 2.5.2 (2026-05-23)",
            SECTION_253_RC0 + "## 2.5.2 (2026-05-23)",
            1,
        )

    text = text.replace(
        "Read more here: https://linwood.dev/butterfly/2.2.0-rc.2",
        "Read more here: https://linwood.dev/butterfly/2.2.0-rc.3",
        1,
    )

    text = replace_obvious_spelling(text)

    if text != original:
        path.write_text(text, encoding="utf-8")
        return True
    return False


def fix_metadata_changelogs(metadata_dir: Path) -> list[Path]:
    changed: list[Path] = []

    if not metadata_dir.exists():
        return changed

    for path in sorted(metadata_dir.glob("*.txt")):
        original = path.read_text(encoding="utf-8")
        text = replace_obvious_spelling(original)

        # This specifically targets metadata/en-US/changelogs/157.txt if it contains the wrong 2.2.0-rc.3 URL.
        text = text.replace(
            "Read more here: https://linwood.dev/butterfly/2.2.0-rc.2",
            "Read more here: https://linwood.dev/butterfly/2.2.0-rc.3",
        )

        if text != original:
            path.write_text(text, encoding="utf-8")
            changed.append(path)

    return changed


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--repo", type=Path, default=Path("."), help="Path to the Butterfly repo")
    parser.add_argument("--metadata", action="store_true", help="Also fix metadata/en-US/changelogs/*.txt")
    args = parser.parse_args()

    repo = args.repo
    changelog = repo / "CHANGELOG.md"
    metadata_dir = repo / "metadata" / "en-US" / "changelogs"

    if not changelog.exists():
        raise SystemExit(f"CHANGELOG.md not found: {changelog}")

    changed_changelog = fix_changelog(changelog)
    changed_metadata = fix_metadata_changelogs(metadata_dir) if args.metadata else []

    if changed_changelog:
        print(f"updated {changelog}")
    else:
        print(f"no changes needed in {changelog}")

    for path in changed_metadata:
        print(f"updated {path}")

    if args.metadata and not changed_metadata:
        print("no metadata changelog changes needed")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
