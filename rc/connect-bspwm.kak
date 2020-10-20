provide-module connect-bspwm %{

define-command -docstring %{
    bspwm-repl [<arguments>]: create a new connected window for repl interaction
    All optional parameters are forwarded to the new window
    The window is spawned respecting the option repl-ration
    The window id is stored in the option replwin
} bspwm-repl -override -params .. -shell-completion %{
    nop %sh{ bspc node --presel-ratio $kak_opt_repl_ratio --presel-dir south }
    connect-terminal %arg{@}
    set-option global replwin %sh{ bspc subscribe node_add -c 1 | cut -d' ' -f5 }
}

}
