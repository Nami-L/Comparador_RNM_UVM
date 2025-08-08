module tb;

  `include "uvm_macros.svh"
  import uvm_pkg::*;
  
  import top_test_pkg::*;

 // Clock signal
  localparam time CLK_PERIOD = 10ns;
  logic clk_i = 0;
  always #(CLK_PERIOD / 2) clk_i = ~clk_i;
  
  // Reset signal
  logic rst_i = 1;
  initial begin
    repeat(2) @(posedge clk_i);
    rst_i = 1;
    @(posedge clk_i);
    rst_i = 0;
  end
  

//Interface

comparador_rnm_uvc_if comparador_rnm_vif(clk_i);

comparador_rnm dut(
.p_i(comparador_rnm_vif.p_i),
.n_i(comparador_rnm_vif.n_i),
.c_o(comparador_rnm_vif.c_o)

);


  initial begin
    $timeformat(-9, 0, " ns", 10);
    uvm_config_db#(virtual comparador_rnm_uvc_if)::set(null, "uvm_test_top.m_env.m_comparador_rnm_agent", "vif", comparador_rnm_vif);
    run_test();
    $fsdbDumpvars;                // Synopsys VCS

  end

  
endmodule:tb