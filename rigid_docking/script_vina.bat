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
start /low /b for %%T in (ligands/*.pdbqt) do (vina --ligand ligands/%%T --config vina.txt --log log/%%~nT.txt --out out/%%T)