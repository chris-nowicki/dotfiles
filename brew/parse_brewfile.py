with open("Brewfile", "r") as file:
    lines = file.readlines()

with open("Brewfile", "w") as file:
    for line in lines:
        if line.startswith("cask"):
            line = line.strip() + ", args: { no_quarantine: true }\n"
        file.write(line)