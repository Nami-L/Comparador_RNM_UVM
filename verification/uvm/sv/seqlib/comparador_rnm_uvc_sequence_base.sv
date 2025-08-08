`ifndef COMPARADOR_RNM_UVC_SEQUENCE_BASE_SV
`define COMPARADOR_RNM_UVC_SEQUENCE_BASE_SV

class comparador_rnm_uvc_sequence_base extends uvm_sequence #(comparador_rnm_uvc_sequence_item);
  `uvm_object_utils(comparador_rnm_uvc_sequence_base)

  rand comparador_rnm_uvc_sequence_item m_trans;


  extern function new(string name = "");

  extern virtual task body();

endclass: comparador_rnm_uvc_sequence_base

function comparador_rnm_uvc_sequence_base::new(string name ="");
super.new(name);
m_trans = comparador_rnm_uvc_sequence_item::type_id::create("m_trans");
endfunction:new



task comparador_rnm_uvc_sequence_base::body();
  start_item(m_trans);
  finish_item(m_trans);
endtask : body

`endif  // COMPARADOR_RNM_UVC_SEQUENCE_BASE_SV
