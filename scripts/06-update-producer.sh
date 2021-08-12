if [ -z "$CONTRACT_DEMO_WORKSPACE" ]; then
  echo "Error running script: env var CONTRACT_DEMO_WORKSPACE is not set"
  echo "Please follow the directions in the README for https://github.com/ciberkleid/contract-demo-setup"
  return
fi

# Set git commit message to the name of the current script
current_script_name=`basename ${BASH_SOURCE}`
export CONTRACT_DEMO_GIT_COMMIT_MESSAGE=${current_script_name%.*}

cp ${CONTRACT_DEMO_ARTIFACTS}/simple-producer/src/main/java/com/example/simpleproducer/fortune/FortuneController-delta1.java ${CONTRACT_DEMO_WORKSPACE}/simple-producer/src/main/java/com/example/simpleproducer/fortune/FortuneController.java

echo ""
echo "SUCCESS: simple-producer satisfies the updated contract"
echo "We expect new tests to be auto-generated, and for the tests to pass"
echo "To try it out, cd to simple-producer and run the following commands:"
echo "---"
echo "./mvnw clean verify"
echo "---"