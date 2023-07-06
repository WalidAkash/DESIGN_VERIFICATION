// Designer : Walid Akash
//            Updated by Razu Ahmed
// Company : DSi
// Description : Decode stage pipeline register

module decode_stage_reg
import rv32i_pkg::*;
#(
  parameter int DPW = 32
)
(
input logic            clk,
input logic            stallD,
input logic            flushD,
input logic  [DPW-1:0] instr,
input logic  [DPW-1:0] PCF,

output logic [DPW-1:0] instrD,
output logic [DPW-1:0] PCD
);

always_ff @(posedge clk) 
begin
    if(flushD)
        instrD <= 0;
        PCD <= 0;
    if(!stallD)
        instrD <= instr;
        PCD <= PCF;
end

endmodule