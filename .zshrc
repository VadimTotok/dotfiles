# =========================
# Powerlevel10k instant prompt
# =========================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# =========================
# Oh My Zsh
# =========================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=( git zsh-syntax-highlighting zsh-autosuggestions )

source "$ZSH/oh-my-zsh.sh"

# =========================
# Aliases
# =========================
alias ff="fastfetch -c '$HOME/Документы/GitHub/dotfiles/config/fastfetch/fetch.json'c"
alias sysup="sudo apt update && sudo apt upgrade -y"

# =========================
# Powerlevel10k config
# =========================
[[ -f "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"
