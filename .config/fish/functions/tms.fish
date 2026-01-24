function tms --description "Tmux Sessionizer"
    set -l selected

    # 1. Handle Arguments
    if set -q argv[1]
        set selected $argv[1]
    else
        set -l search_paths \
            ~/fun \
            ~ \
            ~/work \

        set selected (find $search_paths -mindepth 1 -maxdepth 1 -type d 2>/dev/null | fzf)
    end

    if test -z "$selected"
        return 0
    end

    set -l selected_name (path basename $selected | string replace -a "." "_")

    if tmux has-session -t=$selected_name 2>/dev/null
        if test -z "$TMUX"
            tmux attach-session -t $selected_name
        else
            tmux switch-client -t $selected_name
        end
    else
        if test -z "$TMUX"
            tmux new-session -s $selected_name -c $selected
        else
            tmux new-session -ds $selected_name -c $selected
            tmux switch-client -t $selected_name
        end
    end
end
