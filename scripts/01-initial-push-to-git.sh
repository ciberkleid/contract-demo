if [ -z "$CONTRACT_DEMO_HOME" ]; then
  echo "Error running script: env var CONTRACT_DEMO_HOME is not set"
  echo "Please follow the directions in the README for https://github.com/ciberkleid/contract-demo-setup"
  return
fi

if [ -z "$CONTRACT_DEMO_GIT_ORG" ]; then
  echo "Error running script: env var CONTRACT_DEMO_HOME and CONTRACT_DEMO_GIT_ORG are not set"
  echo "Please follow the directions in the README for https://github.com/ciberkleid/contract-demo-setup"
  return
fi

# Initial check-in into GitHub

pushd $CONTRACT_DEMO_HOME/simple-producer

git init
git add .
git commit -m "first commit"
git remote add origin git@github.com:${CONTRACT_DEMO_GIT_ORG}/simple-producer.git
git push -u origin master

popd

# Initial check-in into GitHub

pushd $CONTRACT_DEMO_HOME/simple-consumer

git init
git add .
git commit -m "first commit"
git remote add origin git@github.com:${CONTRACT_DEMO_GIT_ORG}/simple-consumer.git
git push -u origin master

popd
