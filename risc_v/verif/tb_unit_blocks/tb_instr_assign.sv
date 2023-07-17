// Designer : Walid Akash
// Company : DSi
// Description : Testbench for top.sv module

module tb_instr_assign;
  import rv32i_pkg::*;

  `include "../include/tb_ess.sv"

  //-LOCALPARAMS

  localparam int ADW = 5;

  //-SIGNALS

  // generates static task start_clk_i with tHigh:3 tLow:7
  `CREATE_CLK(clk, 1, 1)

  logic        [DPW-1:0] instrD;
  instr_type_t           instr_type;
  func_code_t            func_code;
  logic                  funct7b5;
  logic        [ADW-1:0] addr_1;
  logic        [ADW-1:0] addr_2;
  logic        [    4:0] RdD;
  logic        [DPW-1:7] instr_ext;


  //-DUT INSTANTIATIONS

  instr_assign_unit #(
      .ADW(ADW)
  ) u_instr_assign_unit (
      .instrD(instrD),
      .instr_type(instr_type),
      .func_code(func_code),
      .funct7b5(funct7b5),
      .addr_1(addr_1),
      .addr_2(addr_2),
      .RdD(RdD),
      .instr_ext(instr_ext)
  );



  //-PROCEDURALS

  initial begin
    start_clk();

    for (int i = 0; i < 5; i++) begin
      std::randomize(
          instrD[6:0]
      ) with {
        instrD[6:0] inside {3, 19, 35, 51};
      };

      std::randomize(
          instrD[30]
      ) with {
        instrD[30] inside {0, 1};
      };
      #10;

      instrD[14:12] <= $urandom_range(4, 7);
      instrD[19:15] <= $urandom_range(0, 10);
      instrD[24:20] <= $urandom_range(11, 20);

      instrD[11:7] <= $urandom_range(0, 20);
      instrD[29:25] <= $urandom_range(0, 20);
      instrD[31] <= $urandom_range(0, 20);

      repeat (2) @(posedge clk);

      $display("Test - - - - > %p", i);
      $display("instr_type = ", instr_type);
      $display("instrD[14:12] = ", instrD[14:12]);
      $display("func_code = ", func_code);
      $display("funct7b5 = ", funct7b5);
      $display("addr_1 = ", addr_1);
      $display("addr_2 = ", addr_2);

    end

    $finish;
  end


endmodule

