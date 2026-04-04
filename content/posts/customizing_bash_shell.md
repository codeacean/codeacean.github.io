+++
title = "Customizing The Bash Shell"
description = "Ways to customizing bash shell"
date = 2025-11-28
updated = 2026-01-23
draft = false

[taxonomies]
categories = ["programming"]
tags = ["bash"]

[extra]
lang = "en"
toc = true
comment = false
copy = false
math = false
mermaid = false
featured = false
reaction = true
+++

### Before Anything

**BASH - Bourne Again Shell**

Bash used for General-purpose programming and scripting and also a 'Shell' (This mixed here). Most people now just use Zsh or Fish. But I think Bash is actually better than any other shell. Because, its stability and broad compatibility. Also the general command-line use across most Unix systems.


**Tools mentioned:** ble.sh, Starship, fzf

- ble.sh — replaces Readline with syntax highlighting, autosuggestions, vim/emacs modes, better completion
- fzf — fuzzy finder that revolutionizes history search, file navigation, git operations
- Starship — cross-shell prompt that is minimal, fast, git-aware, and highly customizable

>**Install these first**

### Configure bash first

You can enable Vi/Vim mode in your shell by adding `set -o vi`. And use the shell like Vim (I mean the keys).
First thing you need to do after installing fzf and Starship is setting up paths:
add this 
``` bash
eval "$(fzf --bash)"
eval "$(starship init bash)"
```
You don't have to customize ble.sh and fzf for basic use, for customizing Starship, you can find official [presets here](https://starship.rs/presets/)

You can bind keys for shortcuts, add aliases and create function.
Here's is an example:
``` bash
# create function:
open_file() {
  local file
  file=$(fzf --preview 'bat --style=numbers --color=always {}' --border --select-1 --exit-0)
  if [[ -n "$file" ]]; then
    nvim "$file"
  fi
}


# Bind key: run the function
bind '"\C-f":"open_file\n"'

#Alias
alias kiss = 'mkdir -p'  # since touch used to create new file!
```

Just like that, when you enter Ctrl+f, it runs the function (in this function it will open a selected file with fzf). 

### Some different (and pros)
Bash is good enough for everything, default everywhere, POSIX + useful extras.The main differences show up when scripts grow or need real structure.
Bash's error handling is clunky (fighting with `$?`, `set -euo pipefail`, and traps), data structures are weak (arrays yes, but proper dicts only since 
Bash 4+, and no easy sets/objects), and anything beyond integer math or complex JSON parsing forces you into awk/jq/bc hacks that hurt readability fast.

``` bash
# Example
set -euo pipefail  # strict mode
trap 'echo "Error on line $LINENO"' ERR
```

The key pros of Bash shine brightest for fast, lightweight, system-level automation.

**Shell**: While zsh and fish feel snappier out-of-the-box with built-in autosuggestions and nicer syntax, Bash remains king for pure compatibility. Every Linux distro, container , and cloud VM has Bash — no surprises when your script runs on a minimal server. Zsh scripts are mostly portable, but fish syntax breaks POSIX/Bash compatibility hard, so you end up rewriting things anyway. If you're scripting a lot (cron jobs, Dockerfiles), Bash's "write once, run everywhere" wins. Interactive use? That's where ble.sh + fzf + Starship close the gap — you get highlighting/suggestions +  fuzzy finding, but stay in Bash. Also, 'Oh My Bash' for plugins.

### Bash Scripting Guide

[Bash Guide](https://mywiki.wooledge.org/BashGuide) :respected community resources with in-depth Bash Guide, FAQ, Pitfalls, and best practices.
You can find more documentation on the internet. [see this reddit post](https://www.reddit.com/r/bash/comments/1niobmh/documentation_for_bash/)

