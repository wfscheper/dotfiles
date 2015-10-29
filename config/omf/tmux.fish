function tmux -a cmd -d "Wraps tmux to provide updatenv command"
    if test -z $cmd
        command tmux
    else
        switch $cmd
            case "updatenv"
                for var in (command tmux showenv)
                    switch $var
                        case '-*'
                            set -e (echo $var | sed 's/-//')
                        case '*'
                            eval set -x (echo $var | sed 's/=/ "/' | sed 's/$/"/')
                    end
                end
            case "*"
                command tmux $argv
        end
    end
end
