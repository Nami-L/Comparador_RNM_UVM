`ifndef COMPARADOR_RNM_UVC_CONFIG_SV
`define COMPARADOR_RNM_UVC_CONFIG_SV

class comparador_rnm_uvc_config extends uvm_object;

  `uvm_object_utils(comparador_rnm_uvc_config)

  uvm_active_passive_enum is_active   = UVM_ACTIVE;

  extern function new(string name = "");

endclass : comparador_rnm_uvc_config


function comparador_rnm_uvc_config::new(string name = "");
  super.new(name);
endfunction : new


`endif // COMPARADOR_RNM_UVC_CONFIG_SV
