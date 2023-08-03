cat << EOF >> ~/.ssh/config

Host ${hostName}
    HostName ${hostname}
    User ${user}
    IdentityFile ${identityfile}
EOF