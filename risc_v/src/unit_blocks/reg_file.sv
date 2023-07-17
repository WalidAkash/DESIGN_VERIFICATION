// Designer   : Khadija Yeasmin Fariya
// Company    : Dsi 
// Module Name: reg_file.sv

module reg_file #(
    parameter int ADW = 5,
    parameter int DPW = 32
) (
    input  logic           clk,     // clock
    input  logic           arst_n,   // for reset
    input  logic [ADW-1:0] addr_1,
    input  logic [ADW-1:0] addr_2,
    input  logic [ADW-1:0] addr_3,
    input  logic           we_3,      // write enable
    input  logic [DPW-1:0] wd_3,    // write data
    output logic [DPW-1:0] rd_1,
    output logic [DPW-1:0] rd_2
);

  logic [DPW-1:0] regs[0:((2**ADW)-1)];

  always @(posedge clk or negedge arst_n) begin
    if(!arst_n)
    begin
      regs[5'b00000] <= 0;
      regs[5'b00001] <= 0;
      regs[5'b00010] <= 0;
      regs[5'b00011] <= 0;
      regs[5'b00100] <= 0;
      regs[5'b00101] <= 0;
      regs[5'b00110] <= 0;
      regs[5'b00111] <= 0;
      regs[5'b01000] <= 0;
      regs[5'b01001] <= 0;
      regs[5'b01010] <= 0;
      regs[5'b01011] <= 0;
      regs[5'b01100] <= 0;
      regs[5'b01101] <= 0;
      regs[5'b01110] <= 0;
      regs[5'b01111] <= 0;
    end
    else if (we_3) begin
      regs[addr_3] <= wd_3;
    end else begin
      rd_1 <= regs[addr_1];
      rd_2 <= regs[addr_2];
    end

  end

endmodule
