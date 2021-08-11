if [ -z "$CONTRACT_DEMO_HOME" ]; then
  echo "Error running script: env var CONTRACT_DEMO_HOME is not set"
  echo "Please follow the directions in the README for https://github.com/ciberkleid/contract-demo-setup"
  return
fi

# Set git commit message to the name of the current script
current_script_name=`basename ${BASH_SOURCE}`
export CONTRACT_DEMO_GIT_COMMIT_MESSAGE=${current_script_name%.*}

cp ${CONTRACT_DEMO_HOME}/contract-demo-setup/artifacts/simple-producer/src/test/resources/contracts/simple-consumer/shouldReturnAFortune-delta1.groovy ${CONTRACT_DEMO_HOME}/simple-producer/src/test/resources/contracts/simple-consumer/shouldReturnAFortune.groovy

echo ""
echo "SUCCESS: simple-producer project contains the updated contract file"
echo "We expect new tests to be auto-generated, and for the tests to fail"
echo "To try it out, cd to simple-producer and run the following commands:"
echo "---"
echo "./mvnw clean verify"
echo "---"







