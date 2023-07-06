// Designer : Walid Akash
// Company : DSi

module tb_execute_stage;
  import rv32i_pkg::*;

  `include "../include/tb_ess.sv"

  //-SIGNALS

  // generates static task start_clk_i with tHigh:3 tLow:7
  `CREATE_CLK(clk, 2, 2)

  logic [DPW-1:0] instrD;
  logic [DPW-1:0] PCD;
  logic           flushE;     // From Hazard Unit
  logic [ADW-1:0] addr_3;
  logic [DPW-1:0] wd_3;
  logic           we;         // write enable

  logic           resultsrcE;
  logic           memwriteE;
  logic           branchE;
  logic           alusrcE;
  logic           regwriteE;
  alu_op_t        alu_ctrlE;
  logic [DPW-1:0] srcA;
  logic [DPW-1:0] Rd2E;
  logic [ADW-1:0] RdE;
  logic [DPW-1:0] immextE;
  logic [DPW-1:0] PCE;

  //-VARIABLES

  int error;

  //-DUT INSTANTIATIONS

  execute_stage #(
    .ADW (ADW )
  ) u_execute_stage (
    .clk        (clk_i ),
    .instrD     (instrD ),
    .PCD        (PCD ),
    .flushE     (flushE ),
    .addr_3     (addr_3 ),
    .wd_3       (wd_3 ),
    .we         (we ),
    .resultsrcE (resultsrcE ),
    .memwriteE  (memwriteE ),
    .branchE    (branchE ),
    .alusrcE    (alusrcE ),
    .regwriteE  (regwriteE ),
    .alu_ctrlE  (alu_ctrlE ),
    .srcA       (srcA ),
    .Rd2E       (Rd2E ),
    .RdE        (RdE ),
    .immextE    (immextE ),
    .PCE        ( PCE)
  );

  //-PROCEDURALS

  initial begin

    start_clk();
    @(posedge clk);
    #10;

    for (int i = 0; i < 50; i++) begin
      std::randomize(
          instrD[6:0]
      ) with {
        instrD[6:0] inside {3, 19, 35, 51, 99};
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
      #10;

      instrD[19:15] <= $urandom_range(0, 10);  // addr_1
      instrD[24:20] <= $urandom_range(11, 20);  // addr_2

      instrD[11:7] <= $urandom_range(0, 20);  // RdD
      instrD[29:25] <= $urandom_range(0, 20);
      instrD[31] <= $urandom_range(0, 20);

      addr_3 <= $urandom_range(21, 31);
      we <= 1;
      @(posedge clk);

      wd_3 <= $urandom_range(0, 32'h88888887);
      @(posedge clk);

      instrD[19:15] <= addr_3;
      instrD[24:20] <= addr_3;
      repeat (2) @(posedge clk);

      $display("Test - - - - > %p", i);
      $display("instr_type = ", instrD[6:0]);
      $display("func_code = ", instrD[14:12]);
      $display("funct7b5 = ", instrD[30]);
    end

    result_print((error == 0), "decode_stage verified");
    #10;
    $finish;
  end

endmodule
