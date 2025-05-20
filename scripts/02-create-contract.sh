if [ -z "$CONTRACT_DEMO_WORKSPACE" ]; then
  echo "Error running script: env var CONTRACT_DEMO_WORKSPACE is not set"
  echo "Please follow the directions in the README for https://github.com/ciberkleid/contract-demo-setup"
  return
fi

# Set git commit message to the name of the current script
current_script_name=$(basename "${BASH_SOURCE[0]:-$0}")
export CONTRACT_DEMO_GIT_COMMIT_MESSAGE=${current_script_name%.*}

mkdir ${CONTRACT_DEMO_WORKSPACE}/simple-producer/src/test/resources/contracts/simple-consumer
cp ${CONTRACT_DEMO_ARTIFACTS}/simple-producer/src/test/resources/contracts/simple-consumer/shouldReturnAFortune.groovy ${CONTRACT_DEMO_WORKSPACE}/simple-producer/src/test/resources/contracts/simple-consumer

echo ""
echo "SUCCESS: simple-producer project contains contract file"

