`ifndef TOP_ENV_SV
`define TOP_ENV_SV

class top_env extends uvm_env;
  `uvm_component_utils(top_env)


  comparador_rnm_uvc_agent m_comparador_rnm_agent;
  comparador_rnm_uvc_config m_comparador_rnm_config;
  top_scoreboard m_scoreboard;
  top_coverage m_coverage;
  top_vsqr        vsqr;


extern function new(string name, uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
endclass: top_env


function top_env::new(string name, uvm_component parent);
super.new(name,parent);
endfunction:new

function void top_env::build_phase(uvm_phase phase);
//instanciamos el archivo de configuracion
m_comparador_rnm_config = comparador_rnm_uvc_config::type_id::create("m_comparador_rnm_config");
m_comparador_rnm_config.is_active = UVM_ACTIVE;
uvm_config_db#(comparador_rnm_uvc_config)::set(this,"m_comparador_rnm_agent*","config",m_comparador_rnm_config);
//instaciar el Agente
m_comparador_rnm_agent= comparador_rnm_uvc_agent::type_id::create("m_comparador_rnm_agent",this);
m_coverage = top_coverage::type_id::create("m_comparador_rnm_coverage",this);
m_scoreboard= top_scoreboard::type_id::create("m_comparador_rnm_scoreboard",this);
vsqr = top_vsqr::type_id::create("vsqr",this);
endfunction: build_phase

function void top_env::connect_phase(uvm_phase phase);
vsqr.m_comparador_rnm_sequencer = m_comparador_rnm_agent.m_sequencer;

m_comparador_rnm_agent.analysis_port.connect(m_scoreboard.comparador_rnm_imp_export);
m_comparador_rnm_agent.analysis_port.connect(m_coverage.comparador_rnm_imp_export);

endfunction: connect_phase


`endif  // TOP_TEST_ENV_SV
