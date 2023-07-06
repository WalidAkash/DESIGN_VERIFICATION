// Designer : Walid Akash
// Company : DSi
// Description : Decode stage pipeline register

module decode_stage
import rv32i_pkg::*;
#(
  parameter int DPW = 32
)
(
input logic            clk,
input logic            stallD,
input logic            FlashD,
input logic  [DPW-1:0] instr,
input logic  [DPW-1:0] PCF,

output logic [DPW-1:0] instrD,
output logic [DPW-1:0] PCD
);

always_ff @(posedge clk) 
begin
    if(FlashD)
        instrD <= 0;
        PCD <= 0;
    if(!stallD)
        instrD <= instr;
        PCD <= PCF;
end

endmodule