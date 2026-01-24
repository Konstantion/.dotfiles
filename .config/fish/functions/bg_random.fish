function bg_random --description "Set random background. Usage: bg_random [scale|center]"
    set -l mode "scale"
    if set -q argv[1]
        set mode $argv[1]
    end

    set -l img_dir ~/backgrounds
    set -l state_file ~/.config/scripts/temp/.current_bg

    mkdir -p (path dirname $state_file)

    set -l current_bg ""
    if test -f $state_file
        set current_bg (cat $state_file)
    end

    set -l images (path basename $img_dir/*)

    if test (count $images) -eq 0
        echo "No images found in $img_dir"
        return 1
    end

    set -l selected $images[(random 1 (count $images))]

    if test (count $images) -gt 1
        while test "$selected" = "$current_bg"
            set selected $images[(random 1 (count $images))]
        end
    end

    feh --bg-$mode "$img_dir/$selected"
    echo "$selected" > $state_file
end
