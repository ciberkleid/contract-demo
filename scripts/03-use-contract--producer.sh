if [ -z "$CONTRACT_DEMO_WORKSPACE" ]; then
  echo "Error running script: env var CONTRACT_DEMO_WORKSPACE is not set"
  echo "Please follow the directions in the README for https://github.com/ciberkleid/contract-demo-setup"
  return
fi

# Set git commit message to the name of the current script
current_script_name=`basename ${BASH_SOURCE}`
export CONTRACT_DEMO_GIT_COMMIT_MESSAGE=${current_script_name%.*}

mkdir -p ${CONTRACT_DEMO_WORKSPACE}/simple-producer/src/main/java/com/example/simpleproducer/fortune
mkdir -p ${CONTRACT_DEMO_WORKSPACE}/simple-producer/src/test/java/com/example/simpleproducer/fortune

cp ${CONTRACT_DEMO_ARTIFACTS}/simple-producer/src/main/java/com/example/simpleproducer/fortune/FortuneController.java ${CONTRACT_DEMO_WORKSPACE}/simple-producer/src/main/java/com/example/simpleproducer/fortune
cp ${CONTRACT_DEMO_ARTIFACTS}/simple-producer/src/main/java/com/example/simpleproducer/fortune/FortuneService.java ${CONTRACT_DEMO_WORKSPACE}/simple-producer/src/main/java/com/example/simpleproducer/fortune
cp ${CONTRACT_DEMO_ARTIFACTS}/simple-producer/src/test/java/com/example/simpleproducer/fortune/BaseClass.java ${CONTRACT_DEMO_WORKSPACE}/simple-producer/src/test/java/com/example/simpleproducer/fortune
cp ${CONTRACT_DEMO_ARTIFACTS}/simple-producer/pom-delta1.xml ${CONTRACT_DEMO_WORKSPACE}/simple-producer/pom.xml

echo ""
echo "SUCCESS: simple-producer is ready to generate a contract-based stub"
echo "To try it out, cd to simple-producer and run the following commands:"
echo "---"
echo "./mvnw versions:set -DnewVersion=build-1"
echo "./mvnw clean install"
echo "ls ~/.m2/repository/com/example/simple-producer/build-1"
echo "---"