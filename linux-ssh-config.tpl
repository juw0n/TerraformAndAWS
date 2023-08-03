cat << EOF >> ~/.ssh/config

Host ${hostName}
    HostName ${hostName}
    User ${user}
    IdentityFile ${identityfile}
EOF