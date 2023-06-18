// Designer : Walid Akash
// Company : DSi
// Description : Testbench for top.sv module

module tb_top;
  import rv32i_pkg::*;

  //-LOCALPARAMS

  localparam int ADW = 5;

  //-SIGNALS

  logic [DPW-1:0] instrD;
  logic regwriteM;
  logic resultsrcM;
  logic memwriteM;
  logic [DPW-1:0] aluresultM;
  logic [DPW-1:0] Rd2M;
  logic [4:0] RdM;

  //-DUT INSTANTIATIONS

  top #(
      .ADW(ADW)
  ) u_top (
      .clk(clk),
      .instrD(instrD),
      .regwriteM(regwriteM),
      .resultsrcM(resultsrcM),
      .memwriteM(memwriteM),
      .aluresultM(aluresultM),
      .Rd2M(Rd2M),
      .RdM(RdM)
  );


endmodule
