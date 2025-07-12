{pkgs, ...}: let
  # This wrapper script provides a convenient interface for managing personal navi cheatsheets.
  # Features:
  # - `cheat e` or `cheat edit` without args: Shows all personal cheatsheets in fzf for selection
  # - `cheat e <pattern>` or `cheat edit <pattern>`: Searches for cheatsheets starting with <pattern>
  #   - If one match: Opens it directly in neovim
  #   - If multiple matches: Shows matches in fzf for selection
  #   - If no matches: Offers to create a new cheatsheet with that name
  # - Any other commands/arguments are passed directly to navi
  #
  # The personal collection is stored at "$(navi info cheats-path)/personal"
  cheatScript = pkgs.writeShellApplication {
    name = "cheat";

    runtimeInputs = [
      pkgs.navi
      pkgs.fd
      pkgs.fzf
      pkgs.neovim
    ];

    text = ''
      # Get the personal cheat path
      PERSONAL_CHEATS="$(navi info cheats-path)/personal"

      # Handle no arguments - just forward to navi
      if [[ $# -eq 0 ]]; then
        navi
        exit $?
      fi

      # Handle the edit command
      if [[ "$1" == "e" || "$1" == "edit" ]]; then
        # Check if a pattern was provided
        if [[ $# -eq 1 || -z "$2" ]]; then
          # No pattern provided, show all files in personal collection
          echo "Showing all files in personal collection:"
          MATCHES=$(fd . "$PERSONAL_CHEATS" --type f)
          SELECTED=$(echo "$MATCHES" | fzf --height 40% --layout=reverse --border)
          if [[ -n "$SELECTED" ]]; then
            nvim "$SELECTED"
            exit 0
          else
            echo "No file selected."
            exit 0
          fi
        fi

        # Search for files that start with the given pattern
        # Using fd for improved file search
        MATCHES=$(fd "^$2" "$PERSONAL_CHEATS" --type f)

        # Check if matches is empty
        if [[ -z "$MATCHES" ]]; then
          echo "No matches found for pattern '$2' in $PERSONAL_CHEATS"
          echo -n "Would you like to create a new file named '$2.cheat'? [y/N] "
          read -r CREATE_FILE
          if [[ "$CREATE_FILE" =~ ^[Yy]$ ]]; then
            # Create the directory if it doesn't exist
            mkdir -p "$PERSONAL_CHEATS"
            # Create and open the new file
            nvim "$PERSONAL_CHEATS/$2.cheat"
            exit 0
          else
            echo "File creation canceled."
            exit 0
          fi
        else
          # Count the number of matches
          MATCH_COUNT=$(echo "$MATCHES" | wc -l)

          if [[ "$MATCH_COUNT" -eq 1 ]]; then
            # Directly open the single match
            nvim "$MATCHES"
          else
            # Multiple matches, use fzf to select
            SELECTED=$(echo "$MATCHES" | fzf --height 40% --layout=reverse --border)
            if [[ -n "$SELECTED" ]]; then
              nvim "$SELECTED"
            else
              echo "No file selected."
              exit 0
            fi
          fi
        fi
      else
        # Forward all other commands and arguments to navi
        navi "$@"
      fi
    '';
  };
in {
  # Add cheatScript and its dependencies (optional but recommended for clarity)
  hm.home.packages = [
    cheatScript
    pkgs.navi
  ];

  hm.programs.zsh.initContent = ''
    # Install navi zsh widget
    # Binds itself to `ctrl+g`
    eval "$(navi widget zsh)"
  '';
}
