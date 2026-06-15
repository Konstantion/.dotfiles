function ghist
    if test (count $argv) -lt 2
        echo "Usage: ghist <pattern> <file-path>"
        return 1
    end

    set pattern $argv[1]
    set file_path $argv[2]

    set commits (git rev-list --all -- $file_path)

    if test -z "$commits"
        echo "No history found for $file_path"
        return 1
    end

    git grep -i -n $pattern $commits -- $file_path
end
