// Designer: Nakibur Rahman
// Company : DSi

module alu
  import rv32i_pkg::DPW;
  import rv32i_pkg::alu_op_t;
  import rv32i_pkg::SLL_OP;
  import rv32i_pkg::SRA_OP;
  import rv32i_pkg::SRL_OP;
  import rv32i_pkg::AND_OP;
  import rv32i_pkg::OR_OP;
  import rv32i_pkg::XOR_OP;
  import rv32i_pkg::BEQ_OP;
(
    input  logic    [DPW-1:0] opr_a,
    input  logic    [DPW-1:0] opr_b,
    input  alu_op_t           opcode,
    output logic    [DPW-1:0] res,
    output logic              zero_flag
);

  // Signals
  logic is_left;  // determines if it is left shift
  logic MSB_ext;  // MSB extension bit for right shift operation
  logic [DPW-1:0] opr_a_flip;  // reverses shift amount for left shift
  logic [DPW-1:0] shift_res;
  logic [DPW-1:0] shift_number;
  logic [DPW-1:0] adder_sub_res;
  // Assignments
  assign is_left      = (opcode == SLL_OP) ? 1'b1 : 1'b0;
  assign shift_number = is_left ? opr_a_flip : opr_a;
  assign MSB_ext      = (opcode == SRA_OP) ? opr_a[DPW-1] : 1'b0;
  assign opr_a_flip   = {<<{opr_a}};
  // instantiations

  shifter u_shifter (
      .shift_number,
      .shift_amount(opr_b[$clog2(DPW)-1:0]),
      .is_left,
      .MSB_ext,
      .res         (shift_res)
  );

  adder_sub u_adder_sub (
      .opr_a,
      .opr_b,
      .opcode,
      .res(adder_sub_res),
      .zero_flag(zero_flag)
  );

  // res select mux
  always_comb begin
    case (opcode)
      AND_OP: begin
        res = opr_a & opr_b;
      end
      OR_OP: begin
        res = opr_a | opr_b;
      end
      XOR_OP: begin
        res = opr_a ^ opr_b;
      end
      SLL_OP, SRL_OP, SRA_OP: begin
        res = shift_res;
      end
      default: begin
        res = adder_sub_res;
      end
    endcase
  end
endmodule
