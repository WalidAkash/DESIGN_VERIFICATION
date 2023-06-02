// A 2-input Generic adder
// ### Author Name : Walid Akash (walidakash070@gmail.com)

module adder (
    input  [31:0] a_i,
    input  [31:0] b_i,
    output [31:0] y_o
);

  //-Assignment

  assign y_o = a_i + b_i;

endmodule
