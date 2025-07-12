lines=$(tput lines)

if [[ "$lines" -lt 15 ]]; then
    export GHOSTTY_QUICK=1
    "$HOME/.config/konfigue/scripts/aerospace-focus-window.sh"
    exit
else
    echo "We're in a normal terminal"
fi
