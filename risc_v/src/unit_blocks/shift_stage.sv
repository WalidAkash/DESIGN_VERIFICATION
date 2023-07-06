// Designer: Nakibur Rahman
// Company : DSi

module shift_stage
  import rv32i_pkg::DPW;
#(
    parameter stage_num = 0
) (
    input  logic [DPW-1:0] shift_number,
    input  logic           shift_bit,
    input  logic           MSB_ext,
    output logic [DPW-1:0] stage_res
);

  localparam num_shift = 2 ** stage_num;

  // Right shifting based on which stage it is

  always_comb begin
    if(shift_bit) // shift only if the shift bit is high
	begin
      stage_res = {{num_shift{MSB_ext}}, shift_number[DPW-1:num_shift]};
    end else stage_res = shift_number;
  end
endmodule

