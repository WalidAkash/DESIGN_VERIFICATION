`timescale 1ns / 1ps
;

module tb_alu;
  import rv32i_pkg::*;

  logic [DPW-1:0] opr_a, opr_b, res;
  alu_op_t op;

  alu u_alu (
      .opr_a (opr_a),
      .opr_b (opr_b),
      .opcode(op),
      .res   (res)
  );

  logic [DPW-1:0] a, b, r;
  integer i = 0;

  initial begin
    $dumpfile("tb_alu.vcd");
    $dumpvars(0, tb_alu);
    $display("test start");

    for (i = 0; i < 50; i++) begin
      $display(
          "---------------------------------  TEST :: %0d  --------------------------------------",
          i);
      std::randomize(opr_a, opr_b);
      std::randomize(op);
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
        $display("op :: SUB");
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
      end else r = 0;
      #10;
      $display("Expected = %0h \nRTL      = %0h", r, res);
      if (res == r) begin
        $display(
            "----------------------------------  PASS  -------------------------------------------\n");
        #10;
      end else begin
        $display(
            "----------------------------------  FAIL  -------------------------------------------\n");
        #10;
      end
    end
    $finish;

  end

endmodule
