hook global ModuleLoaded bspwm %{
    require-module bspwm-repl
}

provide-module bspwm-repl %{

declare-option str replwin
declare-option str repl_ratio 0.7

define-command -docstring %{
  bspwm-repl [<arguments>]: create a new window for repl interaction
  All optional parameters are forwarded to the new window
  The window is spawned respecting the option repl-ration
  The window id is stored in the option replwin
} bspwm-repl -params 1.. -shell-completion %{
  nop %sh{ bspc node --presel-ratio $kak_opt_repl_ratio --presel-dir south }
  terminal %arg{@}
  set-option global replwin %sh{ bspc subscribe node_add -c 1 | cut -d' ' -f5 }
}

define-command -docstring %{
  bspwm-send-text: send the selected text or the arguments to the repl window
} bspwm-send-text -params 0.. %{
  evaluate-commands %sh{
    if [ $# = 0 ]; then
      printf %s "${kak_selection}" | xsel -i ||
      echo 'fail x11-send-text: failed to run xsel, see *debug* buffer for details'
    else
      printf "%s\\n" "$@" | xsel -i ||
      echo 'fail x11-send-text: failed to run xsel, see *debug* buffer for details'
    fi
    # The quotes are important to catch a failure when the option is not set
    bspc node "$kak_opt_replwin" --focus && xte <<EOF
keyup Control_L
keyup Control_R
keyup Super_L
keyup Super_R
keydown Shift_L
key Insert
keyup Shift_L
EOF
    [ $? = 0 ] || echo 'fail x11-send-text: failed to run xte, see *debug* buffer for details'
  }
  focus
}

alias global repl bspwm-repl
alias global send-text bspwm-send-text

}

