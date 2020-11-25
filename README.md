## bspwm.kak

Integration of [bspwm] for [Kakoune].

[bspwm.kak] is a plugin that attempts to reimplement some core functions of Kakoune
programmed for [X] using bspwm features and add new specialized functionality.

[bspwm.kak]: https://github.com/useredsa/bspwm.kak
[bspwm]: https://github.com/baskerville/bspwm
[Kakoune]: https://kakoune.org
[X]: https://en.wikipedia.org/wiki/X_Window_System

## Initial Targets

The initial targets are

* Implementing a Kakoune command that spawns a window and return its node ID
to operate later on that window.

## Improvements over X11's module

* Dropped the dependency over [`xdotool`] in favor of `bspc`+[`xte`].

`xdotool` is said to be buggy.
After it stopped working with a recent update of my system for the traditional
`:x11-send-text` command,
I decided to replace the window management functionality with `bspc` and
the key simulation with `xte`.

[`xdotool`]: https://github.com/jordansissel/xdotool
[`xte`]: https://jlk.fjfi.cvut.cz/arch/manpages/man/xte.1

* 2 new Kakoune options `%opt{replwin}` and `%opt{repl_ratio}` to manage the
repl from Kakoune knowing its WID and setting the default split ratio.

* `:bspwm-send-text` works for bash.

The implementation of `:x11-send-text` relies on setting the repl's window title.
Unfortunately, some shells set the window title when loading the prompt.
You can disable this functionality by customizing the variable
`PROMPT_COMMAND` in bash.
bspwm.kak, on the other hand, works out of the box because
the repl window is referenced through its node id.

* `:bspwm-send-text` sends its arguments or, if absent, the current selection.

* New command `:bspwm-popup` spawns a floating terminal.

## Installation

Source the scripts inside [`rc`].

[`rc`]: rc/

### Using @alexherbo2's [`plug.kak`](https://github.com/alexherbo2/plug.kak)

```kak
plug bspwm https://github.com/useredsa/bspwm.kak %{
    set -add global windowing_modules bspwm
    require-module connect-bspwm
}
```

### Using @robertmeta's [`plug.kak`](https://github.com/robertmeta/plug.kak)

```kak
plug "useredsa/bspwm.kak" %{
    set -add global windowing_modules bspwm
    require-module connect-bspwm
}
```

## Connect Integration

It is intended to maintain integration with [connect.kak] whenever it is useful,
but it will always be optional.

Currently, `:bspwm-popup` is aliased to `popup` and
will work with `:connect-popup`.

[connect.kak]: https://github.com/alexherbo2/connect.kak

