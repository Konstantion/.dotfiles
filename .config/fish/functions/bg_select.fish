function bg_select --description "Select background via fzf"
    set -l img_dir ~/backgrounds

    set -l selected (path basename $img_dir/* | fzf)

    if test -n "$selected"
        feh --bg-center "$img_dir/$selected"
    end
end
