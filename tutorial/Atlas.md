# Step 14 - Build and Bake <a href="https://github.com/Netflix/atlas/wiki/" target="_blank">Atlas</a>

TODO

## Bake Atlas

    cd ~/zerotocloud
    ./gradlew :atlas:bake -Dbaseami=ubuntu-base-ami-java8-ebs

## Create Role

It is a good idea to have dedicated roles for each application. Dedicated roles provide a security benefit, but are also quite useful in trying to track down problematic activity. For edda it will need read-only access to most AWS resources. To setup the role using the console follow the instructions for creating the [jumphost role](CreateRole.md) only select the "Read Only Access" template instead of "Administrator Access".

## Deploy Atlas

We're going to repeat the Asgard deploy but for Atlas. 
This will have us returning to [Step 13](AsgardStandalone.md) to perform the "Create Application", "Create an ELB", "Create Auto Scaling Group", and "View instance" pieces.
The difference will be be that we're going to use a different "Health Check" URL, because Atlas doesn't provide a healthcheck endpoint. 
Instead we're going to pick a safe endpoint that will return a HTTP response of 200 when Atlas is up.

1. Naviate to Asgard. This can be done by finding the DNS Name from the end of [Step 13](AsgardStandalone.md) or finding the Asgard ELB and using the DNS Name.
2. Follow "Create Application", using the name "atlas" instead of "asgard".
3. Follow "Create an ELB", using the name "atlas" instead of "asgard". And instead of HTTP:7001/healthcheck for the Health Check URL, use "HTTP:7001/api/v2/view/instances;_limit=1". The protocol and port are the same, but the path is different.
4. Follow "Create Auto Scaling Group" using the name "atlas" instead of "asgard" and using the IAM role "atlas" instead of "jumphost".
5. Follow "View instance" to get the DNS Name for atlas's ELB, i.e. _atlas--frontend_. 
6. Using that DNS Name, visit _http://*ELB DNS name*/api/v2/view/instances;_pp_

Review <a href="https://github.com/Netflix/atlas/wiki/REST" target="_blank">Atlas's REST API</a> for further documentation.
