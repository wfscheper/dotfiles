# personal aliases
function vimgo --wraps vim --description 'open all non-vendor go source files'
    vim (find . -type f -name '*.go' | grep -v '/vendor/') $argv
end
