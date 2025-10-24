# Nix for _Mission Python_

[![built with garnix](https://img.shields.io/endpoint?url=https%3A%2F%2Fgarnix.io%2Fapi%2Fbadges%2Fsellout%2Fmission-python-nix)](https://garnix.io/repo/sellout/mission-python-nix)
[![Nix CI](https://nix-ci.com/badge/gh:sellout:mission-python-nix)](https://nix-ci.com/gh:sellout:mission-python-nix)
[![Project Manager](https://img.shields.io/badge/%20-Project%20Manager-%235277C3?logo=nixos&labelColor=%23cccccc)](https://sellout.github.io/project-manager/)

A Nix environment for working through _Mission Python_

[_Mission Python_](https://nostarch.com/missionpython) is a book for learning [Python](https://www.python.org/) through a series of game implementations. This prevides a [Nix](https://nixos.org/) environment for the book’s exercises.

## development environment

We recommend the following steps to make working in this repository as easy as possible.

### `nix run github:sellout/project-manager -- switch`

This is sort-of a catch-all for keeping your environment up-to-date. It regenerates files, wires up the project’s Git configuration, ensures the shells have the right packages configured the right way, enables checks & formatters, etc.

If you already have it installed on your system or once you’ve run `direnv allow`, you can instead use `project-manager switch`.

### `direnv allow`

This command ensures that any work you do within this repository happens within a consistent reproducible environment. That environment provides various debugging tools, etc. When you leave this directory, you will leave that environment behind, so it doesn’t impact anything else on your system.

### `nix develop`

If you don’t have direnv installed, you can instead manually run `nix develop` to get into the _Mission Python_ environment.

## building & development

Once you are in the environment, you should be able to `cd source` and then follow through the book as written.

If there is no “source” directory, then you can manually run `unpackPhase` to create it.

To run the IDLE editor, as the book recommends, you can do

```bash
idle &
```
