`ifndef TOP_COVERAGE_SV
`define TOP_COVERAGE_SV 

class top_coverage extends uvm_component;

  `uvm_component_utils(top_coverage)
  `uvm_analysis_imp_decl(_comparador_rnm)
  uvm_analysis_imp_comparador_rnm#(comparador_rnm_uvc_sequence_item, top_coverage) comparador_rnm_imp_export;


  comparador_rnm_uvc_sequence_item m_trans;

    covergroup m_cov;

    cp_p: coverpoint m_trans.m_p_i {bins m_p_bin[]={[0 : 1]};}
    cp_n: coverpoint m_trans.m_n_i {bins m_n_bin[]={[0 : 1]};}
    cp_c: coverpoint m_trans.m_p_i {bins m_c_bin[]={[0 : 1]};}

    cross_pn: cross cp_p, cp_n;




    endgroup

  extern function new(string name, uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void report_phase(uvm_phase phase);
  extern function void write_comparador_rnm(input comparador_rnm_uvc_sequence_item t);

endclass : top_coverage


function top_coverage:: new(string name, uvm_component parent);
super.new(name,parent);
m_trans = comparador_rnm_uvc_sequence_item::type_id::create("m_trans");
m_cov=new();
endfunction: new

function void top_coverage::build_phase(uvm_phase phase);
comparador_rnm_imp_export = new("comparador_rnm_imp_export",this);
endfunction: build_phase    

function void top_coverage::write_comparador_rnm(input comparador_rnm_uvc_sequence_item t);
    m_trans = t;
    m_cov.sample();


endfunction : write_comparador_rnm

function void top_coverage::report_phase (uvm_phase phase);

  `uvm_info(get_type_name(), $sformatf("FINAL Coverage Score = %3.1f%%", m_cov.get_coverage()), UVM_DEBUG)

endfunction: report_phase



`endif // TOP_SCOREBOARD_SV
