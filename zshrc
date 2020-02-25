# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# extra files in ~/.zsh/configs/pre , ~/.zsh/configs , and ~/.zsh/configs/post
# these are loaded first, second, and third, respectively.
_load_settings() {
  _dir="$1"
  if [ -d "$_dir" ]; then
    if [ -d "$_dir/pre" ]; then
      for config in "$_dir"/pre/**/*(N-.); do
        if [ ${config:e} = "zwc" ] ; then continue ; fi
        . $config
      done
    fi

    for config in "$_dir"/**/*(N-.); do
      case "$config" in
        "$_dir"/pre/*)
          :
          ;;
        "$_dir"/post/*)
          :
          ;;
        *)
          if [[ -f $config && ${config:e} != "zwc" ]]; then
            . $config
          fi
          ;;
      esac
    done

    if [ -d "$_dir/post" ]; then
      for config in "$_dir"/post/**/*(N-.); do
        if [ ${config:e} = "zwc" ] ; then continue ; fi
        . $config
      done
    fi
  fi
}
_load_settings "$HOME/.zsh/configs"

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

plugins=(bash git github npm sublime yarn)

# Prevent `vault write` commands from being stored in history.
function vault () {
  command vault "$@"
  if [[ $1 == write ]]; then history -d $((HISTCMD-1)) &> /dev/null; fi
}

export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
COMPLETION_WAITING_DOTS="true"
source $ZSH/oh-my-zsh.sh
export SSH_KEY_PATH="~/.ssh/rsa_id"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export SILENCE_RBENV_DEPRECATION=1

export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/dan/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/dan/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/dan/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/dan/google-cloud-sdk/completion.zsh.inc'; fi
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/libffi/lib:$PATH"
export LDFLAGS="-L/usr/local/opt/libffi/lib"
export PKG_CONFIG_PATH="/usr/local/opt/libffi/lib/pkgconfig"
