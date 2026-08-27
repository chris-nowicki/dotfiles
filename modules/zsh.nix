{ ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true; # replaces brew zsh-autosuggestions
    syntaxHighlighting.enable = true; # replaces brew zsh-syntax-highlighting
    enableCompletion = true; # HM runs a cached compinit (fixes the unguarded compinit)

    # Login-shell setup (.zprofile). Preserves what HM would otherwise clobber:
    # Homebrew's shellenv (casks + tools not yet migrated to Nix) and nvm
    # (Node is intentionally left to nvm, not pinned in Nix).
    profileExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"

      export NVM_DIR="$HOME/.nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
      [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    '';

    history = {
      size = 10000;
      save = 10000;
      path = "$HOME/.zhistory";
      share = true; # share_history
      expireDuplicatesFirst = true; # hist_expire_dups_first
      ignoreDups = true; # hist_ignore_dups
    };

    # Shared aliases. Work-only helpers (gcw/gcwm) live in hosts/work-laptop.nix.
    shellAliases = {
      bu = "brew upgrade";
      c = "clear";
      ls = "eza --icons=always --group-directories-first";
      ll = "eza -l --git --header --git-ignore --icons=always --group-directories-first";
      lla = "eza -la --git -T --header --git-ignore --ignore-glob=\".git\" --group-directories-first";
      rz = "source ~/.zshrc";
      flushdns = "sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder";

      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";

      nd = "npm run dev";
      nb = "npm run build";
      pd = "pnpm run dev";
      pb = "pnpm run build";
      lg = "lazygit";

      # Git aliases
      g = "git";
      gs = "git status";
      ga = "git add";
      gaa = "git add --all";
      gc = "git commit -m";
      gca = "git commit --amend";
      gco = "git checkout";
      gcb = "git checkout -b";
      gb = "git branch";
      gbd = "git branch -d";
      gp = "git push";
      gpf = "git push --force-with-lease";
      gpu = "git push -u origin HEAD";
      gl = "git pull";
      gf = "git fetch";
      gfa = "git fetch --all --prune";
      gd = "git diff";
      gds = "git diff --staged";
      glog = "git log --oneline --graph --decorate";
      gst = "git stash";
      gstp = "git stash pop";
      gcl = "git clone";
      gm = "git merge";
      gr = "git rebase";
      gri = "git rebase -i";
    };

    initContent = ''
      export HOMEBREW_NO_ENV_HINTS=1
      typeset -U path PATH

      setopt hist_verify

      # completion using arrow keys (based on history)
      bindkey '^[[A' history-search-backward
      bindkey '^[[B' history-search-forward

      # Prompt
      eval "$(starship init zsh)"

      # Consolidated PATH additions (was two scattered exports in .zshrc)
      export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

      # Prune remote-tracking refs and delete local branches whose upstream is gone
      # Usage: gone            # safe delete (-d, refuses unmerged)
      #        gone -f | -D    # force delete (-D)
      gone() {
        local flag="-d"
        case "$1" in
          -f|-D|--force) flag="-D" ;;
        esac
        git fetch --prune || return
        local branches
        branches=$(git branch -vv | awk '/: gone]/{print $1}')
        if [ -z "$branches" ]; then
          echo "No gone branches."
          return
        fi
        echo "$branches" | xargs git branch "$flag"
      }
    '';
  };

  # Smart directory jumping (z). Module handles the init + zsh integration.
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
