function detect_path_overwrite {
    if [[ ! -f /etc/profile ]]; then return; fi

    local path_def=$(cat /etc/profile | grep 'PATH=')
    local does_it_append=$(echo $path_def | grep '$PATH')

    if [[ "${path_def}" != "" ]] && [[ "${does_it_append}" == "" ]]; then
        echo "WARNING: /etc/profile is completely overwriting the PATH variable!"
        echo "This file is loaded before zshenv, so it should not overwrite PATH changes made there."
        echo "Edit it and append a \$PATH to the end of the assignment."
    fi
}

detect_path_overwrite
