function bm_vpn_colo --description "Bookmap colo VPN connection"
    set -l vpn_dir /home/kostia/work/vpn/colo
    set -l config_file rg-fw01-ch4-UDP4-1195-stoder.ovpn

    if not test -f "$vpn_dir/$config_file"
        echo "VPN config file not found at $vpn_dir/$config_file"
        return 1
    end

    sudo openvpn --cd $vpn_dir --config $config_file
end
