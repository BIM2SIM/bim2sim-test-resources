#!/usr/bin/zsh
#SBATCH --job-name=newJob

### Request the time you need for execution.
#SBATCH --time=23:59:00

#### Request the memory you need for your job.
##SBATCH --mem-per-cpu=2600M
#SBATCH --output=lognewJob.txt

### Request processes & nodes

#SBATCH --nodes=1
#SBATCH --ntasks=12

### Load the required module files
module load GCC/11.3.0
module load OpenMPI/4.1.4
source /work/rwth1588/openfoam-correctedSolar/etc/bashrc

### start the OpenFOAM binary in parallel, cf.
blockMesh
decomposePar -force
$MPIEXEC $FLAGS_MPI_BATCH snappyHexMesh -parallel -overwrite >logMeshing.compress

reconstructParMesh -mergeTol 1e-10 -constant
topoSet
setsToZones
checkMesh > logCheckMesh.compress
decomposePar -force
$MPIEXEC $FLAGS_MPI_BATCH buoyantSimpleFoam -parallel >logSimulation.compress

reconstructPar -latestTime