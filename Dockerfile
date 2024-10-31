# Используем базовый образ с установленным OpenMPI
FROM ubuntu:20.04


From ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Устанавливаем необходимые зависимости
RUN apt-get update && \
    apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get install -y slurm-wlm openmpi-bin libopenmpi-dev sudo && \
    rm -rf /var/lib/apt/lists/*

# Настраиваем пользователя для запуска Slurm и MPI
RUN useradd -m mpiuser && echo "mpiuser:mpiuser" | chpasswd && adduser mpiuser sudo

# Slurm config
COPY slurm.conf /etc/slurm-llnl/slurm.conf

# Открываем порты и даем нужные права slurm
RUN sudo mkdir -p /var/spool/slurmd && sudo chown mpiuser:mpiuser /var/spool/slurmd && \
    sudo mkdir -p /var/log/slurm && sudo chown mpiuser:mpiuser /var/log/slurm
RUN sudo mkdir -p /var/spool && sudo chown slurm:slurm /var/spool

# Копируем скрипт для запуска Slurm в контейнере
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Переходим на пользователя mpiuser
USER mpiuser


# Устанавливаем рабочую директорию
WORKDIR /home/mpiuser


# Определяем команду запуска
ENTRYPOINT ["/entrypoint.sh"]
