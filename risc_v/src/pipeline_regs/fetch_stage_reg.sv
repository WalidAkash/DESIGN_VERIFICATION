// ### Author : Razu Ahamed(en.razu.ahamed@gmail.com)
// ### Company: DSi

module fetch_stage_reg
import rv32i_pkg::*;
(
    input  logic           clk,
    input  logic           flushF,
    input  logic           stallF,
    input  logic [DPW-1:0] PCNext,
    output logic [DPW-1:0] PCF,
    
);
    always_ff@(posedge clk) 
    begin
        if(flushF)
            PCF <= 0;
        else if(!stallF)
            PCF <= PCNext;
    end
endmodule