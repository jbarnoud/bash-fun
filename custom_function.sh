# Install an ipython kernel for the current virtual environment.
function install-kernel {
    if [[ -n ${VIRTUAL_ENV} ]]
    then
        ve_name=$(basename ${VIRTUAL_ENV})
        pyver=$(python --version | cut -f 1 -d .)
        if [[ -d "$(jupyter --data-dir)/kernels/${ve_name}" ]]
        then
            echo "The kernel is already installed."
            return 0
        else
            python -m ipykernel --version || pip install ipykernel
            python -m ipykernel install --user \
                --name ${ve_name} --display-name "${pyver} (${ve_name})"
            return $?
        fi
    else
        echo "Only works in a virtual environment."
        return 1
    fi
}


# Open a ssh tunel to a port on md79
# The first argument is the port on md79,
# the second argument is the port on localhost.
function tunnel79 {
    if [[ "$#" != 2 ]]
    then
        echo "Arguments must be <port on md79> <port on localhost>."
        return 1
    fi
    remote_port=$1
    local_port=$2
    ssh -fNL ${remote_port}:localhost:${local_port} md79-deep
}
