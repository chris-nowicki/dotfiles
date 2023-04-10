import os

with open(os.path.expanduser("~/.dotfiles/brew/Brewfile"), "r") as file:
    lines = file.readlines()

with open(os.path.expanduser("~/.dotfiles/brew/Brewfile"), "w") as file:
    for line in lines:
        if line.startswith("cask"):
            line = line.strip() + ", args: { no_quarantine: true }\n"
        file.write(line)