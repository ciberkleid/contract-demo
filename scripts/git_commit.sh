if [ -z "$CONTRACT_DEMO_HOME" ]; then
  echo "Error running script: env var CONTRACT_DEMO_HOME is not set"
  echo "Please follow the directions in the README for https://github.com/ciberkleid/contract-demo-setup"
  return
fi

if [[ -z "${CONTRACT_DEMO_GIT_COMMIT_MESSAGE}" ]]; then
  CONTRACT_DEMO_GIT_COMMIT_MESSAGE="default commit message"
fi

git -C $CONTRACT_DEMO_HOME/simple-producer add .
echo -e "${BLUE}### PRODUCER git-commit: ###${NOCOLOR}" && git -C $CONTRACT_DEMO_HOME/simple-producer commit -m "${CONTRACT_DEMO_GIT_COMMIT_MESSAGE}"
echo
git -C $CONTRACT_DEMO_HOME/simple-consumer add .
echo -e "${BLUE}### PRODUCER git-commit: ###${NOCOLOR}" && git -C $CONTRACT_DEMO_HOME/simple-consumer commit -m "${CONTRACT_DEMO_GIT_COMMIT_MESSAGE}"
