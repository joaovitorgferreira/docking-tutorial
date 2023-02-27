::cmd
@echo off
TITLE VINA BAT
:start
color 9
echo                       AUTODOCK VINA FOR VIRTUAL SCREENING
echo    --------------------------------------------------------------------------
echo                  LABORATORIO DE BIOQUIMICA TOXICOLOGICA - UFSM
echo                                   Version: Bright
echo    --------------------------------------------------------------------------              
echo *     
pause
echo This program is configured as follows:
echo The configuration file is called "vina.txt".
echo The binders are saved in a folder called "ligands."
echo The vina.exe program is copied in the present directory or in the user's PATH
pause
echo The Output files (results) and logs will be saved in folders called "out" and "log".
echo These folders will be created if they do not already exist.
echo The Vina program will be compiled as a low priority process.
pause
mkdir out
mkdir log
start /low /b for %%T in (ligands/*.pdbqt) do (vina --receptor receptor_rigid.pdbqt --flex receptor_flex.pdbqt --ligand ligands/%%T --config vina2.txt --log log2/%%~nT.txt --out out2/%%T --exhaustiveness 32)

#vina --receptor receptor_rigid.pdbqt --flex receptor_flex.pdbqt --ligand 1iep_ligand.pdbqt --config 1fpu_receptor_rigid_vina_box.txt --exhaustiveness 32 --out 1fpu_ligand_flex_vina_out.pdbqt