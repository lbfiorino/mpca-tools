# CICFlowMeter

# Install on Ubuntu 20.04

```bash
apt install maven gradle openjdk-8-jdk

git clone https://github.com/ahlashkari/CICFlowMeter.git

//linux :at the pathtoproject/jnetpcap/linux/jnetpcap-1.4.r1425
//windows: at the pathtoproject/jnetpcap/win/jnetpcap-1.4.r1425
cd CICFlowMeter/jnetpcap/linux/jnetpcap-1.4.r1425
mvn install:install-file -Dfile=jnetpcap.jar -DgroupId=org.jnetpcap -DartifactId=jnetpcap -Dversion=1.4.1 -Dpackaging=jar

# Make package
# cd to CICFlowMeter
cd ../../../
gradle clean
gradle build

# The .tar and .zip files will be in the pathtoproject/CICFlowMeter/build/distributions
```

# Using CICFlowMeter

Unpack zip package in CICFlowMeter/build/distributions.
```bash
cd CICFlowMeter-4.0/bin
# cfm : command line
# CICFlowMeter : graphical application
/cfm file.pcap <outdir>
# output file is file.pcap_Flow.csv
```
