`ifndef COMPARADOR_RNM_UVC_SEQUENCER_SV
`define COMPARADOR_RNM_UVC_SEQUENCER_SV


class comparador_rnm_uvc_sequencer extends uvm_sequencer #(comparador_rnm_uvc_sequence_item);

  `uvm_component_utils(comparador_rnm_uvc_sequencer)

  comparador_rnm_uvc_config m_config;

  extern function new(string name, uvm_component parent);

  extern function void build_phase(uvm_phase phase);

endclass : comparador_rnm_uvc_sequencer

function comparador_rnm_uvc_sequencer::new(string name, uvm_component parent);
super.new(name,parent);
endfunction:new

function void comparador_rnm_uvc_sequencer::build_phase(uvm_phase phase);

if(!uvm_config_db#(comparador_rnm_uvc_config)::get(get_parent(),"","config",m_config))begin
    `uvm_fatal(get_name(), "Could not retrieve comparador_rnm_uvc_config from config db")

end
endfunction:build_phase



`endif // COMPARADOR_RNM_UVC_SEQUENCER_SV
