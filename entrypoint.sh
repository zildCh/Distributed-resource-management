
#!/bin/bash

# Запуск slurmctld и slurmd на главном узле
if [ "$HOSTNAME" == "master" ]; then
    # Запуск slurmctld в фоновом режиме и проверка на ошибки
    sudo slurmctld -D &> /var/log/slurm/slurmctld.log &
    echo "Запущен slurmctld"
    sudo service munge start

    # Запуск slurmd в фоновом режиме и проверка на ошибки
    sudo slurmd -D &> /var/log/slurm/slurmd.log &
    echo "Запущен slurmd"
else
    # Запуск slurmd на рабочих узла
    sudo slurmd -D &> /var/log/slurm/slurmd.log &
    echo "Запущен slurmd на рабочем узле"
    sudo service munge start
fi

# Переход в режим ожидания
tail -f /dev/null
