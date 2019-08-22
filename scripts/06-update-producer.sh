if [ -z "$CONTRACT_DEMO_HOME" ]; then
  echo "Error running script: env var CONTRACT_DEMO_HOME is not set"
  echo "Please follow the directions in the README for https://github.com/ciberkleid/contract-demo-setup"
  return
fi

cp ${CONTRACT_DEMO_HOME}/contract-demo-setup/artifacts/simple-producer/src/main/java/com/example/simpleproducer/fortune/FortuneController-delta1.java ${CONTRACT_DEMO_HOME}/simple-producer/src/main/java/com/example/simpleproducer/fortune/FortuneController.java

echo ""
echo "SUCCESS: simple-producer satisfies the updated contract"
echo "We expect new tests to be auto-generated, and for the tests to pass"
echo "To try it out, cd to simple-producer and run the following commands:"
echo "---"
echo "./mvnw clean verify"
echo "---"