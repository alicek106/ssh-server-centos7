# This Dockerfile will create OpenMPI Docker Image

FROM centos:7

# Set User
# USER ${USER}

RUN yum install openssh-server openssh-clients -y
RUN echo /usr/sbin/sshd >> /root/.bashrc && source /root/.bashrc
RUN ssh-keygen -q -b 1024 -N '' -t rsa -f /etc/ssh/ssh_host_rsa_key && \
 ssh-keygen -q -b 1024 -N '' -t dsa -f /etc/ssh/ssh_host_dsa_key && \
 ssh-keygen -q -b 521 -N '' -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key && \
 ssh-keygen -q -b 521 -N '' -t ed25519 -f /etc/ssh/ssh_host_ed25519_key

RUN mkdir ~/.ssh && \
 cat /etc/ssh/ssh_host_rsa_key >> ~/.ssh/id_rsa && \
 cat /etc/ssh/ssh_host_rsa_key.pub >> ~/.ssh/authorized_keys

# IF User is changed, you have to change ROOT to USER name
ADD config /root/.ssh/config

RUN sed -i \
        -e 's~^PasswordAuthentication yes~PasswordAuthentication no~g' \
        /etc/ssh/sshd_config

RUN chmod 400 ~/.ssh/id_rsa

ADD pip-install.sh /
RUN /bin/bash /pip-install.sh
ADD tc /sbin/
ADD ip /sbin/
ADD entrypoint.sh /

RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
