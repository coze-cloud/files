#!/bin/bash

USER=${USER:-files}
USER_ID=${USER_ID:-1000}
GROUP_ID=${GROUP_ID:-1000}
PASSWORD=${PASSWORD:-changeme}

for type in rsa dsa ecdsa ed25519; do
  if ! [ -e "/ssh/ssh_host_${type}_key" ]; then
    echo "/ssh/ssh_host_${type}_key not found, generating..."
    ssh-keygen -f "/ssh/ssh_host_${type}_key" -N '' -t ${type}
  fi

  ln -sf "/ssh/ssh_host_${type}_key" "/etc/ssh/ssh_host_${type}_key"
  ln -sf "/ssh/ssh_host_${type}_key.pub" "/etc/ssh/ssh_host_${type}_key.pub"
done

if (id ${USER}); then
    echo "INFO: User ${USER} already exists"
else
    echo "INFO: User ${USER} does not exists, we create it"
    
    ENCRYPTED_PASSWORD=$(perl -e 'print crypt($ARGV[0], "password")' ${PASSWORD})

    GET_USER_BY_ID=$(cat /etc/passwd | grep ${USER_ID} | head -n1 | awk -F: '{ print $1 }')
    deluser ${GET_USER_BY_ID}
    GET_GROUP_BY_ID=$(cat /etc/group | grep ${GROUP_ID} | head -n1 | awk -F: '{ print $1 }')
    delgroup ${GET_GROUP_BY_ID}

    addgroup --gid ${GROUP_ID} sftpusers

    useradd -d /data -m -g sftpusers -p ${ENCRYPTED_PASSWORD} -u ${USER_ID} -s /bin/false ${USER}
    usermod -aG sftpusers ${USER}

    chown ${USER_ID}:${GROUP_ID} /data/mounts

    if (! -e /data/.ssh/authorized_keys && ! -z "$PUBKEY"); then
        mkdir /data/.ssh
        touch /data/.ssh/authorized_keys
        echo ${PUBKEY} >> /data/.ssh/authorized_keys
    fi
fi

exec /usr/sbin/sshd -D -e
