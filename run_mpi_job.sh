run_mpi_job.sh
#!/bin/bash
#SBATCH --job-name=mpi_job
#SBATCH --output=mpi_job.out
#SBATCH --error=mpi_job.err
#SBATCH --nodes=2
#SBATCH --ntasks=4
mpirun -n 2 --allow-run-as-root ./hello_mpi
