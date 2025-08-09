//=============================================================================
// [Filename]       Comparador de un modelo analogico utilizando RNM
// [Project]        Probe
// [Author]         Luis Namigtle - namigtle066@gmail.com
// [Language]       GNU Makefile
// [Created]        Jun 2025
// [Modified]       -
// [Description]    Comparador usando Digital mixed signal. P es positivo, N Negativo de un comparador ideal
// [Notes]          -Se usa Real porque se van a simular o testear con valores decimales, suponiendo que estamos imitando un circuito analogico
// [Status]         Stable
// [Revisions]      -
//=============================================================================

module comparador_rnm(
    input real p_i,
    input real n_i,
    output real c_o
);

always_comb begin


    c_o = (p_i > n_i) ? 1.0 : 0.0;
end


endmodule