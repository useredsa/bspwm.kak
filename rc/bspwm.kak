provide-module bspwm %{

# ensure that we're running in the right environment
evaluate-commands %sh{
  true #TODO
}

require-module x11

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

define-command -docstring %{
  bspwm-popup <program> [<arguments>]: spawn a new floating terminal
} bspwm-popup -params 1.. -shell-completion %{
  nop %sh{ bspc rule --add '*' --one-shot state=floating }
  x11-terminal %arg{@}
}

define-command -docstring %{
  bspwm-fullscreen <program> [<arguments>]: spawn a new fullscreen terminal
} bspwm-fullscreen -params 1.. -shell-completion %{
  nop %sh{ bspc rule --add '*' --one-shot state=fullscreen }
  x11-terminal %arg{@}
}

alias global focus bspwm-focus
alias global popup bspwm-popup
alias global fullscreen bspwm-fullscreen

}

