#!/bin/sh

envsubst </etc/rabbitmq/definitions_template.json >/etc/rabbitmq/definitions.json &&
    chown -R rabbitmq:rabbitmq /var/lib/rabbitmq /etc/rabbitmq &&
    chmod 777 /var/lib/rabbitmq /etc/rabbitmq

rabbitmq-server
