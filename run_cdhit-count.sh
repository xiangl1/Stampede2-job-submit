#!/bin/bash

#SBATCH -A iPlant-Collabs
#SBATCH -J ncbi-Eutility-Download
#SBATCH -N 1
#SBATCH -n 8
#SBATCH -p skx-normal
#SBATCH -t 48:00:00
#SBATCH --mail-type=fail
#SBATCH --mail-user=xiangl1@email.arizona.edu

cd /work/04114/xiangl1/stampede2/mmetsp/scripts

cdhit-count.pl -i ../hmm/cd-hit-out/euk_vir45.clstr -o ../hmm/cd-hit-out/euk_vir45-count
