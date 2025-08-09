`ifndef COMPARADOR_RNM_UVC_PKG_SV
`define COMPARADOR_RNM_UVC_PKG_SV

package comparador_rnm_uvc_pkg;

  `include "uvm_macros.svh"
  import uvm_pkg::*;

  `include "comparador_rnm_uvc_sequence_item.sv"  // Este es de mayor jerarquía
  `include "comparador_rnm_uvc_config.sv"
  `include "comparador_rnm_uvc_sequencer.sv"
  `include "comparador_rnm_uvc_driver.sv"
  `include "comparador_rnm_uvc_monitor.sv"

  `include "comparador_rnm_uvc_agent.sv"

  // Sequence library
  `include "comparador_rnm_uvc_sequence_base.sv"

endpackage : comparador_rnm_uvc_pkg

`endif  // COMPARADOR_RNM_UVC_PKG_SV
