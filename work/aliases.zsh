alias vscode="open -a Visual\ Studio\ Code.app"

alias_path=/Users/salomonebaquis/.oh-my-zsh/custom/aliases.zsh
alias aliases="vscode '$alias_path'"
alias aliaspath="echo '$alias_path'"

alias standup="open 'https://meet.google.com/xmg-oetp-yag'"
alias meet="echo 'xmg-oetp-yag' | pbcopy && echo 'copied xmg-oetp-yag to clipboard'"
alias slate-web="cd /Users/salomonebaquis/code/slate-web/"
alias myslate="cd /Users/salomonebaquis/code/my-slate/"
alias zshrc="vscode /Users/salomonebaquis/.zshrc"
alias runslate="cd /Users/salomonebaquis/code/slate-web/ && make clear-public build start"
alias clayconfig="cat /Users/salomonebaquis/.clayconfig"
alias nano="/opt/homebrew/bin/nano"
alias checkelastic="lsof -i :9201"
alias prune='git branch --merged | egrep -v "(^\*|main|dev|stage)" | xargs git branch -d'
alias python="/usr/bin/python3"
alias branches="git branch"

newbranch() {
  if [ $# -eq 0 ]; then
    >&2 echo "Pass in a branch name"
    return
  fi
  git fetch && git checkout -b "$1" origin/stage
}

ci() {
  clay export "$1" | sed "s/_components\/layout/_layouts\/layout/" | clay import --key local -p local.dev.slate.com
}

login() {
  cd /Users/salomonebaquis/code/slate-web/app/build && . env/bin/activate && fab "$1" log_in
}

boxlogin () {
  aws ssm start-session --target "$( aws ec2 describe-instances --filter "Name=tag:Name,Values=$1" "Name=instance-state-name,Values=running" --query 'Reservations[*].Instances[*].[InstanceId,LaunchTime] [] | reverse(sort_by(@, &[1]))[0] | [0]' --output text )"
}

packages() {
  cat package.json | jq '.dependencies * .devDependencies'
}

scripts() {
  cat package.json | jq .scripts
}
