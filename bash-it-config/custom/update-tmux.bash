function update-tmux () {
    while read line
    do
        if [[ $line =~ ^- ]]
        then
            eval "unset ${line:1}"
        else
            eval "export ${line%=*}=\"${line#*=}\""
        fi
    done < <(tmux showenv)
}
