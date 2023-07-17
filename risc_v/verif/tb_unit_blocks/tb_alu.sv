//`timescale 1ns / 1ps
;

module tb_alu;
  import rv32i_pkg::*;

  `include "../include/tb_ess.sv"

  logic [DPW-1:0] opr_a, opr_b, res;
  logic zero_flag;
  alu_op_t op;

  alu u_alu (
      .opr_a    (opr_a),
      .opr_b    (opr_b),
      .opcode   (op),
      .res      (res),
      .zero_flag(zero_flag)
  );

  logic [DPW-1:0] a, b, r;
  logic z = 0;
  integer i = 0;
  int error = 0;

  initial begin
   // $dumpfile("tb_alu.vcd");
   // $dumpvars(0, tb_alu);
    $display("test start");

    for (i = 0; i < 10; i++) begin
      $display(
          "---------------------------------  TEST :: %0d  --------------------------------------",
          i);
      std::randomize(opr_a, opr_b);
      std::randomize(op);
      //op <= BEQ_OP;
      $cast(a, opr_a);
      $cast(b, opr_b);
      if (op == AND_OP) begin
        r = a & b;
        $display("op :: AND");
      end else if (op == ADD_OP) begin
        r = a + b;
        $display("op :: ADD");
      end else if (op == SUB_OP) begin
        r = a - b;
        if (r) begin
          z = 0;
        end else begin
          z = 1;
        end
        $display("op :: SUB");
        $display("a = ", a);
        $display("b = ", b);
      end else if (op == OR_OP) begin
        r = a | b;
        $display("op :: OR ");
      end else if (op == XOR_OP) begin
        r = a ^ b;
        $display("op :: XOR");
      end else if (op == SLL_OP) begin
        r = a << b[4:0];
        $display("op :: SLL");
      end else if (op == SRL_OP) begin
        r = a >> b[4:0];
        $display("op :: SRL");
      end else if (op == SRA_OP) begin
        r = signed'(a) >>> b[4:0];
        $display("op :: SRA");
      end else if (op == BEQ_OP) begin
        r = a - b;
        if (r) begin
          z = 0;
        end else begin
          z = 1;
        end
      end else r = 0;
      #10;
      $display("Expected res = %0h \nRTL     res = %0h", r, res);
      $display("Expected zero_flag = %0h \nRTL     zero_flag = %0h", z, zero_flag);
      if ((res == r) && (zero_flag == z)) begin
        $display(
            "----------------------------------  PASS  -------------------------------------------\n");
        #10;
      end else begin
        $display(
            "----------------------------------  FAIL  -------------------------------------------\n");
        #10;
        error++;
      end
    end
    
    result_print(error == 0, "ALU Verified");
    $finish;
  end

endmodule
