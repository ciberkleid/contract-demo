if [ -z "$CONTRACT_DEMO_HOME" ]; then
  echo "Error running script: env var CONTRACT_DEMO_HOME is not set"
  echo "Please follow the directions in the README for https://github.com/ciberkleid/contract-demo-setup"
  return
fi

## Colors for bash output
NOCOLOR='\033[0m'
BLUE='\033[0;34m'
RED='\033[0;31m'

git -C $CONTRACT_DEMO_HOME/simple-producer add .
echo -e "${BLUE}### PRODUCER git-status: ###${NOCOLOR}" && git -C $CONTRACT_DEMO_HOME/simple-producer status
echo -e "${BLUE}### PRODUCER git-diff: ###${NOCOLOR}" && GIT_PAGER= git -C $CONTRACT_DEMO_HOME/simple-producer diff --cached
echo
git -C $CONTRACT_DEMO_HOME/simple-consumer add .
echo -e "${BLUE}### CONSUMER git-status: ###${NOCOLOR}" && git -C $CONTRACT_DEMO_HOME/simple-consumer status
echo -e "${BLUE}### CONSUMER git-diff: ###${NOCOLOR}" && GIT_PAGER= git -C $CONTRACT_DEMO_HOME/simple-consumer diff --cached
