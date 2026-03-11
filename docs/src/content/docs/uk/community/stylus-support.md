---
title: Stylus support
---

This page collects the current stylus and pen-input behavior in Butterfly.

## Supported platforms

- **Android / mobile:** Stylus input works best and is the main supported path today.
- **Desktop (Windows/Linux):** Stylus input is currently limited by Flutter input support.
- **Web:** Often a good fallback when desktop stylus behavior is inconsistent.

## Stylus-related settings

You can find stylus-related options in **Settings → Input → Pen**:

- **Pen-only input** (changed in 2.5): helps avoid accidental finger/touch drawing when using a stylus.
- **Pen-only toggle on stylus detection:** when a stylus is detected, a quick Pen-only toggle is activated; you can still disable it in **Settings → Input → Pen**.
- **Ignore pressure:** useful when pressure data is unreliable. This is set to help with cases where Firefox reports incorrect pressure on first input.
- **Input test:** lets you verify what pointer/stylus events your device is currently reporting.

## Pen shortcuts and pointer test

Butterfly supports pen/stylus shortcuts (button mappings can vary by device/OS). If shortcuts do not behave as expected, open **Input test** first and check button values:

- **Primary button** commonly appears as `10` (`2`)
- **Secondary button** commonly appears as `100` (`4`) or `100000` (`32`)

These values are bit mappings from pointer button flags.

## Known framework limitations

Some stylus issues come from Flutter input handling rather than Butterfly directly.

- Android S-Pen tracking issue: [flutter/flutter#42846](https://github.com/flutter/flutter/issues/42846)
- Windows stylus issues: [flutter/flutter#65248](https://github.com/flutter/flutter/issues/65248), [flutter/flutter#102836](https://github.com/flutter/flutter/issues/102836)
- Linux stylus issue: [flutter/flutter#63209](https://github.com/flutter/flutter/issues/63209)

If your setup is affected, please still report it in Butterfly issues with your platform, device model, and app version.
