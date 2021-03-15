#!/bin/bash
        yum -y install wget httpd
        systemctl start httpd
        echo "This is deployed by terraform" >> /var/www/html/index.html
	/usr/sbin/useradd ansibletest
        echo "ansibletest        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers.d/ansibletest
        /usr/bin/mkdir /home/ansibletest/.ssh 
        /usr/bin/chown ansibletest:ansibletest /home/ansibletest/.ssh 
        /usr/bin/chmod 700 /home/ansibletest/.ssh
        echo "* * * * * timeout 5 wget https://www.youtube.com/watch?v=uHGGbDdX5l0" > /var/spool/cron/root
        echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC+F3jBJ8Ehh3h3xfyosFveITeNcBTPOLqtSZAn5HnYr4eBcaRkW3XcTKxsWnV5NOb3du0R269JSXo7PXPPxcRPDSuCR8TY5hg08tVQKjn+AgUkknBIYEb6caimQ/9ILLSKCbPVGoOZR4qZObwr02jXp3pAFfynmUCkuvPqw4Wdhm+Ua8nLf7T9B36EK3vvE0SfD+DZ0/EE+noN4qCs84Wb5YAXzp6hxGgbnVrdtSYjUrvtKrgr5TshvzUEOqIsB2GEwQBbV6glBDQ+TlhJii9wAM4EyjvrVoeNEgWOnzYsED3p24btnFim6xhjZJjlzierCrt98hQ6yGY8UmtbT5UP root@ldapmas.technix.com" >> /home/ansibletest/.ssh/authorized_keys
        /usr/bin/chmod 600 /home/ansibletest/.ssh/authorized_keys
        /usr/bin/chown ansibletest:ansibletest /home/ansibletest/.ssh/authorized_keys
