#!/usr/bin/zsh
#SBATCH --job-name=RegressionTest

### Request the time you need for execution.
#SBATCH --time=02:59:00

#### Request the memory you need for your job.
##SBATCH --mem-per-cpu=2600M

### Request & nodes
#SBATCH --account=test1234
#SBATCH --nodes=2
#SBATCH --ntasks=72

### Load the required module files
module load GCC/11.3.0
module load OpenMPI/4.1.4
module load OpenFOAM/v2206

### start the OpenFOAM binary in parallel, cf.
decomposePar -force
$MPIEXEC $FLAGS_MPI_BATCH buoyantSimpleFoam -parallel >logSimulation.compress

reconstructPar -latestTime