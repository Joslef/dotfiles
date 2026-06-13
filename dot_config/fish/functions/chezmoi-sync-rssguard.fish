function chezmoi-sync-rssguard
    python3 -c "
import re
with open('/home/joerg/.config/rssguard5/config/config.ini') as f:
    content = f.read()
cleaned = re.sub(r'\[cookies\][^\[]*', '[cookies]\n\n', content, flags=re.DOTALL)
with open('/home/joerg/.local/share/chezmoi/dot_config/rssguard5/config/config.ini', 'w') as f:
    f.write(cleaned)
print('Cookies stripped, settings written to chezmoi source.')
"
    git -C ~/.local/share/chezmoi diff --stat dot_config/rssguard5/
end
