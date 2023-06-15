// Designer : Khadija Yeasmin Fariya
//            Updated by Walid Akash
// Company  : DSi
// Module   : adder_sub

module adder_sub
  import rv32i_pkg::*;
//import rv32i_pkg::DPW;
(
    input  logic    [DPW-1:0] opr_a,
    input  logic    [DPW-1:0] opr_b,
    input  alu_op_t           opcode,
    output logic    [DPW-1:0] res
);

  logic [DPW-1:0] neg_opr_b;
  logic [DPW-1:0] res_temp;

  // 2's complement the result and the operand for SUB op
  /* assign {res,neg_opr_b} = (opcode == SUB_OP) ? 
                           {((~res_temp) + 1),((~opr_b) + 1)} :{res_temp, opr_b};


  always_comb begin
    res_temp = opr_a + opr_b;
  end
 */


  //Bug Fix
  assign {res, neg_opr_b} = (opcode == SUB_OP) ? {res_temp, ((~opr_b) + 1)} : {res_temp, opr_b};


  always_comb begin
    res_temp = opr_a + neg_opr_b;
  end

endmodule
