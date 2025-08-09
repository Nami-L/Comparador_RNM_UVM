`ifndef COMPARADOR_RNM_UVC_DRIVER_SV
`define COMPARADOR_RNM_UVC_DRIVER_SV

class comparador_rnm_uvc_driver extends uvm_driver #(comparador_rnm_uvc_sequence_item);

  `uvm_component_utils(comparador_rnm_uvc_driver)

  virtual comparador_rnm_uvc_if vif;
  comparador_rnm_uvc_config     m_config;

  extern function new(string name, uvm_component parent);

  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern task do_drive();

endclass : comparador_rnm_uvc_driver


function comparador_rnm_uvc_driver::new(string name, uvm_component parent);
super.new(name,parent);
endfunction:new

function void comparador_rnm_uvc_driver::build_phase(uvm_phase phase);
  if (!uvm_config_db#(virtual comparador_rnm_uvc_if)::get(get_parent(), "", "vif", vif)) begin
    `uvm_fatal(get_name(), "Could not retrieve comparador_rnm_uvc_if from VIF db")
  end

if (!uvm_config_db#(comparador_rnm_uvc_config)::get(get_parent(), "", "config", m_config)) begin
    `uvm_fatal(get_name(), "Could not retrieve comparador_rnm_uvc_config from config db")
  end

endfunction:build_phase

task comparador_rnm_uvc_driver::run_phase(uvm_phase phase);
forever begin
    //Lo que hace este run, por siempre, agarra el drive, agarra una transaction del sequencer
     seq_item_port.get_next_item(req);
     do_drive();
     seq_item_port.item_done();

end
endtask: run_phase

task comparador_rnm_uvc_driver::do_drive();
@(vif.cb_drv);

  `uvm_info(get_type_name(), {"\n ------ DRIVER (comparador_rnm UVC) ------", req.convert2string()}, UVM_DEBUG)

  vif.cb_drv.p_i  <=  req.m_p_i;
  vif.cb_drv.n_i  <=  req.m_n_i;

endtask: do_drive



`endif // COMPARADOR_RNM_UVC_DRIVER_SV
