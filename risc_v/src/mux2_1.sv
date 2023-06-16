// A 2:1 MUX
// ### Author Name : Walid Akash (walidakash070@gmail.com)

module mux2_1 #(
    parameter int WIDTH = 8
) (
    input logic [WIDTH-1:0] d0_i,
    input logic [WIDTH-1:0] d1_i,
    input logic s_i,
    output logic [WIDTH-1:0] y_o
);

  //-Assignement

  assign y_o = s_i ? d1_i : d0_i;

endmodule
