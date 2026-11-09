for pkg in $(pm list packages -d | cut -f 2 -d ':'); do
    pm enable --user 0 $pkg
done
