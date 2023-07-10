// Designer   : Khadija Yeasmin Fariya 
// Company    : Dsi 
// Module Name: reg_file.sv

module reg_file #(
    parameter int ADW = 5,
    parameter int DPW = 32
) (
    input  logic           clk,     // clock
    input  logic [ADW-1:0] addr_1,
    input  logic [ADW-1:0] addr_2,
    input  logic [ADW-1:0] addr_3,
    input  logic           we_3,      // write enable
    input  logic [DPW-1:0] wd_3,    // write data
    output logic [DPW-1:0] rd_1,
    output logic [DPW-1:0] rd_2
);

  logic [DPW-1:0] regs[0:((2**ADW)-1)];

  always @(posedge clk) begin
    if (we_3) begin
      regs[addr_3] <= wd_3;
    end

    rd_1 <= regs[addr_1];
    rd_2 <= regs[addr_2];

  end

endmodule
