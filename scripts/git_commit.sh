if [ -z "$CONTRACT_DEMO_WORKSPACE" ]; then
  echo "Error running script: env var CONTRACT_DEMO_WORKSPACE is not set"
  echo "Please follow the directions in the README for https://github.com/ciberkleid/contract-demo-setup"
  return
fi

if [[ -z "${CONTRACT_DEMO_GIT_COMMIT_MESSAGE}" ]]; then
  CONTRACT_DEMO_GIT_COMMIT_MESSAGE="default commit message"
fi

git -C $CONTRACT_DEMO_WORKSPACE/simple-producer add .
echo -e "${BLUE}### PRODUCER git-commit: ###${NOCOLOR}" && git -C $CONTRACT_DEMO_WORKSPACE/simple-producer commit -m "${CONTRACT_DEMO_GIT_COMMIT_MESSAGE}"
echo
git -C $CONTRACT_DEMO_WORKSPACE/simple-consumer add .
echo -e "${BLUE}### PRODUCER git-commit: ###${NOCOLOR}" && git -C $CONTRACT_DEMO_WORKSPACE/simple-consumer commit -m "${CONTRACT_DEMO_GIT_COMMIT_MESSAGE}"
