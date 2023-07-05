// Designer : Walid Akash
// Company : DSi
// Description : Fetch stage pipeline register

module fetch_stage
import rv32i_pkg::*;
#(
  parameter int DPW = 32
)
(
input logic clk,
input logic [DPW-1:0] instr,

output logic [DPW-1:0] instrD
);

always_ff @(posedge clk) 
begin
    if(!stallD)
        instrD <= instr;
end

endmodule