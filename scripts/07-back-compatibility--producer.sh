if [ -z "$CONTRACT_DEMO_WORKSPACE" ]; then
  echo "Error running script: env var CONTRACT_DEMO_WORKSPACE is not set"
  echo "Please follow the directions in the README for https://github.com/ciberkleid/contract-demo-setup"
  return
fi

# Set git commit message to the name of the current script
current_script_name=$(basename "${BASH_SOURCE[0]:-$0}")
export CONTRACT_DEMO_GIT_COMMIT_MESSAGE=${current_script_name%.*}

cp ${CONTRACT_DEMO_ARTIFACTS}/simple-producer/src/main/java/com/example/simpleproducer/fortune/FortuneController-delta2.java ${CONTRACT_DEMO_WORKSPACE}/simple-producer/src/main/java/com/example/simpleproducer/fortune/FortuneController.java
cp ${CONTRACT_DEMO_ARTIFACTS}/simple-producer/pom-delta2.xml ${CONTRACT_DEMO_WORKSPACE}/simple-producer/pom.xml

echo ""
echo "SUCCESS: simple-producer satisfies both contracts"
echo "We add a maven profile to use the older contract tests in the stub (which was saved to the local maven repo earlier in a prior step) to validate back compatibility"
echo "If back-compatibility tests pass, we test as usual using the updated contract"
echo "If both tests pass (back-compatibility and current contract), we build the jar and save it to the local maven repo"
echo "To try it out, cd to simple-producer and run the following commands:"
echo "---"
echo "./mvnw clean verify -Papicompatibility -Dprod.version=build-1"
echo "./mvnw versions:set -DnewVersion=build-2"
echo "./mvnw clean install"
echo "ls ~/.m2/repository/com/example/simple-producer/build-2"
echo "---"
