`ifndef COMPARADOR_RNM_UVC_IF_SV
`define COMPARADOR_RNM_UVC_IF_SV

interface comparador_rnm_uvc_if (input logic clk_i);



 logic p_i;
 logic n_i;

 logic  c_o;



//INICIALIZAR VALORES
initial begin

p_i = 'd0;
n_i = 'd0;


end


clocking cb_drv @(posedge clk_i);
    default input #1ns output #1ns;
    output p_i;
output n_i;


  endclocking : cb_drv

  clocking cb_mon @(posedge clk_i);
    default input #1ns output #1ns;

    input c_o;


  endclocking : cb_mon


endinterface: comparador_rnm_uvc_if

`endif // COMPARADOR_RNM_UVC_IF_SV
