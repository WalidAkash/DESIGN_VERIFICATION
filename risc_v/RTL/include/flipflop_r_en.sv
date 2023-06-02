// A Resettable D Flip-Flop with enable pin
// ### Author Name : Walid Akash (walidakash070@gmail.com)

module flipflop_r_en #(
    parameter int WIDTH = 8
) (
    input logic clk_i,
    input logic rst_i,
    input logic en_i,
    input logic [WIDTH-1:0] d_i,
    output logic [WIDTH-1:0] q_o
);

  //-Assignments

  always_ff @(posedge clk_i, posedge rst_i) begin
    if (rst_i) begin
      q_o <= 0;
    end else if (en_i) begin
      q_o <= d_i;
    end
  end

endmodule
