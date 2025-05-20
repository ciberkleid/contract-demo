if [ -z "$CONTRACT_DEMO_WORKSPACE" ]; then
  echo "Error running script: env var CONTRACT_DEMO_WORKSPACE is not set"
  echo "Please follow the directions in the README for https://github.com/ciberkleid/contract-demo-setup"
  return
fi

# Set git commit message to the name of the current script
current_script_name=$(basename "${BASH_SOURCE[0]:-$0}")
export CONTRACT_DEMO_GIT_COMMIT_MESSAGE=${current_script_name%.*}

# Use Spring Initializr to create producer app

pushd ${CONTRACT_DEMO_WORKSPACE}

# NOTE: If you change spring init settings here, mirror the changes into artifacts/simple-producer/pom-delta1.xml and artifacts/simple-producer/pom-delta2.xml
spring init \
  --build maven \
  --language java \
  --boot-version 3.4.5 \
  --java-version 21 \
  --packaging jar \
  --group-id com.example \
  --artifact-id simple-producer \
  --name simple-producer \
  --description "Demo project for Spring Boot" \
  --package-name com.example.simpleproducer \
  --dependencies web,cloud-contract-verifier \
  simple-producer.zip

unzip simple-producer.zip -d simple-producer && rm simple-producer.zip
echo "" >> simple-producer/.gitignore
echo ".DS_Store" >> simple-producer/.gitignore
echo "# simple-producer" >> simple-producer/README.md

pushd simple-producer
git init
git add .
git commit -m "${CONTRACT_DEMO_GIT_COMMIT_MESSAGE}"
popd

# Use Spring Initializr to create consumer app

spring init \
  --build maven \
  --language java \
  --boot-version 3.4.5 \
  --java-version 21 \
  --packaging jar \
  --group-id com.example \
  --artifact-id simple-consumer \
  --name simple-consumer \
  --description "Demo project for Spring Boot" \
  --package-name com.example.simpleconsumer \
  --dependencies web,cloud-contract-stub-runner \
  simple-consumer.zip

unzip simple-consumer.zip -d simple-consumer && rm simple-consumer.zip
echo "" >> simple-consumer/.gitignore
echo ".DS_Store" >> simple-consumer/.gitignore
echo "# simple-consumer" >> simple-consumer/README.md

pushd simple-consumer
git init
git add .
git commit -m "${CONTRACT_DEMO_GIT_COMMIT_MESSAGE}"
popd

popd
