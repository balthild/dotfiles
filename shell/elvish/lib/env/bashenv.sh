for name in $(export | cut -d"=" -f1 | cut -d" " -f3); do
    export -n $name
done

. /etc/bashrc
. $HOME/.profile

export | sed -E "s/^declare -x //" | xargs -n 1 printf "%b\n"
