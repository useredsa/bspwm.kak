provide-module bspwm %{

# ensure that we're running in the right environment
evaluate-commands %sh{
    true #TODO
}

define-command -docstring %{
    bspwm-focus [<kakoune_client>]: focus a given client's window
    If no client is passed, then the current client is used
} bspwm-focus -params ..1 -client-completion %{
    evaluate-commands %sh{
        if [ $# -eq 1 ]; then
            printf "evaluate-commands -client '%s' focus" "$1"
        else
            bspc node $kak_client_env_WINDOWID --focus > /dev/null ||
            echo 'fail failed to run bspc node, see *debug* buffer for details'
        fi
    }
}

alias global focus bspwm-focus

}

