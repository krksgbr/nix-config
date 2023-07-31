# ANSI color codes
declare -A colors=(
  [Black]=0 [Red]=1 [Green]=2 [Yellow]=3
  [Blue]=4 [Magenta]=5 [Cyan]=6 [White]=7
  [BrightBlack]=60 [BrightRed]=61 [BrightGreen]=62 [BrightYellow]=63
  [BrightBlue]=64 [BrightMagenta]=65 [BrightCyan]=66 [BrightWhite]=67
)

echo "Foreground Colors:"
for color in "${!colors[@]}"; do
  code=${colors[$color]}
  echo -en "\033[$((code + 30))m $color \033[0m"
done

echo -e "\n\nBackground Colors:"
for color in "${!colors[@]}"; do
  code=${colors[$color]}
  echo -en "\033[$((code + 40))m $color \033[0m"
done

echo -e "\n"

