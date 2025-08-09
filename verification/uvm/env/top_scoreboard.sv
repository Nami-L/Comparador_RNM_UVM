`ifndef TOP_SCOREBOARD_SV
`define TOP_SCOREBOARD_SV

class top_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(top_scoreboard)
  `uvm_analysis_imp_decl(_comparador_rnm)
  uvm_analysis_imp_comparador_rnm #(comparador_rnm_uvc_sequence_item, top_scoreboard) comparador_rnm_imp_export;

  int unsigned m_num_passed;
  int unsigned m_num_failed;
  comparador_rnm_uvc_sequence_item m_comparador_rnm_queue[$];


  extern function new(string name, uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void report_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern function void write_comparador_rnm(input comparador_rnm_uvc_sequence_item t);

endclass : top_scoreboard


function top_scoreboard::new(string name, uvm_component parent);
  super.new(name, parent);
  m_num_passed = 0;
  m_num_failed = 0;
endfunction : new

function void top_scoreboard::build_phase(uvm_phase phase);
  comparador_rnm_imp_export = new("comparador_rnm_imp_export", this);
endfunction : build_phase

function void top_scoreboard::write_comparador_rnm(input comparador_rnm_uvc_sequence_item t);
  comparador_rnm_uvc_sequence_item received_trans;
  received_trans = comparador_rnm_uvc_sequence_item::type_id::create("received_trans");
  received_trans.do_copy(t);
  m_comparador_rnm_queue.push_back(received_trans);
endfunction : write_comparador_rnm

task top_scoreboard::run_phase(uvm_phase phase);

 string s;
// 
 forever begin

      wait (m_comparador_rnm_queue.size() > 0 );

      foreach (m_comparador_rnm_queue[i]) begin

        //Modelo de referencia: Comparo los valores guardados para p y n en una nueva variable

        bit valor_experado = ((m_comparador_rnm_queue[i].m_p_i >  m_comparador_rnm_queue[i].m_n_i) ? 1'b1: 1'b0);

      // utilizo esa variable para comprobar que es igual a mi salida tambien guardado
      if ((valor_experado === m_comparador_rnm_queue[i].m_c_o)) begin
        m_num_passed++;
       // `uvm_info(get_type_name(), $sformatf("PASS:  (m_p_i=%0b, m_n_i=%0d)",
       //                                            m_comparador_rnm_queue[i].m_p_i,
       //                                            m_comparador_rnm_queue[i].m_n_i), UVM_LOW)
      end else begin
        m_num_failed++;
       //         `uvm_info(get_type_name(), $sformatf("FAIL:  (m_p_i=%0b, m_n_i=%0d)",
       //                                            m_comparador_rnm_queue[i].m_p_i,
       //                                            m_comparador_rnm_queue[i].m_n_i), UVM_LOW)
      end

      end
   
 
       foreach (m_comparador_rnm_queue[i]) begin
 
         s = {s, $sformatf("\nTRANS[%3d]: \n ------ SCOREBOARD (comparador_rnm UVC) ------  ", i) ,m_comparador_rnm_queue[i].convert2string(), "\n"};
     end
       `uvm_info(get_type_name(), s, UVM_DEBUG)
       s="";
 
   m_comparador_rnm_queue.delete();
 
 end

endtask : run_phase





function void top_scoreboard::report_phase(uvm_phase phase);

  //string s;
 //    foreach (m_comparador_rnm_queue[i]) begin
 //      s = {s, $sformatf("\nTRANS[%3d]: \n", i+1) ,m_comparador_rnm_queue[i].convert2string(), "\n"};
 //    end
 //    `uvm_info(get_type_name(), s, UVM_DEBU

  `uvm_info(get_type_name(), $sformatf("PASS= %3d, FAIL = %3d", m_num_passed, m_num_failed),
            UVM_DEBUG)

endfunction : report_phase

`endif  // TOP_SCOREBOARD_SV
