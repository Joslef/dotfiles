if status is-interactive
    # Commands to run in interactive sessions can go here

    # select text with v and copy with y
    bind -M visual v begin-selection
    bind -M visual y fish_clipboard_copy

    #start neofetch
    # neofetch

    # alias definitions
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
    alias ls="eza --long --icons --header --sort=created --group-directories-first"
    alias lsa="eza --long --icons --all --header --sort=created --group-directories-first"
    alias uptodate="brew update; brew outdated; brew upgrade; brew cleanup; mas upgrade"
    alias vim="nvim"
    alias v="nvim"
    alias c="claude"
    alias y="yazi"
    alias s="spotify_player"

    # fish shell
    # no fish welcome message
    set -g fish_greeting
    fish_vi_key_bindings
    # Set ctrl+f to also work in insert mode:
    # Bind Ctrl+F to move forward / accept suggestion in default mode
    bind ctrl-f forward-char
    # If you use Vi-mode, also bind it for insert mode:
    if bind -M insert >/dev/null 2>&1
        bind -M insert ctrl-f forward-char
    end

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

end
export PATH="$HOME/.local/bin:$PATH"
