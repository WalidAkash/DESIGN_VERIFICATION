// Designer : Walid Akash
// Company : DSi
// Description : Fetch stage pipeline register

module decode_stage
import rv32i_pkg::*;
#(
  parameter int DPW = 32
)
(
input logic clk,
input logic stallD,
input logic FlushD,
input logic [DPW-1:0] instr,

output logic [DPW-1:0] instrD
);

always_ff @(posedge clk) 
begin
    if(FlushD)
        instrD <= 0;
    if(!stallD)
        instrD <= instr;
end

endmodule