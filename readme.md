# Jump-Box
It's a single container docker image based on **Ubuntu:18.04** that can be used as a Jump-box and able to connect with any cloud K8s environment.
If you want to learn more about Jump-box then check out the following [link](https://github.com/khalfan123/jumpbox) of my Jump-box docker container.

> **Note:** If you need more **Packages** in jumbox kindly create an issue [here](https://github.com/khalfan123/jumpbox/issues).

### Tech

The following Packages are available in Jump-Box:

* [Azure Cli] - Set of commands used to create and manage Azure resources.
* [Helm] - Helm helps you manage Kubernetes applications.
* [Azure Powershell] - Managing Azure resources directly from the PowerShell command line.
* [Kubectl] - Command line tool for controlling Kubernetes clusters.
* [Docker] - Package Software into Standardized Units for Development, Shipment and Deployment.
* [Docker-compose] - Compose is a tool for defining and running multi-container Docker applications.


### Installation

Jump-Box requires [Docker](https://docs.docker.com/engine/install/) to run.
Install the dependencies and start the server.

Pull the image from docker hub and run its container.

``` 
docker pull docdoc2018/jumpbox
docker run --rm -it --name jbox docdoc2018/jumpbox:latest
```


# Pre-Installed utilities
 - curl 
 - jq 
 - wget 
 - git 
 - zip 
 - unzip 



[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)


   [Azure Cli]: <https://docs.microsoft.com/en-us/cli/azure/what-is-azure-cli?view=azure-cli-latest>
   [helm]: <https://helm.sh/>
   [Azure Powershell]: <https://docs.microsoft.com/en-us/powershell/azure/?view=azps-4.2.0>
   [Kubectl]: <https://kubernetes.io/docs/tasks/tools/install-kubectl/>
   [Docker]: <https://www.docker.com/>
   [Docker-compose]: <https://docs.docker.com/compose/>
 

