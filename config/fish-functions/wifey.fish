function wifey -d 'select wifi through wifi-menu and manage netctl-auto via systemd'
    sudo systemctl stop netctl-auto@wlp3s0
    sudo wifi-menu
    sudo systemctl stop netctl*
    sudo systemctl start netctl-auto@wlp3s0
end
