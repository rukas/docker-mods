#!/usr/bin/with-contenv bash
# ==============================================================================
# Code Server with Home Assistant Add-ons
# Persists user settings
# ==============================================================================
readonly GIT_USER_PATH=/config/git
readonly SSH_USER_PATH=/config/.ssh
readonly ZSH_HISTORY_FILE=/root/.zsh_history
readonly ZSH_HISTORY_PERSISTANT_FILE=/config/.zsh_history

# Store SSH settings in add-on data folder
if [ ! -d "$SSH_USER_PATH" ]; then
    mkdir -p ${SSH_USER_PATH}
fi
ln -s "${SSH_USER_PATH}" ~/.ssh

# Sets up ZSH shell
touch "${ZSH_HISTORY_PERSISTANT_FILE}"

chmod 600 "$ZSH_HISTORY_PERSISTANT_FILE"

ln -s -f "$ZSH_HISTORY_PERSISTANT_FILE" "$ZSH_HISTORY_FILE"

# Store user GIT settings in add-on data folder
if [ ! -f "$GIT_USER_PATH" ]; then
    mkdir -p ${GIT_USER_PATH}
    chmod 700 "${GIT_USER_PATH}"
fi

if [ ! -d "${GIT_USER_PATH}/.gitconfig" ]; then
    touch "${GIT_USER_PATH}/.gitconfig"
fi
ln -s "${GIT_USER_PATH}/.gitconfig" ~/.gitconfig
