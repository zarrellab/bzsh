# BZSH

My custom configuration with setup scripts.

## Installation

1. Install Xcode Command Line Tools:

    ```console
    xcode-select --install
    ```

1. Clone the repository:

    ```console
    git clone --recursive https://github.com/zarrellab/bzsh.git "${ZDOTDIR:-$HOME}/.bzsh"
    ```

1. cd to scripts directory, run `init-setup`, and follow steps:

    ```console
    cd ~/.bzsh/scripts
    bash init-setup
    ```

1. Manually symlink each config from `./configs`

    ```console
    cd ~/.bzsh/configs
    ```

    Symlink command template:

    ```console
    ln -s CONFIG_PATH "~/.CONFIG_PATH"
    ```

1. Restart.

## Updating

To update homebrew packages, run `brewU`.
To update zinit plugins, run `zinit-update`.

## Customization

I highly recommend that you fork this project so that you can commit your own customizations.
