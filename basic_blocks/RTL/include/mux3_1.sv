// A 3:1 MUX
// ### Author Name : Walid Akash (walidakash070@gmail.com)

module mux3_1 #(
    parameter int WIDTH = 8
) (
    input logic [WIDTH-1:0] d0_i,
    input logic [WIDTH-1:0] d1_i,
    input logic [WIDTH-1:0] d2_i,
    input logic [1:0] select_i,
    output logic [WIDTH-1:0] y_o
);

  //-Assignment

  assign y_o = select_i[1] ? d2_i : (select_i[0] ? d1_i : d0_i);

endmodule
