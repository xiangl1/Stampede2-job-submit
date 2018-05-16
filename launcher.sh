#!/bin/bash
#
# Simple SLURM script for submitting multiple serial
# jobs (e.g. parametric studies) using a script wrapper
# to launch the jobs.
#
# To use, build the launcher executable and your
# serial application(s) and place them in your WORKDIR
# directory.  Then, edit the CONTROL_FILE to specify 
# each executable per process.
#-------------------------------------------------------
#-------------------------------------------------------
# 
#         <------ Setup Parameters ------>
#

#SBATCH -A iPlant-Collabs
#SBATCH -J launcher
#SBATCH -N 1
#SBATCH -n 16
#SBATCH -p skx-normal
#SBATCH -t 48:00:00
#SBATCH --mail-type=end,fail
#SBATCH --mail-user=xiangl1@email.arizona.edu

#------------------------------------------------------

module load launcher

export LAUNCHER_PLUGIN_DIR="$LAUNCHER_DIR/plugins"
export LAUNCHER_RMI="SLURM"
export LAUNCHER_WORKDIR="/work/04114/xiangl1/stampede2/mmetsp/scripts"
export LAUNCHER_SCHED="interleaved"
export PARAMRUN="$LAUNCHER_DIR/paramrun"
export LIST_DIR="/work/04114/xiangl1/stampede2/mmetsp/hmm"
export LIST_NAME="run_split_by_cdhit_list"

set -u

NJOBS=$(wc -l "$LIST_DIR/$LIST_NAME" | awk '{print $1}')

if [[ $NJOBS -gt 0 ]]; then
    export LAUNCHER_JOB_FILE="$LIST_DIR/$LIST_NAME"
    if [[ $NJOBS -gt 16 ]]; then
        LAUNCHER_PPN=16
    else
        LAUNCHER_PPN=$NJOBS
    fi
    export LAUNCHER_PPN
    $PARAMRUN
    echo "Finished launcher"
else
    echo "No jobs for launcher (something went wobbly)"
fi
