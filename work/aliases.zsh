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
alias runmyslate="cd /Users/salomonebaquis/code/docker-configs/ && ./myslate-backend-min.sh"
alias clayconfig="cat /Users/salomonebaquis/.clayconfig"
alias nano="/opt/homebrew/bin/nano"
alias checkelastic="lsof -i :9201"
alias prune='git branch --merged | egrep -v "(^\*|main|dev|stage)" | xargs git branch -d'
# alias python="/usr/bin/python3"
alias branches="git branch"
alias co="git checkout"
alias chrome-extensions="cd /Users/salomonebaquis/Library/Application\ Support/Google/Chrome/Profile\ 3/Extensions"

# ONEPASS ALIASES
# If you're trying to run "fab dev log_in", you'll need to prefix it - "opaws fab dev log_in"
alias opaws="op run --env-file=$HOME/.aws/op-env-vars -- "
alias opaws-debug="op run --no-masking --env-file=$HOME/.aws/op-env-vars -- "

# https://github.com/knicklabs/lorem-ipsum.js
alias li="lorem-ipsum"

newbranch() {
  if [ $# -eq 0 ]; then
    >&2 echo "Pass in a branch name"
    return
  fi
  git checkout stage && git pull && git checkout -b "$1"
}

delete() {
  if [ $# -eq 0 ]; then
    >&2 echo "Pass in a branch name to delete"
    return
  fi

  git branch -D "$1"
}

cleanslate() {
  cd /Users/salomonebaquis/code/slate-web/app && rm -rf package-lock.json node_modules && npm i
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

newcomponent() {
  if [ $# -eq 0 ]; then
    >&2 echo "Pass in the name of the component you want to create."
    return
  fi
  cd /Users/salomonebaquis/code/slate-web/app/components && mkdir "$1" && cd "$1" && touch bootstrap.yml styles.scss schema.yml model.js client.js template.hbs
}

activate() {
  if [ $# -eq 0 ]; then
    >&2 echo "Pass in the name of the virtual environment you want to activate."
    return
  fi
  source "$1"/bin/activate
}
