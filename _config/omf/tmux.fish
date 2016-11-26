function tmux -a cmd -d "Wraps tmux to provide updatenv command"
  if test -z $cmd
    command tmux
  else
    switch $cmd
      case "updatenv"
        for var in (command tmux showenv)
          switch $var
            case '-*'
              eval (echo $var | sed -e 's/-/set -eg /')
            case '*'
              eval (echo $var | sed -e 's/^/set -xg /' -e 's/=/ "/' -e 's/$/"/')
          end
        end
      case "*"
        command tmux $argv
    end
  end
end
