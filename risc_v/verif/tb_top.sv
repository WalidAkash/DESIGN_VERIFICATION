// Designer : Walid Akash
// Company : DSi
// Description : Testbench for top.sv module

module tb_top;
  import rv32i_pkg::*;
  `include "../include/tb_ess.sv"

  //-LOCALPARAMS

  localparam int ADW = 5;

  //-SIGNALS

  // generates static task start_clk_i with tHigh:3 tLow:7
  `CREATE_CLK(clk, 2, 2)

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


  //-PROCEDURALS

  initial begin
    start_clk();

    for (int i = 0; i < 10; i++) begin
      std::randomize(
          instrD[6:0]
      ) with {
        instrD[6:0] inside {3, 19, 35, 51};
      };
      std::randomize(
          instrD[14:12]
      ) with {
        instrD[14:12] inside {0, 1, 4, 5, 6, 7};
      };
      std::randomize(
          instrD[30]
      ) with {
        instrD[30] inside {0, 1};
      };

      instrD[19:15] <= $urandom_range(0, 10);
      instrD[24:20] <= $urandom_range(11, 20);

      instrD[11:7] <= $urandom_range(0, 20);
      instrD[29:25] <= $urandom_range(0, 20);
      instrD[31] <= $urandom_range(0, 20);

      repeat (10) @(posedge clk);

    end

    $finish;
  end



endmodule
