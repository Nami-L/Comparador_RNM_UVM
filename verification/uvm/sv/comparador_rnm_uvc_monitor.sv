`ifndef COMPARADOR_RNM_UVC_MONITOR_SV
`define COMPARADOR_RNM_UVC_MONITOR_SV

class comparador_rnm_uvc_monitor extends uvm_monitor;

  `uvm_component_utils(comparador_rnm_uvc_monitor)

  uvm_analysis_port #(comparador_rnm_uvc_sequence_item)       analysis_port;

  virtual comparador_rnm_uvc_if                               vif;
  comparador_rnm_uvc_config                                   m_config;
  comparador_rnm_uvc_sequence_item                            m_trans;

  //VARIABLES AUXILIARES PARA LAS SALIDAS

  logic tem_p;
  logic tem_n;
  logic tem_c;




  extern function new(string name, uvm_component parent);

  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern task do_mon();

endclass : comparador_rnm_uvc_monitor


function comparador_rnm_uvc_monitor::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

function void comparador_rnm_uvc_monitor::build_phase(uvm_phase phase);
  if (!uvm_config_db#(virtual comparador_rnm_uvc_if)::get(get_parent(), "", "vif", vif)) begin
    `uvm_fatal(get_name(), "Could not retrieve comparador_rnm_uvc_if from comparador_rnm db")
  end

  if (!uvm_config_db#(comparador_rnm_uvc_config)::get(get_parent(), "", "config", m_config)) begin
    `uvm_fatal(get_name(), "Could not retrieve comparador_rnm_uvc_config from config db")
  end

  analysis_port = new("analysis_port", this);

endfunction : build_phase

task comparador_rnm_uvc_monitor::run_phase(uvm_phase phase);
  m_trans = comparador_rnm_uvc_sequence_item::type_id::create("m_trans");
  do_mon();
endtask : run_phase

task comparador_rnm_uvc_monitor::do_mon();


  forever begin
 
    tem_p = vif.p_i;
    tem_n = vif.n_i;
    tem_c = vif.c_o;

  @(vif.cb_drv);

     if ((tem_p != vif.p_i) || (tem_n != vif.n_i) || (tem_c != vif.c_o)) begin

      m_trans.m_p_i = vif.p_i;
      m_trans.m_n_i = vif.n_i;
      m_trans.m_c_o = vif.c_o;

      `uvm_info(get_type_name(), {"\n ------ MONITOR (GPIO UVC) ------ ", m_trans.convert2string()
                }, UVM_DEBUG)
      //manda la transaction hacia el siguiente componente
      analysis_port.write(m_trans);

  end

  end
endtask : do_mon

`endif  // COMPARADOR_RNM_UVC_MONITOR_SV
