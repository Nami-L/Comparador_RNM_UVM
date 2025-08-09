`ifndef TOP_TEST_VSEQ_SV
`define TOP_TEST_VSEQ_SV

class top_test_vseq extends uvm_sequence;

  `uvm_object_utils(top_test_vseq)
  `uvm_declare_p_sequencer(top_vsqr)

  extern function new(string name = "");

  extern task comparador_rnm_rand_seq();
  extern task body();

endclass : top_test_vseq


function top_test_vseq::new(string name = "");
  super.new(name);
endfunction : new


task top_test_vseq::comparador_rnm_rand_seq();
  comparador_rnm_uvc_sequence_base seq;
  seq = comparador_rnm_uvc_sequence_base::type_id::create("seq");

  if (!(seq.randomize() with {
        // m_trans no se declara ni se crea en top_test_vseq, porque ya está declarado y 
        // creado dentro de tu clase comparador_rnm_uvc_sequence_base

        //el objeto es m_name y accedemos al item
        m_trans.m_p_i inside {[0 : 1]};
        m_trans.m_n_i inside {[0 : 1]};


      }))
    `uvm_fatal("RAND_ERROR", "Randomization error!")
  seq.start(p_sequencer.m_comparador_rnm_sequencer);
endtask : comparador_rnm_rand_seq


task top_test_vseq::body();

  // Initial delay
  #(50ns);

  repeat (5) begin
    comparador_rnm_rand_seq();
  end

  // Drain time
  #(50ns);

endtask : body

`endif  // TOP_TEST_VSEQ_SV
