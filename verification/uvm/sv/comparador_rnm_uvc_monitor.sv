`ifndef COMPARADOR_RNM_UVC_MONITOR_SV
`define COMPARADOR_RNM_UVC_MONITOR_SV

class comparador_rnm_uvc_monitor extends uvm_monitor;

  `uvm_component_utils(comparador_rnm_uvc_monitor)

  uvm_analysis_port #(comparador_rnm_uvc_sequence_item) analysis_port;

  virtual comparador_rnm_uvc_if                         vif;
  comparador_rnm_uvc_config                             m_config;
  comparador_rnm_uvc_sequence_item                      m_trans;

  //VARIABLES AUXILIARES PARA LAS SALIDAS

// Tener cuidado de que si manejas reales, la comparación debe ser igual real, porque  al hacer la comparación con enteros puede fallar
//   tem_p = vif.p_i; le asigno un real a un entero, pero si hay una minima variacion en el valor real el entero lo va a detectar como un cambio
// supongamos que vif.p_i ambia de 0.01 a 0.02 ambos son 1, pero si estaba en cero y pasa a 0.01, el entero lo va a detectar como un cambio
// por eso tengo mayor cantidad de monitorizaciones y no me pierdo ninguna 
  real                                                tem_p;
  real                                                 tem_n;
  real                                                tem_c;
  bit                                                tem_c_int;




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


//localparam real EPSILON = 1e-6;

  forever begin

    tem_p = vif.p_i;
    tem_n = vif.n_i;
    tem_c = vif.c_o;
    tem_c_int = vif.c_int_o;

    @(vif.cb_drv);

// if ((tem_p - vif.p_i > EPSILON) || (vif.p_i - tem_p > EPSILON) ||
//     (tem_n - vif.n_i > EPSILON) || (vif.n_i - tem_n > EPSILON) ||
//     (tem_c - vif.c_o > EPSILON) || (vif.c_o - tem_c > EPSILON)) begin

    if ((tem_p != vif.p_i) || (tem_n != vif.n_i) || (tem_c != vif.c_o) || tem_c_int != vif.c_int_o) begin

      m_trans.m_p_i_real = vif.p_i;
      m_trans.m_n_i_real = vif.n_i;
      m_trans.m_c_o_real = vif.c_o;
      m_trans.m_c_int_o = vif.c_int_o;


      m_trans.m_c_o = int'(vif.c_o);

      `uvm_info(get_type_name(), {"\n ------ MONITOR (GPIO UVC) ------ ", m_trans.convert2string()
                }, UVM_DEBUG)
      //manda la transaction hacia el siguiente componente
      analysis_port.write(m_trans);

    end

  end
endtask : do_mon

`endif  // COMPARADOR_RNM_UVC_MONITOR_SV