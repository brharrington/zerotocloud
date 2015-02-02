# Step 11 - Base AMI With Java 8

Some applications require java 8, but unfortunately it isn't a standard package available from the default trusty repos. 

TODO

# Bake

We can now "bake".

    sudo aminate -e ec2_aptitude_linux -b ubuntu-foundation-java8 -n ubuntu-base-ami-java8 baseami/build/distributions/baseami_1.0.0_all.deb
