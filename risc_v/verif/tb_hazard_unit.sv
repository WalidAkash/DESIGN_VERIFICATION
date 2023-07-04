// ### Author : Razu Ahamed(en.razu.ahamed@gmail.com)
// ### Company: DSi
module tb_hazard_unit;
import rv32i_pkg::*;
    parameter                 REG_WIDTH=5;
    bit                       clk;
    instr_type_t              regwriteE;
    logic [REG_WIDTH -1 : 0 ] Rs1D;
    logic [REG_WIDTH -1 : 0 ] Rs2D;
    logic [REG_WIDTH -1 : 0 ] RdE;
    logic [REG_WIDTH -1 : 0 ] RdM;
    logic                     stallD;
    logic                     flushE;

    hazard_unit
    u_hazard_unit(
        .clk          (clk),
        .regwriteE   (regwriteE),
        .Rs1D         (Rs1D),
        .Rs2D         (Rs2D),
        .RdE          (RdE),
        .RdM          (RdM),
        .stallD       (stallD),
        .flushE       (flushE)       
    );
    task start_tclk ();
        fork
            forever begin
                clk = 1; #5;
                clk = 0; #5;
            end
        join_none
    endtask
    initial begin
      $display("\033[7;38m####################### TEST STARTED #######################\033[0m");
      $dumpfile("raw.vcd");
      $dumpvars;

    end
    
    final begin
      $display("\033[7;38m######################## TEST ENDED ########################\033[0m");
    end
    
    initial 
    begin
        start_tclk ();
        repeat(1) @(posedge clk);
        regwriteE = S_TYPE;
        Rs1D       =5'd2;      
        Rs2D       =5'd3;
        RdE        =5'd2;
        $monitor("stallD =%d and flushE =%d",stallD,flushE);
        repeat(4) @(posedge clk);
        
        regwriteE = I_TYPE_LOAD;
        Rs1D       =5'd2;
        Rs2D       =5'd3;
        RdE        =5'd2;
        repeat(4) @(posedge clk);
        
        regwriteE = S_TYPE;
        Rs1D       =5'd2;
        Rs2D       =5'd2;
        RdE        =5'd2;
        repeat(4) @(posedge clk);
        
        regwriteE = I_TYPE_LOAD;
        Rs1D       =5'd5;
        Rs2D       =5'd3;
        RdM        =5'd5;
        repeat(4) @(posedge clk);
        regwriteE = I_TYPE_LOAD;
        Rs1D       =5'd6;
        Rs2D       =5'd6;
        RdE        =5'd6;
        repeat(4) @(posedge clk);
        regwriteE = I_TYPE_LOAD;
        Rs1D       =5'd7;
        Rs2D       =5'd7;
        RdM        =5'd7;

        repeat(4) @(posedge clk);
        regwriteE = S_TYPE;
        repeat(20) @(posedge clk);
        $finish;


    end


endmodule