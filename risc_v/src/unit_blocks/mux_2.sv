// A 2:1 MUX
// ### Author Name : Walid Akash (walidakash070@gmail.com)

module mux_2
import rv32i_pkg::*;
(
  input logic [DPW-1:0] d0_i,
  input logic [DPW-1:0] d1_i,
  input logic s_i,
  output logic [DPW-1:0] y_o
);

//-Assignement

assign y_o = s_i ? d1_i : d0_i;

endmodule
