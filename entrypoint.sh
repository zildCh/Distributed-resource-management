#!/bin/bash

# Запуск slurmctld и slurmd на главном узле
if [ "$HOSTNAME" == "master" ]; then
    # Запуск slurmctld
    sudo slurmctld -D

    # Запуск slurmd в фоновом режиме и проверка на ошибки
    sudo slurmd -D
    sudo service munge restart
fi
sudo slurmd -D
sudo service munge restart
# Переход в режим ожидания
tail -f /dev/null
