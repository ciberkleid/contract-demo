if [ -z "$CONTRACT_DEMO_HOME" ]; then
  echo "Error running script: env var CONTRACT_DEMO_HOME is not set"
  echo "Please follow the directions in the README for https://github.com/ciberkleid/contract-demo-setup"
  return
fi

cp ${CONTRACT_DEMO_HOME}/contract-demo-setup/artifacts/simple-consumer/src/main/java/com/example/simpleconsumer/fortune/FortuneService-delta2.java ${CONTRACT_DEMO_HOME}/simple-consumer/src/main/java/com/example/simpleconsumer/fortune/FortuneService.java

echo ""
echo "SUCCESS: simple-consumer is ready to test against both contract-based stubs"
echo "To try it out, cd to simple-consumer and run the following command:"
echo "---"
echo "./mvnw clean verify -Dstubrunner.ids=com.example:simple-producer:build-1:stubs:10000 -Dstubrunner.stubs-mode=LOCAL"
echo "./mvnw clean verify -Dstubrunner.ids=com.example:simple-producer:build-2:stubs:10000 -Dstubrunner.stubs-mode=LOCAL"
echo "---"