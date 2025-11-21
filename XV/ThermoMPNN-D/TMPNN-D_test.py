"""
In this file we test the ThermoMPNN-D model on some example data.

First we import the necessary libraries and modules using:
conda create -n ThermoMPNN-D python=3.10 -y
conda activate ThermoMPNN-D
pip install git+https://github.com/YaoYinYing/ThermoMPNN-D.git

Then run the following command to test the model on a single PDB file:

thermompnn --mode single --pdb XV/PDBs/1VII.pdb --batch_size 256 --out XV/thermompnn_out/1VII/

the PDB file was downloaded from RCSB PDB (https://www.rcsb.org/structure/1VII).


"""

"""
make a new output file with only interaction relevant data.

This requires filtering the original thr100 file and only keep the mutation which
are found in the C380 dataset.
"""
import pandas as pd

output = pd.read_csv("XV/out/6m0j/single_thr100_6m0j.csv")
C380_file = pd.read_csv("XV/data/C380.csv", sep=";")


output_filtered = output[output['Mutation'].isin(C380_file['Mutation(s)'])]


print(output_filtered[1:10])