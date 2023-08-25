alias vscode="open -a Visual\ Studio\ Code.app"
alias aliases="vscode /Users/salomonebaquis/.oh-my-zsh/custom/aliases.zsh"
alias standup="open 'https://us02web.zoom.us/j/243002548?pwd=ajFSNHhWTkRGSmVodnpQajBacXhLQT09'"
alias slate-web="cd /Users/salomonebaquis/code/slate-web/"
alias zshrc="vscode /Users/salomonebaquis/.zshrc"
alias runslate="cd /Users/salomonebaquis/code/slate-web/ && make clear-public build start"
alias clayconfig="cat /Users/salomonebaquis/.clayconfig"
alias nano="/opt/homebrew/bin/nano"
alias check-elastic="lsof -i :9201"

ci() {
  clay export "$1" | sed "s/_components\/layout/_layouts\/layout/" | clay import --key local -p local.dev.slate.com
}
