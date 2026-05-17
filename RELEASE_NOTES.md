# turnintoserver 1.2.1 menu bar crash fix

Original project: https://github.com/QianYushi/turnintoserver

Fixed fork: https://github.com/HenryLee789/turnintoserver

## What changed

This release is based on upstream `v1.2` and fixes a reproduced macOS menu bar crash.

The crash showed up as:

```text
NSInvalidArgumentException: attempt to insert nil object from objects[0]
```

The failing path was:

```text
displayMetricsDidChange -> updateStatusButton -> MenuBarStatusIconRenderer.statusDot -> CoreText
```

The status dot no longer uses `NSAttributedString.size()` / CoreText to draw the `S/B` letter. It now draws the status letter with `NSBezierPath`, keeping the visual state marker while avoiding the crashing font/rendering path.

## Validation

- Built successfully with Xcode Release configuration.
- Launched the fixed app from the build output.
- Replaced and launched `/Applications/turnintoserver.app` locally.
- Confirmed no new `turnintoserver` crash report appeared after launch.
- Confirmed recent system logs did not contain the previous `NSInvalidArgumentException`.

## Install note

If this build is distributed without Developer ID notarization, macOS may warn that it cannot verify the developer. In that case, right-click the app and choose Open the first time.
