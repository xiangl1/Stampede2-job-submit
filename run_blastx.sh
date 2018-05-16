#!/bin/bash

#SBATCH -A iPlant-Collabs
#SBATCH -J blast_launcher
#SBATCH -N 1
#SBATCH -n 16
#SBATCH -p skx-normal
#SBATCH -t 48:00:00
#SBATCH -J blast
#SBATCH --mail-type=all
#SBATCH --mail-user=xiangl1@email.arizona.edu

module load blast

CWD="/work/04114/xiangl1/stampede2/mmetsp/blast"
FILE_LIST="/work/04114/xiangl1/stampede2/mmetsp/meta_list"
FASTA_DIR="/work/04114/xiangl1/stampede2/mmetsp/meta-data"
BLAST_DB="$CWD/blastdb/viral_rdrp"
BLAST_OUT_DIR="$CWD/blast-meta-rdrp"

EVAL="1e-10"
OUT_FMT="6"
NUM_THREADS="12"

while read FASTA_NAME; do
    FASTA="$FASTA_DIR/$FASTA_NAME"
    BLAST_OUT="$BLAST_OUT_DIR/$FASTA_NAME"

    blastx -num_threads $NUM_THREADS -db $BLAST_DB -query $FASTA -out $BLAST_OUT -outfmt $OUT_FMT -evalue $EVAL

done < "$FILE_LIST"

