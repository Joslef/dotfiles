#!/bin/sh
# logiops setup: writes /etc/logid.cfg and udev rule for MX Master 3
# This script re-runs whenever its content changes (chezmoi run_onchange)

set -e

# Write logid config
cat > /tmp/logid.cfg.tmp << 'LOGIDEOF'
devices: ({
  name: "Wireless Mouse MX Master 3";

  dpi: 2000;

  smartshift: {
    on: true;
    threshold: 15;
  };

  hiresscroll: {
    hires: true;
    invert: false;
    target: false;
  };

  buttons: (
    {
      // Thumb button -> toggle ratchet/free-spin
      cid: 0xc3;
      action = {
        type: "ToggleSmartshift";
      };
    },
    {
      // Middle click -> Super+Tab (quickshell overview)
      cid: 0x52;
      action = {
        type: "Keypress";
        keys: ["KEY_LEFTMETA", "KEY_TAB"];
      };
    }
  );
});
LOGIDEOF

sudo install -m 644 /tmp/logid.cfg.tmp /etc/logid.cfg
rm /tmp/logid.cfg.tmp

# Write udev rule
printf 'ACTION=="add", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c52b", RUN+="/usr/bin/systemctl --no-block restart logid.service"\n' \
  | sudo tee /etc/udev/rules.d/99-logitech-logid-restart.rules > /dev/null

sudo udevadm control --reload-rules

# Install set-logid-dpi helper (used by cycle-dpi.sh)
printf '#!/bin/bash\nDPI="$1"\nif [[ ! "$DPI" =~ ^[0-9]+$ ]]; then echo "Invalid DPI" >&2; exit 1; fi\nsed -i "s/dpi: [0-9]*/dpi: $DPI/" /etc/logid.cfg\n' \
  | sudo tee /usr/local/bin/set-logid-dpi > /dev/null
sudo chmod 755 /usr/local/bin/set-logid-dpi

# Allow user to run set-logid-dpi without password
printf 'joerg ALL=(ALL) NOPASSWD: /usr/local/bin/set-logid-dpi\n' \
  | sudo tee /etc/sudoers.d/logid-dpi > /dev/null

# Enable and restart logid
sudo systemctl enable --now logid
sudo systemctl restart logid
