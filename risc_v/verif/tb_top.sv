// Designer : Walid Akash
// Company : DSi
// Description : Testbench for top.sv module

module tb_top;
  import rv32i_pkg::*;
  `include "../include/tb_ess.sv"

  //-SIGNALS

  // generates static task start_clk_i with tHigh:3 tLow:7
  `CREATE_CLK(clk, 1, 1)
  logic [DPW-1:0] instr;
  logic [DPW-1:0] PCF;
  logic           stallD;
  logic           flushD;
  logic [ADW-1:0] addr_3;
  logic           we;
  logic [DPW-1:0] wd_3;
  logic           regwriteM;
  logic           resultsrcM;
  logic           memwriteM;
  logic [DPW-1:0] aluresultM;
  logic [DPW-1:0] Rd2M;
  logic     [4:0] RdM;
  

  //-VARIABLES

  logic [ADW-1:0] addr_1;
  logic [ADW-1:0] addr_2;
  logic [DPW-1:0] rd_1;
  logic [DPW-1:0] rd_2;
  logic [DPW-1:0] srcA;
  logic [DPW-1:0] srcB;
  logic [DPW-1:0] a;
  logic [DPW-1:0] b;

  logic [DPW-1:0] r;  // store the test operation result
  int             error = 0;

  //-DUT INSTANTIATIONS

  top 
  #(
    .ADW (
        ADW )
  )
  top_dut (
    .clk (clk ),
    .instr (instr ),
    .PCF (PCF ),
    .stallD (stallD ),
    .flushD (flushD ),
    .addr_3 (addr_3 ),
    .we (we ),
    .wd_3 (wd_3 ),
    .regwriteM (regwriteM ),
    .resultsrcM (resultsrcM ),
    .memwriteM (memwriteM ),
    .aluresultM (aluresultM ),
    .Rd2M (Rd2M ),
    .RdM  ( RdM)
  );

  //-PROCEDURALS

  initial begin
    start_clk();

    for (int i = 0; i < 50; i++) begin
      std::randomize(
          instr[6:0]
      ) with {
        instr[6:0] inside {3, 19, 35, 51, 99};
      };
      std::randomize(
        instr[14:12]
      ) with {
        instr[14:12] inside {0, 1, 4, 5, 6, 7};
      };
      std::randomize(
        instr[30]
      ) with {
        instr[30] inside {0, 1};
      };
      #10;

      instr[14:12] <= $urandom_range(4, 7);  // func_code
      instr[19:15] <= $urandom_range(0, 10);  // addr_1
      instr[24:20] <= $urandom_range(11, 20);  // addr_2

      instr[11:7] <= $urandom_range(0, 20);  // RdD
      instr[29:25] <= $urandom_range(0, 20);
      instr[31] <= $urandom_range(0, 20);

      addr_3 <= $urandom_range(21, 31);
      we <= 1;
      @(posedge clk);

      wd_3 <= $urandom_range(0, 32'h88888887);
      @(posedge clk);

      instr[19:15] <= addr_3;
      instr[24:20] <= addr_3;
      repeat (2) @(posedge clk);

      a <= srcA;
      b <= srcB;
      repeat (2) @(posedge clk);

      $display("Test - - - - > %p", i);
      $display("instr_type = ", instr[6:0]);
      $display("func_code = ", instr[14:12]);
      $display("funct7b5 = ", instr[30]);

      // Comnpare Instruction types with expected value
      case (instr[6:0])  // Testing the instruction decoder
        51: begin  // R-type
          if ((regwriteM == 1) && (resultsrcM == 0) && (memwriteM == 0)) begin
            error = error;
          end else begin
            error++;
          end
        end

        3: begin  // I_type_LOAD
          if ((regwriteM == 1) && (resultsrcM == 1) && (memwriteM == 0)) begin
            error = error;
          end else begin
            error++;
          end
        end

        19: begin  // I-type_ALU
          if ((regwriteM == 1) && (resultsrcM == 0) && (memwriteM == 0)) begin
            error = error;
          end else begin
            error++;
          end
        end

        default: begin  // S-type
          if ((regwriteM == 0) && (resultsrcM == 0) && (memwriteM == 1)) begin
            error = error;
          end else begin
            error++;
          end
        end
      endcase

      // Comnpare ALU operation's results with expected value
      case (instr[14:12])
        3'b100: begin  // XOR
          r = a ^ b;
          if (r != aluresultM) begin
            error++;
          end
        end

        3'b101: begin  // SRL_A
          if (instr[30]) begin  // SRA_OP
            r = signed'(a) >>> b[4:0];
            if (r != aluresultM) begin
              error++;
            end
          end else begin  // SRL_OP
            r = a >> b[4:0];
            if (r != aluresultM) begin
              error++;
            end
          end
        end

        3'b110: begin  // OR
          r = a | b;
          if (r != aluresultM) begin
            error++;
          end
          $display("errorOR = ", error);
        end
        default: begin  // AND
          r = a & b;
          if (r != aluresultM) begin
            error++;
          end
          $display("errorAND = ", error);
        end
      endcase

      // Comnpare RdM with expected value
      if (instr[11:7] != RdM) begin
        error++;
      end

      // Comnpare Rd2M with expected value
      if (wd_3 != Rd2M) begin
        error++;
      end
      $display("error = ", error);
    end

    $display("instr = ", instr);
    #50;

    result_print(error == 0, "Top module veridied!!");
    $finish;
  end

endmodule
