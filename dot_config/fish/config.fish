## Source from conf.d before our fish config
source /usr/share/cachyos-fish-config/conf.d/done.fish

# Set values
## Run fastfetch as welcome message
function fish_greeting
    fastfetch
end

# Format man pages
set -x MANROFFOPT -c
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low

## Environment setup
# Apply .profile: use this to put fish compatible .profile stuff in
if test -f ~/.fish_profile
    source ~/.fish_profile
end

# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

# Add depot_tools to PATH
if test -d ~/Applications/depot_tools
    if not contains -- ~/Applications/depot_tools $PATH
        set -p PATH ~/Applications/depot_tools
    end
end

## Functions
# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
    switch (commandline -t)
        case "!"
            commandline -t $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function __history_previous_command_arguments
    switch (commandline -t)
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ]

    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
end

# Fish command history
function history
    builtin history --show-time='%F %T '
end

function backup --argument filename
    cp $filename $filename.bak
end

# Copy DIR1 DIR2
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
        set from (echo $argv[1] | trim-right /)
        set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

## Useful aliases
# Replace ls with eza
alias ls='eza -al --color=always --group-directories-first --icons' # preferred listing
alias la='eza -a --color=always --group-directories-first --icons' # all files and dirs
alias ll='eza -l --color=always --group-directories-first --icons' # long format
alias lt='eza -aT --color=always --group-directories-first --icons' # tree listing
alias l.="eza -a | grep -e '^\.'" # show only dotfiles

# Common use
alias grubup="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias wget='wget -c '
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias hw='hwinfo --short' # Hardware Info
alias big="expac -H M '%m\t%n' | sort -h | nl" # Sort installed packages according to size in MB
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l' # List amount of -git packages
alias update='sudo pacman -Syu'
alias bye='shutdown -h now'
alias sleep='sudo systemctl suspend'
alias reboot='sudo systemctl reboot'

# Get fastest mirrors
alias mirror="sudo cachyos-rate-mirrors"

# Help people new to Arch
alias apt='man pacman'
alias apt-get='man pacman'
alias please='sudo'
alias tb='nc termbin.com 9999'

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# Internet Radio
alias dronezone="mpv http://api.somafm.com/dronezone.pls"
alias groovesalad="mpv http://api.somafm.com/groovesalad.pls"
alias deepspaceone="mpv http://api.somafm.com/deepspaceone.pls"
alias spacestation="mpv http://api.somafm.com/spacestation.pls"
alias anotherplanet="mpv http://stream.anotherplanet.fm:8000/stream.mp3"
alias psyradio="mpv http://host.psyradio.fm:8020/;listen.mp3"
alias egochillout="mpv https://streams.egofm.de/egoCHILLOUT-hq"
alias egosun="mpv https://streams.egofm.de/egoSUN-hq"
alias egoflash="mpv https://streams.egofm.de/egoFLASH-hq"
alias egofm="mpv https://streams.egofm.de/egoFM-hq"
alias sleepingpill="mpv http://s.stereoscenic.com/asp-h.pls"
alias schizoid="mpv http://schizoid.in/schizoid-chill.pls"
alias costadelmar="mpv https://radio4.cdm-radio.com:18020/stream-mp3-Chill"
alias amambient="mpv http://radio.stereoscenic.com/ama-h"
alias zerobeat="mpv http://zerobeatzone.mrg.fm:8800/stream3"
alias ambientradio="mpv http://listen.mrg.fm:8888/stream"
alias egorap="mpv https://streams.egofm.de/egoRAP-hq"
alias cliqhop="mpv http://api.somafm.com/cliqhop.pls"
alias defcon="mpv http://api.somafm.com/defcon.pls"
alias dubstep="mpv http://api.somafm.com/dubstep.pls"
alias groovesaladclassic="mpv http://api.somafm.com/gsclassic.pls"
alias missioncontrol="mpv http://api.somafm.com/missioncontrol.pls"
alias secretagent="mpv http://api.somafm.com/secretagent.pls"
alias seventies="mpv http://api.somafm.com/seventies.pls"
alias synphaer="mpv http://api.somafm.com/synphaera.pls"

# custom alias
alias vim="nvim"
alias v="nvim"
alias y="yazi"
alias c="claude"
alias s="spotify_player"

# fish
function fish_user_key_bindings
    # Load Emacs bindings for insert mode first
    fish_default_key_bindings -M insert

    # Then load Vi bindings (preserving Emacs bindings where no conflict)
    fish_vi_key_bindings --no-erase insert
end
set -g fish_key_bindings fish_user_key_bindings

# fzf 
fzf_configure_bindings --directory=\cd --processes=\cp --git_status=\cg --history=\ch

# zoxide
zoxide init fish | source
zoxide init fish --cmd cd | source

# yazi
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# set nvim a standard editor
set -gx EDITOR /usr/bin/nvim
set -gx VISUAL /usr/bin/nvim
