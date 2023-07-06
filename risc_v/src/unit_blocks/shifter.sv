// Designer : Nakibur Rahman
// Company  : DSi

module shifter
  import rv32i_pkg::DPW;
(
    input        [        DPW-1:0] shift_number,
    input        [$clog2(DPW)-1:0] shift_amount,
    input  logic                   is_left,
    input  logic                   MSB_ext,
    output       [        DPW-1:0] res
);

  // Signals
  logic [DPW-1:0] res_temp;  // To store the result before flipping 
                             // for left shift
  logic [DPW-1:0] stage_res[4];  // To store the result of shifting stage 
                                 // to feed into the next
  logic [DPW-1:0] res_flip;
  // Assignments
  assign res      = is_left ? res_flip : res_temp;
  assign res_flip = {<<{res_temp}};
  // Instantiations

  generate
    for (genvar i = 0; i < $clog2(DPW) - 1; i++) begin
      if (i == 0) begin
        shift_stage #(
            .stage_num(i)
        ) u_shift_stage (
            .shift_bit(shift_amount[i]),
            .shift_number,
            .MSB_ext,
            .stage_res(stage_res[i])
        );
      end else begin
        shift_stage #(
            .stage_num(i)
        ) u_shift_stage (
            .shift_bit   (shift_amount[i]),
            .shift_number(stage_res[i-1]),
            .MSB_ext,
            .stage_res   (stage_res[i])
        );
      end
    end
  endgenerate

  // Last stage shifter 
  shift_stage #(
      .stage_num(4)
  ) last_shift_stage (
      .shift_bit   (shift_amount[4]),
      .shift_number(stage_res[3]),
      .MSB_ext,
      .stage_res   (res_temp)
  );
endmodule
