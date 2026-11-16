# HTGR-DC-Input-Files

This repository includes input files to reproduce the results in a paper, "Frequency-Dependent Dynamic Analysis of a Prismatic HTGR Power System for Data Center Applications". The preprint version of this paper can be found in here: https://engrxiv.org/preprint/view/8817

**ThermoPower**: A modified source code of ThermoPower library, which requires OpenModelica v1.26.7 (not tested in other OpenModelica versions). All new codes are compiled in ThermoPower/customModel which has the same folder architecture as the original one. _Examples_ folder contain some simple verifications of the models.

**OpenModelica**: OpenModelica input files.

**Pythons**: Python scripts to run OpenModelica simulations, reconstruct data center load signals, and generate figures. The required reference data center measurements can be found in here: https://data.nlr.gov/submissions/312.

**Results**: Pre-simulated OpenModelica results and DC loads.

**Cases**: _BasicProfile_: reference tuning case, _freq_amp_: sine sweep case, _BaseLoad_: facility-aggregated case, _FastLoad_: workload-resolved case, _Figure.mo_: these are only for graphical representation, _SignalPostProcess_.ipynb: this is for DC load analysis and reconstruction.
