#!/bin/bash
export JMETER_HOME=/opt/apache-jmeter
sudo aws s3 cp s3://s3-internal-shared-use1-ssm-resources/jmeter/apache-jmeter-5.4.3.tgz .
sudo tar zxvf apache-jmeter-5.4.3.tgz -C /opt && sudo mv /opt/apache-jmeter-5.4.3 $JMETER_HOME
sudo yum install java-1.8.0-openjdk-headless.x86_64 -y
sudo sed -i "s/\#server.rmi.ssl.disable=false/server.rmi.ssl.disable=true/g" $JMETER_HOME/bin/user.properties
sudo sed -i "s/\#client.rmi.localport=0/client.rmi.localport=5000/g" $JMETER_HOME/bin/jmeter.properties
sudo sed -i "s/\#server.rmi.localport=4000/server.rmi.localport=5000/g" $JMETER_HOME/bin/jmeter.properties
sudo sed -i "s/\HEAP:=\"-Xms1g -Xmx1g/HEAP:=\"-Xms2g -Xmx4g/g" $JMETER_HOME/bin/jmeter
sudo bash -c 'cat <<EOF > /etc/systemd/system/jmeter-server.service
[Unit]
Description=JMeter server Agent
After=network-online.target

[Service]
Type=simple
ExecStart=/opt/apache-jmeter/bin/jmeter-server
WorkingDirectory = /opt/apache-jmeter
#KillMode=process
#Restart=on-failure
#RestartSec=60s

[Install]
WantedBy=multi-user.target
EOF'
sudo systemctl enable jmeter-server
sudo systemctl start jmeter-server