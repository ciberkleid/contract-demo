if [ -z "$CONTRACT_DEMO_HOME" ]; then
  echo "Error running script: env var CONTRACT_DEMO_HOME is not set"
  echo "Please follow the directions in the README for https://github.com/ciberkleid/contract-demo-setup"
  return
fi

# Set git commit message to the name of the current script
current_script_name=`basename ${BASH_SOURCE}`
export CONTRACT_DEMO_GIT_COMMIT_MESSAGE=${current_script_name%.*}

# Use Spring Initializr to create producer app

pushd ${CONTRACT_DEMO_HOME}

curl -G https://start.spring.io/starter.tgz -d dependencies=web,cloud-contract-verifier -d baseDir=simple-producer | tar -xzvf -
echo "" >> simple-producer/.gitignore
echo ".DS_Store" >> simple-producer/.gitignore
echo "# simple-producer" >> simple-producer/README.md

pushd simple-producer
git init
git add .
git commit -m "${CONTRACT_DEMO_GIT_COMMIT_MESSAGE}"
popd

# Use Spring Initializr to create consumer app

curl -G https://start.spring.io/starter.tgz -d dependencies=web,cloud-contract-stub-runner -d baseDir=simple-consumer | tar -xzvf -
echo "" >> simple-consumer/.gitignore
echo ".DS_Store" >> simple-consumer/.gitignore
echo "# simple-consumer" >> simple-consumer/README.md

pushd simple-consumer
git init
git add .
git commit -m "${CONTRACT_DEMO_GIT_COMMIT_MESSAGE}"
popd

popd
