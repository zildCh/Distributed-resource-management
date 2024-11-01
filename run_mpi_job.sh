#!/bin/bash
#SBATCH --job-name=mpi_job
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=2
#SBATCH --time=00:10:00
#SBATCH --output=mpi_output.txt

orterun --allow-run-as-root -np 4 /home/mpiuser/hello_mpi

