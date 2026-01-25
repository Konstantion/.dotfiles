function bm_vpn_connect --description "Connect to Bookmap VPN (Options: eu, us, full)"
    set -l base_dir /home/kostia/work/openvpn-bookmap
    set -l config_dir "$base_dir/data/config"
    set -l script_path "$base_dir/app/linux/update-systemd-resolved"
    set -l login_conf "$config_dir/login.conf"

    set -l region eu
    if test (count $argv) -gt 0
        set region $argv[1]
    end

    set -l vpn_file
    switch $region
        case eu
            set vpn_file "Bookmap_eu.ovpn"
        case us
            set vpn_file "Bookmap_us.ovpn"
        case full
            set vpn_file "EU_full_route.ovpn"
        case '*'
            echo "Error: Unknown region '$region'. Use 'eu', 'us', or 'full'."
            return 1
    end

    if not test -f "$config_dir/$vpn_file"
        echo "Error: Config file not found at $config_dir/$vpn_file"
        return 1
    end

    echo "Connecting to Bookmap VPN ($region)..."

    sudo openvpn \
        --cd $config_dir \
        --config $vpn_file \
        --auth-user-pass $login_conf \
        --script-security 2 \
        --up $script_path \
        --down $script_path \
        --down-pre
end
