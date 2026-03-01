---
title: Stylus support
---

This page collects the current stylus and pen-input behavior in Butterfly.

## Supported platforms

- **Android / mobile:** Stylus input works best and is the main supported path today.
- **Desktop (Windows/Linux):** Stylus input is currently limited by Flutter input support.
- **Web:** Often a good fallback when desktop stylus behavior is inconsistent.

## Stylus-related settings

You can find stylus-related options in the app settings:

- **Pen-only input** (changed in 2.5): helps avoid accidental finger/touch drawing when using a stylus.
- **Ignore pressure:** useful when pressure data is unreliable. This is set to help with cases where Firefox reports incorrect pressure on first input.
- **Input test:** lets you verify what pointer/stylus events your device is currently reporting.

## Pen shortcuts

Butterfly supports pen/stylus shortcuts (for example, button mappings depending on your device and OS). If shortcuts do not behave as expected, verify behavior in the input test first to confirm the events are recognized.

## Known framework limitations

Some stylus issues come from Flutter input handling rather than Butterfly directly.

- Android S-Pen tracking issue: [flutter/flutter#42846](https://github.com/flutter/flutter/issues/42846)
- Windows stylus issues: [flutter/flutter#65248](https://github.com/flutter/flutter/issues/65248), [flutter/flutter#102836](https://github.com/flutter/flutter/issues/102836)
- Linux stylus issue: [flutter/flutter#63209](https://github.com/flutter/flutter/issues/63209)

If your setup is affected, please still report it in Butterfly issues with your platform, device model, and app version.
