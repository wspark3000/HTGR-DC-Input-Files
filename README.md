# HTGR-DC-Input-Files

This repository includes input files to reproduce the results in a paper, "Frequency-Dependent Dynamic Analysis of a Prismatic HTGR Power System for Data Center Applications".

**ThermoPower**: A modified source code of ThermoPower library, which requires OpenModelica v1.26.7 (not tested in other OpenModelica versions). All new codes are compiled in ThermoPower/customModel which has the same folder architecture as the original one. _Examples_ folder contain some simple verifications of the models.

**OMfiles**: OpenModelica input files. _BasicProfile_PID/SMC.mo_: model for reference tuning case with 100-15-100% power change.

**Pythonfiles**: Python scripts to run OpenModelica simulations, reconstruct data center load signals, and generate figures. The required reference data center measurements can be found in here: https://data.nlr.gov/submissions/312.
