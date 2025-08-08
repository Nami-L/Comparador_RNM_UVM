`ifndef COMPARADOR_RNM_UVC_SEQUENCE_ITEM_SV
`define COMPARADOR_RNM_UVC_SEQUENCE_ITEM_SV

class comparador_rnm_uvc_sequence_item extends uvm_sequence_item;

  `uvm_object_utils(comparador_rnm_uvc_sequence_item)

  // Transaction variables

 rand int m_p_i;
rand int m_n_i;

//real  m_p_i_real;
//real m_n_i_real;


  // Readout variables

  logic m_c_o;


  extern function new(string name = "");

  extern function void do_copy(uvm_object rhs);
  extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
  extern function void do_print(uvm_printer printer);
  extern function string convert2string();

endclass : comparador_rnm_uvc_sequence_item

function comparador_rnm_uvc_sequence_item::new(string name = "");
  super.new(name);
endfunction : new
  // Después de randomizar, convertir a real
 // function void post_randomize();
 //   m_p_i_real = m_p_i_int / 100.0;
 //   m_n_i_real = m_n_i_int / 100.0;
 // endfunction

function void comparador_rnm_uvc_sequence_item::do_copy(uvm_object rhs);
  // Cuando creo un objeto es un lugar de memoria y si quiero copiarlo necesito
  //agregar memoria

  //Al momento de mandar la transaction es un objeto necesito la copia de ese objeto
  comparador_rnm_uvc_sequence_item rhs_;
  if (!$cast(rhs_, rhs)) `uvm_fatal(get_type_name(), "Cast of rhs object failed")
  super.do_copy(rhs);

  m_p_i = rhs_.m_p_i;
  m_n_i = rhs_.m_n_i;
  m_c_o = rhs_.m_c_o;

endfunction : do_copy

function bit comparador_rnm_uvc_sequence_item::do_compare(uvm_object rhs, uvm_comparer comparer);

  bit result;
  comparador_rnm_uvc_sequence_item rhs_;
  if (!$cast(rhs_, rhs)) `uvm_fatal(get_type_name(), "Cast of rhs object failed")

  result = super.do_compare(rhs, comparer);
  result &= (m_p_i == rhs_.m_p_i);
  result &= (m_n_i == rhs_.m_n_i);
  //result &= (m_p_i == rhs_.m_p_i_real);
  //result &= (m_n_i == rhs_.m_n_i_real);
  result &= (m_c_o == rhs_.m_c_o);
  return result;


endfunction : do_compare

function void comparador_rnm_uvc_sequence_item::do_print(uvm_printer printer);
  if (printer.knobs.sprint == 0) `uvm_info(get_type_name(), convert2string(), UVM_MEDIUM)
  else printer.m_string = convert2string();
endfunction : do_print

function string comparador_rnm_uvc_sequence_item::convert2string();
  string s;
  s = super.convert2string();
  $sformat(s, {s, "\n", "TRANSACTION INFORMATION (comparador_rnm UVC):"});
  $sformat(s, {s, "\n", "m_p_i = %5d, m_n_i = %5d, m_c_o = %5d\n"},m_p_i,m_n_i,m_c_o);
  return s;
endfunction : convert2string



`endif  // COMPARADOR_RNM_UVC_SEQUENCE_ITEM_SV
