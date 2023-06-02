// A Resettable D Flip-Flop
// ### Author Name : Walid Akash (walidakash070@gmail.com)

module flipflop_r #(
    parameter int WIDTH = 8
) (
    input logic clk_i,
    input logic rst_i,
    input logic [WIDTH-1:0] d_i,
    output logic [WIDTH-1:0] q_o
);

  //-Assignment

  always_ff @(posedge clk_i, posedge rst_i) begin
    if (rst_i) begin
      q_o <= 0;
    end else begin
      q_o <= d_i;
    end
  end

endmodule
