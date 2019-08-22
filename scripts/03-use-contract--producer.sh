if [ -z "$CONTRACT_DEMO_HOME" ]; then
  echo "Error running script: env var CONTRACT_DEMO_HOME is not set"
  echo "Please follow the directions in the README for https://github.com/ciberkleid/contract-demo-setup"
  return
fi

mkdir -p ${CONTRACT_DEMO_HOME}/simple-producer/src/main/java/com/example/simpleproducer/fortune
mkdir -p ${CONTRACT_DEMO_HOME}/simple-producer/src/test/java/com/example/simpleproducer/fortune

cp ${CONTRACT_DEMO_HOME}/contract-demo-setup/artifacts/simple-producer/src/main/java/com/example/simpleproducer/fortune/FortuneController.java ${CONTRACT_DEMO_HOME}/simple-producer/src/main/java/com/example/simpleproducer/fortune
cp ${CONTRACT_DEMO_HOME}/contract-demo-setup/artifacts/simple-producer/src/main/java/com/example/simpleproducer/fortune/FortuneService.java ${CONTRACT_DEMO_HOME}/simple-producer/src/main/java/com/example/simpleproducer/fortune
cp ${CONTRACT_DEMO_HOME}/contract-demo-setup/artifacts/simple-producer/src/test/java/com/example/simpleproducer/fortune/BaseClass.java ${CONTRACT_DEMO_HOME}/simple-producer/src/test/java/com/example/simpleproducer/fortune
cp ${CONTRACT_DEMO_HOME}/contract-demo-setup/artifacts/simple-producer/pom-delta1.xml ${CONTRACT_DEMO_HOME}/simple-producer/pom.xml

echo ""
echo "SUCCESS: simple-producer is ready to generate a contract-based stub"
echo "To try it out, cd to simple-producer and run the following commands:"
echo "---"
echo "./mvnw versions:set -DnewVersion=build-1"
echo "./mvnw clean install"
echo "ls ~/.m2/repository/com/example/simple-producer/build-1"
echo "---"