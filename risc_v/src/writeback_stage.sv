// ### Author : Razu Ahamed(en.razu.ahamed@gmail.com)
// ### Company: DSi
module writeback_stage
import rv32i_pkg::*;
(
  input logic clk,
  input  logic regwriteM,
  input  logic resultsrcM,
  input  logic [DPW-1:0] aluresultM,
  input  logic [DPW-1:0]ReadDataM,
  input  logic [4:0] RdM,

  output logic regwriteW,
  output logic resultsrcW,
  output logic [DPW-1:0]resultW,
  output logic [4:0] RdW
);
  logic [DPW-1:0]ReadDataW;
  logic [DPW-1:0] aluresultW;
  
  mux2_1 u_mux2_1(
    .d0_i(aluresultW),
    .d1_i(ReadDataW),
    .s_i (resultsrcW),
    .y_o (resultW)
  );
  
  always_ff@(posedge clk)
  begin
    regwriteW  <= regwriteM;
    resultsrcW <= resultsrcM;
    aluresultW <= aluresultM;
    ReadDataW  <= ReadDataM;
    RdW        <= RdM;
  end

endmodule