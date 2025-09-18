import gzip
from Bio import SeqIO

filename = "M.leprae.fa.gz"  # or a fastq file

with gzip.open(filename, "rt") as handle:
    for record in SeqIO.parse(handle, "fasta"):  # "fastq" if it's a fastq file
        print(record.id, len(record.seq))
