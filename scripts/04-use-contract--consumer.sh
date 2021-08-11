if [ -z "$CONTRACT_DEMO_HOME" ]; then
  echo "Error running script: env var CONTRACT_DEMO_HOME is not set"
  echo "Please follow the directions in the README for https://github.com/ciberkleid/contract-demo-setup"
  return
fi

# Set git commit message to the name of the current script
current_script_name=`basename ${BASH_SOURCE}`
export CONTRACT_DEMO_GIT_COMMIT_MESSAGE=${current_script_name%.*}

mkdir -p ${CONTRACT_DEMO_HOME}/simple-consumer/src/main/java/com/example/simpleconsumer/fortune
mkdir -p ${CONTRACT_DEMO_HOME}/simple-consumer/src/test/java/com/example/simpleconsumer/fortune

cp ${CONTRACT_DEMO_HOME}/contract-demo-setup/artifacts/simple-consumer/src/main/java/com/example/simpleconsumer/fortune/FortuneController.java ${CONTRACT_DEMO_HOME}/simple-consumer/src/main/java/com/example/simpleconsumer/fortune
cp ${CONTRACT_DEMO_HOME}/contract-demo-setup/artifacts/simple-consumer/src/main/java/com/example/simpleconsumer/fortune/FortuneService.java ${CONTRACT_DEMO_HOME}/simple-consumer/src/main/java/com/example/simpleconsumer/fortune
cp ${CONTRACT_DEMO_HOME}/contract-demo-setup/artifacts/simple-consumer/src/main/java/com/example/simpleconsumer/SimpleConsumerApplication.java ${CONTRACT_DEMO_HOME}/simple-consumer/src/main/java/com/example/simpleconsumer
cp ${CONTRACT_DEMO_HOME}/contract-demo-setup/artifacts/simple-consumer/src/test/java/com/example/simpleconsumer/fortune/FortuneServiceTests.java ${CONTRACT_DEMO_HOME}/simple-consumer/src/test/java/com/example/simpleconsumer/fortune

echo ""
echo "SUCCESS: simple-consumer is ready to test against contract-based stub"
echo "To try it out, cd to simple-consumer and run the following command:"
echo "---"
echo "./mvnw clean verify -Dstubrunner.ids=com.example:simple-producer:build-1:stubs:10000 -Dstubrunner.stubs-mode=LOCAL"
echo "---"