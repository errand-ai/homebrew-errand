# errand-ai/homebrew-errand

The official Homebrew tap for [ErrandDesktop](https://github.com/errand-ai/errand-desktop) —
a native macOS menu bar app that runs the Errand stack locally in containers.

## Install

```bash
brew tap errand-ai/errand
brew trust errand-ai/errand          # Homebrew 6+ only; see note below
brew install --cask errand-desktop
```

These are one-time steps.

Homebrew 6 refuses to load casks from a non-official tap until you trust it, so
`brew trust` is required here. It tells Homebrew you accept that this tap's cask
definition is third-party code. On Homebrew 5 and earlier the command does not exist
and is not needed — skip that line.

## Upgrade

```bash
brew upgrade --cask errand-desktop
```

Homebrew is the canonical upgrade channel for ErrandDesktop. The app itself does not
self-update — it only notifies you when a newer release exists.

## Uninstall

```bash
brew uninstall --cask errand-desktop
```

Add `--zap` to also remove the app's data in `~/Library/Application Support/ErrandDesktop`.

## Requirements

The cask installs a single universal (`arm64` + `x86_64`) build, so there is nothing
architecture-specific to choose.

| Hardware | macOS | Docker runtime | Apple Containerization |
| --- | --- | --- | --- |
| Apple silicon | 26+ (Tahoe) | Yes | Yes |
| Apple silicon | 15 (Sequoia) | Yes | No — requires macOS 26 |
| Intel | 15+ (Sequoia) | Yes | No — requires Apple silicon |
| Any | 14 and earlier | Not supported | Not supported |

The cask declares `depends_on macos: ">= :sequoia"`, so Homebrew refuses the install
on macOS 14 and earlier rather than dropping an unrunnable app into `/Applications`.

## Why this tap exists

ErrandDesktop is distributed from its own tap rather than the official
`homebrew-cask` repository. The official tap has notability and maturity expectations
plus a slower review cycle, and ErrandDesktop's release cadence is still settling.
Hosting the cask here lets a new release reach users the moment it is tagged. Once
install numbers justify it, submission to `homebrew-cask` — which would drop the
`brew tap` step — is the intended next move.

## How releases work

Each tagged release of `errand-ai/errand-desktop` publishes exactly one asset,
`ErrandDesktop.dmg`, signed and notarized by Apple. The cask resolves it as:

```
https://github.com/errand-ai/errand-desktop/releases/download/v#{version}/ErrandDesktop.dmg
```

That filename is a contract — no architecture or version suffix. The `livecheck`
block tracks the repository's GitHub Releases, so `brew upgrade` picks up new tags
automatically once the cask's `version` and `sha256` are bumped here.
