# Explanation
## Q1
The dockerfile is developed with the intention of beign reusable for different litecoin versions with minor or no changes, for this docker build arguments are used.
A simple configuration is embedded in case we dont provide a configuration for the container at runtime, this will be addressed a question2. The configuration is embedded in order to avoid creating more files, but a simple COPY instruction on the dockerfile could replace the embedded configuration.

The `.asc` file of the release is validated prior to downloading the release package in order to avoid polluting a proxy/cache system that we may be using (nexus, artifactory, or others) with a potentially non legitimate release.

Default build
`docker build --tags vicsufer/ltc:0.18.1`
Build for different litecoin with no changes to Dockerfile, using build args
`docker build --build-arg ltc_version=0.17.1 --tag vicsufer/ltc:0.17.1 .`

Run docker
`docker run vicsufer/ltc:0.18.1`

### Improvements
A multi-stage to have only the binaries of litecoin on the image to reduce size of the image or improve security, it have been tested and the size of the image nor the results of anchore did not changed significatly, so at this point it was not submited as a solution.
## Q2
Notice: The kubernetes manifest and its behaviour have been tested on [kind](https://kind.sigs.k8s.io/)

The file `statefulset.yml` is a manifest that will create the resources in order to make the containers run on a cluster.
A ConfigMap resource is created in order to mount on the containers the configuration for the litecoin nodes, in this way the Dockerfile embedded configuration is overrided. Also a volume claim is mounted on each of the containers in the path that the blockchain data is stored so a restart of the container wont cause an overhead of redownloading the blockchain.

Very simple readiness and liveness probes have been implemented checking if the ports are open, for production environments the checks should be a better fit for litecoin nodes.

Resource limits are based on bitcoin miner hardeware requriements, they should be profiled over time.

Deploying first time
`kubectl apply -f statefulset.yml`

Perform a rolling update of the images.
`kubectl set image statefulset/ltc-node ltc-node=vicsufer/ltc:latest`

### Improvements
Packaging the manifest using a Helm chart would be a great idea in order to package all the needed resources and would enable the possibility of developing tests, also it will be huge to allow the usage of the same helm chart for different environments just changing the value of some variables such as image version, litecoin node configuration or any other needed.

The litecoin pods should be restarted autonomously when updating the configmap with the litecoin node configuration, for this an operator could be develop, a easies approeach would be also using Helm charts and checking for the sha265 of the configmap when referencing it on the statefulset.

## Q3
The file `.travis.yml` contains the pipeline for building, testing and deploying the image to a kubernetes cluster.
Each built image will be labeled with the commit that triggers the build so we can trace back any problem that may arise on the kubernetes cluster.

The `image_test` stage could be used to check for vulnerabilities or any other acceptance tests that may be needed.

Prior to deployment a dry-run is ussed in order to validate the kubernetes manifests, this could also be improved by using any other tools that may fit. The deployment is a simple update of the image of statefulset container that will trigger a RollingUpdate, it may be improved by using canary releases or any other desired method.

### Improvements
The pipeline is very simple, it is not considering any type of gitflow so it would need to be tweeked according to the needs of the project.

Kubeconfig is obtained from a travis secret, I personally would download the file from a system with an ACL system such as Hashicorp Vault.