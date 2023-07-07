// ### Author : Razu Ahamed(en.razu.ahamed@gmail.com)
// ### Company: DSi
module hazard_unit 
import rv32i_pkg::*;
(
    input   bit                    clk,
    input   logic                  regwriteE,
    input   logic       [ADW -1:0] Rs1D,
    input   logic       [ADW -1:0] Rs2D,
    input   logic       [ADW -1:0] RdE,
    input   logic       [ADW -1:0] RdM,
    input   logic                  PCSrcE,
    output  logic                  stallF,
    output  logic                  flushF,
    output  logic                  stallD,
    output  logic                  flushD,
    output  logic                  flushE 

);
    logic [1:0]count=0;
    always_comb
    begin
        if(count != 0)
        begin
            stallF =1;
            stallD =1;
            flushE =1;
        end
        else 
        begin
            stallF =0;
            stallD =0;
            flushE =0;
        end
    end

    always_ff@(posedge clk) 
    begin
        if(count >0)
            count <= count - 1;
        else if(regwriteE != 1'b0)
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

    always_ff@(posedge clk) 
    begin
        if(PCSrcE)
        begin
            flushF <= 1;
            flushD <= 1;
        end
        else
        begin
            flushF <= 0;
            flushD <= 0; 
        end
    end

endmodule