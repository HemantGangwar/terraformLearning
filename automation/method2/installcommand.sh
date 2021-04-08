#!/bin/bash
        /usr/sbin/useradd ansibletest
        echo "ansibletest        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers.d/ansibletest
        /usr/bin/mkdir /home/ansibletest/.ssh
        /usr/bin/chown ansibletest:ansibletest /home/ansibletest/.ssh
        /usr/bin/chmod 700 /home/ansibletest/.ssh
        echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDYlEbQhSjLSYaFiFY9hVf0KRK8AWmwBkwPIl1ir5IK+MQNhHOStjzJqOZZOoPVuVn8sEzGmt00KcX9Dm5SZhOIDdHWvgb5QtmV4Z4wHEpv97j/1vx7tmJiNAoGUlA8OEqJzdMxpQu3wetr/W+SegSbhOyrJllckmrhFxqiVR7WyD7iIuc2L3hXbJNtiMS5uelffdmAmqSNFzXDZCQZB8GT4fZ6tIOxT06S3kpyb3MvbwVhNxT/d2uZmE38XojakzXM0RjF7vPj4xB7QPj9q7Htz9JtQtv5h0U6OTfB9PUJ3UAFYXBRpISqIa1dyXl+uSsTppdac03aAOcfZRCBDTnt root@ldapmas.technix.com" >> /home/ansibletest/.ssh/authorized_keys
        /usr/bin/chmod 600 /home/ansibletest/.ssh/authorized_keys
        /usr/bin/chown ansibletest:ansibletest /home/ansibletest/.ssh/authorized_keys
