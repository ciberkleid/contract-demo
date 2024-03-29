# Spring Cloud Contract Demo

This tutorial will walk you through a simple demo of Spring Cloud Contract.
As you go through it, take the time to understand the changes each step makes to the code.

We will create two Spring Boot apps, `simple-producer` and `simple-consumer`.
We will then create an API contract to define the interaction between the apps, and show how the contract can be used programmatically by each.

# Instructions

## Setup

#### Download scripts & artifacts
- Clone this repo and set environment variables as follows:
```shell
git clone https://github.com/ciberkleid/contract-demo.git
cd contract-demo
mkdir workspace
export CONTRACT_DEMO_SCRIPTS=`echo $PWD/scripts`
export CONTRACT_DEMO_ARTIFACTS=`echo $PWD/artifacts`
export CONTRACT_DEMO_WORKSPACE=`echo $PWD/workspace`
```

## Steps

#### 1. Create projects
- Create the consumer and producer projects by running the following script.
The script uses [Spring Initializr](https://start.spring.io) to generate the projects.
```shell
source $CONTRACT_DEMO_SCRIPTS/01-create-projects.sh
```

- What happened? You should see two new project directories, each with a new Spring Boot web application.
  Notice that the producer has the `cloud-contract-verifier` dependency in its `pom.xml` and that the consumer has the `cloud-contract-stub-runner` dependency in its `pom.xml`.

Each project has also been initialized as a local git repository so that you can easily see the changes between steps.
Run the following script to see the results of `git-status` and `git-diff` for each.
```shell
source $CONTRACT_DEMO_SCRIPTS/git_changes.sh
```

At this point, the status of both should be `nothing to commit, working tree clean` and there should be no `diff` results.

#### 2. Create contract
- To simulate an API contract being suggested ("driven") by the consumer and accepted by the producer, we will copy a contract to the producer project (in a more formal scenario, this might entail a pull request by a consumer that is evaluated and accepted by a producer).
To accomplish this, run the following script:
```shell
source $CONTRACT_DEMO_SCRIPTS/02-create-contract.sh
```
- What happened? Notice that a new file has been added to the simple-producer project in a location that is compliant with Spring Cloud Contract convention.
  This file contains a contract specification written in Groovy.

Re-run the `git_changes.sh` script to view the changes from this step.
You should see the location, name, and content of the new file.
Take a moment to understand the contract; it describes a simple get request at the base path ("/") that should return a successfull status (200) and a string response (using "foo fortune" as a sample/test value).

Commit the changes from this step.
```shell
source $CONTRACT_DEMO_SCRIPTS/git_commit.sh
```

#### 3. Generate tests and stub (producer)
- The simple-producer can now use the contract to auto-generate API tests and to produce a stub jar.
To do so, it must complete the minimal requirements for the `spring-cloud-contract-maven-plugin` to be able to generate the tests and stubs.
To accomplish this, run the following script:
```shell
source $CONTRACT_DEMO_SCRIPTS/03-use-contract--producer.sh
```
- What happened? Three new files were added to `simple-producer`, and a new maven profile configuration was added to the `simple-producer` `pom.xml`.
These are all used by the `spring-cloud-contract-maven-plugin` to auto-generate contract tests and a stub jar file.
Notice that the maven build creates a stub jar, in addition to the usual jar.
Maven also executes the tests that the plugin generates.
The resulting stub jar contains the contract and the auto-generated tests.
Maven saves the stub to the local maven repository; `simple-consumer` will use the stub in the next step.

Re-run the `git_changes.sh` script to view the changes from this step.

Re-run the `git_commit.sh` script to commit the changes from this step.

#### 4. Test consumer against stub
- The simple-consumer can now use the stub to test against, rather than having to manually mock out the producer.
We will configure simple-consumer to retrieve the stub from the local maven repository (~/.m2/repository).
  Spring Cloud Contract WireMock modules automatically configure WireMock to load the stub on a specific port in the same process.
  We will then add a test to simple-consumer that runs against the loaded stub.
To accomplish this, run the following script:
```shell
source $CONTRACT_DEMO_SCRIPTS/04-use-contract--consumer.sh
```
- What happened? We added a simple implementation of a controller and service on the consumer side, as well as a test class that the consumer can use to validate the implementation.
  The test class uses `@AutoConfigureStubRunner` to load the stub, and then tests the implementation against the stub.
There is no need for the consumer to manually implement stub out the producer, and the consumer has the confidence that the stub that is being used is reliable , since it was auto-generated by the producer based on the accepted contract.

Re-run the `git_changes.sh` script to view the changes from this step.

Re-run the `git_commit.sh` script to commit the changes from this step.

#### 5. Update the contract
- Let's assume that the consumer wants to update the contract.
They decide that instead of using the base path "http://<PRODUCER_URL>/" to get fortunes, they want to have a more specific API: "http://<PRODUCER_URL>/fortune", so that in the future, they can add "/fact", "/forecast", and other types of calls to the API.
They issue a pull request, which is accepted by the producer.
By accepting the pull request, the producer updates the copy of the contract in the simple-producer code base.
We will simulate that by updating the copy of the contract in the producer code base.
To accomplish this, run the following script:
```shell
source $CONTRACT_DEMO_SCRIPTS/05-update-contract.sh
```
- What happened? The contract was updated, but no other code changes were made.
  New tests are generated based on the updated contract, but the old implementation does not pass the tests.
  Therefore, the tests fail, as we would expect.

Re-run the `git_changes.sh` script to view the changes from this step.

Re-run the `git_commit.sh` script to commit the changes from this step.

#### 6. Update the producer code to satisfy the new contract
- In order to update the producer implementation to comply with the updated contract, we update our controller to respond to calls at "/fortune" rather than "/".
To accomplish this, run the following script:
```shell
source $CONTRACT_DEMO_SCRIPTS/06-update-producer.sh
```
- What happened? The updated implementation complies with the new contract, so the auto-generated tests pass.

Re-run the `git_changes.sh` script to view the changes from this step.

Re-run the `git_commit.sh` script to commit the changes from this step.

#### 7. Check for back-compatibility - producer
- The producer could go ahead and publish the new code.
However, changing the API from "/" to "/fortune" is a breaking change (in contrast to a non-breaking additive change, like adding "/fact", "/forecast", etc).
This means that as soon as the updated producer code is deployed to production, all consumers will need to update their code as well.
Assuming this coordination is achieved, the producer and consumer will still need to coordinate rollbacks if one is required.
This also means the producer cannot have both version running simultaneously in production with requests being load-balanced in a random or round-robbin fashion across both versions (aka they cannot safely do a zero-downtime "blue/green" deployment).
Thus, if the producer wants to do a zero-downtime deployment, deploy independently, and roll back independently, it will need to ensure that its implementation of the updated contract is also back-compatible with the previous contract.
In order to update the producer implementation to comply with both contracts, we update our controller to respond to calls at {"/", "/fortune"} rather than just "/fortune".
We also add a maven profile to do an api-compatibility check using the older contract tests, which we can obtain from the prior version stub jar.
To accomplish this, run the following script:
```shell
source $CONTRACT_DEMO_SCRIPTS/07-back-compatibility--producer.sh
```

Re-run the `git_changes.sh` script to view the changes from this step.

Re-run the `git_commit.sh` script to commit the changes from this step.

#### 8. Update the consumer
- The consumer can now test against the updated stub, which complies with the new contract.
We update the consumer implementation to call the producer at "/fortune" instead of "/".
We then re-run our tests, this time using the new stub (new stub was published to the local maven repository by the producer as version "build-2" in the last step).
Once again, Spring Cloud Contract WireMock modules automatically configure WireMock to load the stub on a specific port in the same process.
To accomplish this, run the following script:
```shell
source $CONTRACT_DEMO_SCRIPTS/08-update-consumer.sh
```
- What happened? We updated the implementation of the consumer's `FortuneService` class and re-ran our tests, this time specifying the `build-2` stubs in the maven command.

Re-run the `git_changes.sh` script to view the changes from this step.

Re-run the `git_commit.sh` script to commit the changes from this step.

#### 9. Check for back-compatibility - consumer
- The consumer could go ahead and promote the new code to production.
However, if the producer has not yet promoted their new code to production, the consumer will have to wait and coordinate the deployment with the producer.
Assuming this coordination is achieved, the producer and consumer will still need to coordinate rollbacks if one is required.
In order to ensure the consumer is compatible with both contract versions, we test the updated consumer against both build-1 and build-2 stubs, making the necessary code changes to ensure that back-compatibility is maintained.
To accomplish this, run the following script:
```shell
source $CONTRACT_DEMO_SCRIPTS/09-back-compatibility--consumer.sh
```

Re-run the `git_changes.sh` script to view the changes from this step.

Re-run the `git_commit.sh` script to commit the changes from this step.
