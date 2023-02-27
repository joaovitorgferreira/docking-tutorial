
# Basic rotocol for protein-ligand docking

Step by step to perform both rigid and flexible protein-ligand docking.

## Basic requirements

To perform molecular docking, some basic software is required:

- [Avogadro](https://avogadro.cc/)
- [MOPAC](http://openmopac.net/downloads.html)
- [Discovery Studio Visualizer](https://discover.3ds.com/discovery-studio-visualizer-download)
- [AutoDockTools](http://mgltools.scripps.edu/downloads)
- [Notepad++](https://notepad-plus-plus.org/downloads/)
- [AutoDock Vina](https://vina.scripps.edu/downloads/)
- [Modeller](https://salilab.org/modeller/download_installation.html)
- [PyMOL](https://pymol.org/2/#download)

In addition, a device with an Intel Core i5 or better processor and at least 5 CPU cores is recommended.

## Getting started

The first step in performing molecular docking is to determine your protein and ligand.
Once these two elements are defined, the corresponding files must be obtained in reliable databases.

For proteins, recommended databases are:

- [Protein Data Bank](https://www.rcsb.org/)
- [UniProt](https://www.uniprot.org/)

Once the protein of interest is found, it must be downloaded in PDB format.

> Attention: for best results, it is preferable to look for proteins whose resolution is less than 2 Å

For ligands, recommended database is:

- [PubChem](https://pubchem.ncbi.nlm.nih.gov/)

Once the ligand of interest is found, download its 3D conformer in SDF format.

With these files in hand, you can proceed to prepare the files for docking.

## Protein preparation

To prepare your protein, you must clean it, check that it does not have any missing residues, adjust its protonation state, even out the charges and define the grid box.

### Cleaning your protein

- Open the PDB file on Discovery Studio Visualizer (DSV);
- Analyze and clean your protein, removing any water molecules, ligands and ions;
- Save it as a new PDB file.

### Checking for missing residues

- Change your protein file name to 'qpdb' and use script1.py from the missing_residue_folder.

> Remember to have both the qpdb file and the scripts in the same folder on your computer!

- To use the script, first you have to open Modeller and change the directory to the folder where you have your files;
- To do so, copy the path to your folder, type chdir on Modeller and paste the path there;
- Once you have done that, you just need to type script1.py and tap Enter. A new file will be generated in that folder: qdbq.seq. This file will have the sequence of aminoacid residues present in your protein;
- Open this file on Notepad++;
- Go to either [Protein Data Bank](https://www.rcsb.org/) or [UniProt](https://www.uniprot.org/), search for your protein and download its fasta file. This file will contain the entire sequence of residues.
- Open the fasta file with Notepad++;
- Go to https://www.ebi.ac.uk/Tools/psa/emboss_needle/;
- Copy and paste the sequence from the qdbq.seq file into the first box;
- Then copy and paste the sequence from the fasta file into the second box. 

> Make sure to **only** copy and paste the protein sequence!

![image](https://user-images.githubusercontent.com/90862308/221652565-6d021e0d-7040-4746-bed7-1346a5f133bf.png)

- Scroll down and click Submit.

> If everything is OK, you should see a screen like the one below. If not, check your sequences. 

![image](https://user-images.githubusercontent.com/90862308/221652621-f6812aa0-86ca-4089-8429-551d7fcf48a2.png)

>> Common mistakes are leaving extra information (like headers) or using a double sequence (in case of dimers, for example) to compare with a single monomer sequence.

- Click “View Alignment File”, then right-click and choose Save As to save the txt file with all the information. This is the pairwise alignment file;
- Open the alignment.ali file with Notepad++;
- Copy and paste the protein sequences there, first from your crystalized protein (under >P1;qpdb), and then from the fasta file (under >P1;qpdb_fill / sequence:::::::::). 

> Do not remove the asterisk * from the end of the sequence!

- Open the pairwise alignment file with Notepad++ and compare it with your original protein sequence;
- If your protein does not have missing residues, move to the protonation state adjustment;
- Otherwise, add hyphens (-) where there are residues missing – exactly as it is in the pairwise alignment file. Save it.
- Now go back to Modeller, type script2.py and tap Enter.
- In your folder, you will now find qpdb_fill files. These are the possible conformation models created for your now complete protein. Now you can check them on PyMOL and see how they align with each other.
- Open PyMOL, click File > Open… and select your qpdb_fill files. To see how they align together, click Plugin > Alignment, and OK.
- Choose the conformation you find adequate (usually the last generated one) and let us move to the next step: protonation state.

### Protonation state adjustment

- To change the protonation state, go to https://server.poissonboltzmann.org/pdb2pqr and click Upload a PDB file to upload the pdb file of the best conformation generated in the previous step. 
- Select the pH of interest, choose AMBER in both lines under the Forcefield Options menu, and click Start Job.

> Once the job is done, several files will be generated, but we only need to download the LOG and PQR files. The .log file will describe all the changes made to the protein, and the .pqr is the changed protein that we will use later on.

- To use the changed protein for the docking process, we need to convert it to pdb format. For that, go to PyMOL, File > Open… and select your .pqr file;
- Select Display > Sequence to view the sequence of residues for the protein and check if there aren't any issues with it.

> Sometimes the protonation state changing process creates typos to the residue names, such as calling Lysine “LYN” instead of “LYS”.

- If you detect problems in your sequence, open the PQR file with Notepad++ and correct it;
- Go back to PyMOL, open the corrected PQR file;
- Then go to File> Export Molecule > Save and save the molecule as a PDB file.

### Evening out the charges

- Open AutoDockTools, select File > Read Molecule, and open the PDB file created in the previous step;
- Then go to Edit > Atoms > Assign AD4 type, then Edit > Atoms > Assign Radii, select United Radii, but leave the Overwrite Radii box unchecked. Click OK;
- Go to Edit > Charges > Add Kollman Charges, then Edit > Charges > Compute Gasteiger.
- Proceed to Edit > Charges > Check Totals on Residues. If the molecule presents a charge deficit, click on “Spread Charge Deficit over all atoms in residue” and then click “Dismiss”;
- Next, go to Edit > Charges > Check Totals on Residues to check if the charges were well spread.

> If the pop-up message says that there is “no residues with non-integral charges found”, move to the next step. If not, repeat previous steps.

### Setting up the Grid Box

- In the lower menu of AutoDockTools, go to Grid > Grid Box > Choose and select your protein. The program will save a PDBQT file;
- Name it “receptor” – that’s the protein file to be used in the script in later steps.
- Select Grid > Grid Box, and change the option Spacing (angstrom) to 1.000. The first 3 measures represent the sizes of the box; the last 3 ones represent the coordinates of the box.
- Adjust the position and then the size of the box to cover the active site or the whole protein (in case of blind docking).

> Blind docking is used when the location of an enzyme's active site is unknown. In this case, the grid box is used throughout the entire length of the protein.
>> For more information, check [this article](https://www.nature.com/articles/s41598-017-15571-7)

- Click File > Output grid dimensions file, to save the values for the position and size of the box.

## Performing rigid docking

- Open the DockingScript folder, transfer all the ligand files to the ligands folder;
- Open the vina.txt file with Notepad++ and change the first line to receptor = receptor.pdbqt;
- Open the grid dimensions file with Notepad++ and copy and paste the coordinates and size values into the vina.txt file. Save it.

> Make sure to have the ligands folder and the receptor.pdbqt, script_vina, vina, vina.txt files all in the same folder.

- Click on the script_vina file and follow the instructions to perform the docking process.

> The process will work independently and return two new folders: log and out. In the log folder, you will find the logs of the process, with information such as the affinity of each conformer to a specific position in the protein. In the out folder, you will find all the ligand conformers as .pdbqt files.

- To see and analyze the interactions between each conformer and the protein, go to Discovery Studio and just click File > Open, then select All Files, and open the PDBQT protein file (the one named ‘receptor’);
- Open the out folder and slide one of the PDBQT ligand files to the protein you opened on Discovery Studio; 
- In the left menu, select the ligand and click Define Ligand: <undefined> to define the molecule as your ligand;
- Click Ligand Interactions to show all the automatically detected interactions between the ligand and the residues;
- Then you can click Show Distances to see their distances.
  
## Performing flexible docking

