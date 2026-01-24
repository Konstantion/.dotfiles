function shot --description "Smart Screenshot: 'shot' for area, 'shot full' for fullscreen"
    set -l save_dir ~/Pictures/Screenshots
    mkdir -p $save_dir

    if type -q flameshot
        if contains "full" $argv
            flameshot full --path $save_dir
            echo "Full screenshot saved to $save_dir"
        else
            flameshot gui --path $save_dir
        end

    else if type -q gnome-screenshot
        if contains "full" $argv
            gnome-screenshot --file="$save_dir/Screenshot_$(date +%F_%T).png"
            echo "Screenshot saved to $save_dir"
        else
            gnome-screenshot -a --file="$save_dir/Screenshot_$(date +%F_%T).png"
        end

    else if type -q scrot
        if contains "full" $argv
            scrot "$save_dir/%Y-%m-%d_%H-%M-%S.png"
        else
            scrot --select "$save_dir/%Y-%m-%d_%H-%M-%S.png"
        end
    else
        echo "Error: No screenshot tool found. Install flameshot, gnome-screenshot, or scrot."
        return 1
    end
end
