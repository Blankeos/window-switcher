<h1>Window Switcher</h1>

`Cmd` + `~` is my most-used Mac shortcut. It's a nifty keyboard shortcut for
switching between windows of the same app. I was able to recreate it on Windows
using [AHK](https://www.autohotkey.com/).

<h2>Table of Contents</h2>

- [📃 Requirements](#%F0%9F%93%83-requirements)
- [🚀 Getting Started](#%F0%9F%9A%80-getting-started)
- [Auto-Run on Startup](#auto-run-on-startup)
- [🎨 Features](#%F0%9F%8E%A8-features)

## 📃 Requirements

- Install [Autohotkey V2](https://www.autohotkey.com/)

## 🚀 Getting Started

1. Double-click on `SwitchCurrentWindow.ahk` to run it.
2. Press `Alt` + `~`

## Auto-Run on Startup

1. Press 🪟 + R and type: `shell:startup`
2. Paste `SwitchCurrentWindow.ahk` there.

## 🎨 Features

- [x] Basic same-app window switching across 2 windows.
- [x] Smart order-aware switching: Same-app window switching across more than 2 windows.
- [ ] ~~Same-app window switching across different windows Desktops.~~ (This is also not possible in Mac, so I'd rather not implement it).
