if [ -z "$CONTRACT_DEMO_HOME" ]; then
  echo "Error running script: env var CONTRACT_DEMO_HOME is not set"
  echo "Please follow the directions in the README for https://github.com/ciberkleid/contract-demo-setup"
  return
fi

mkdir ${CONTRACT_DEMO_HOME}/simple-producer/src/test/resources/contracts/simple-consumer
cp ${CONTRACT_DEMO_HOME}/contract-demo-setup/artifacts/simple-producer/src/test/resources/contracts/simple-consumer/shouldReturnAFortune.groovy ${CONTRACT_DEMO_HOME}/simple-producer/src/test/resources/contracts/simple-consumer

echo ""
echo "SUCCESS: simple-producer project contains contract file"

