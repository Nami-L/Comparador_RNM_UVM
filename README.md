## IP UVM Verification

Arquitectura genérica de UVM para synopsys

## Setup 

A continuación se colocan una serie de comando que deben ejecutarse desde terminal.


#Comandos para compilar elaborar y simular


make compile
make elaborate
make sim  #Solo ver mensajes
make verdi  # abrir la interfaz grafica
### For tcsh

```bash
setenv GIT_ROOT `git rev-parse --show-toplevel`
setenv UVM_WORK $GIT_ROOT/work/uvm
mkdir -p $UVM_WORK && cd $UVM_WORK
ln -sf $GIT_ROOT/verification/uvm/scripts/makefiles/Makefile.vcs Makefile
ln -sf $GIT_ROOT/verification/uvm/scripts/setup/setup_synopsys_eda.tcsh
source setup_synopsys_eda.tcsh
