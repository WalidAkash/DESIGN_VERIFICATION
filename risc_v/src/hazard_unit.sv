// ### Author : Razu Ahamed(en.razu.ahamed@gmail.com)
// ### Company: DSi
module hazard_unit 
import rv32i_pkg::*;
#(
    parameter REG_WIDTH=5
)(
    input   bit                    clk,
    input   instr_type_t           regwriteE,
    input   logic [REG_WIDTH -1:0] Rs1D,
    input   logic [REG_WIDTH -1:0] Rs2D,
    input   logic [REG_WIDTH -1:0] RdE,
    input   logic [REG_WIDTH -1:0] RdM,
    output  logic                  stallD,
    output  logic                  flushE       
);
    logic [1:0]count=0;
    always_comb
    begin
        if(count != 0)
        begin
            stallD =1;
            flushE =1;
        end
        else 
        begin
            stallD =0;
            flushE =0;
        end
    end
    
    always_ff@(posedge clk) 
    begin
        if(count >0)
            count <= count - 1;
        else if(regwriteE != S_TYPE )
        begin
            if(Rs1D==RdE | Rs2D==RdE)  
    	    begin
    	        count<=2;
    	    end	
            else if(Rs1D==RdM | Rs2D==RdM)
            begin
                count<=1;  
            end
        end
    	else
    	    count=0;
    end

endmodule