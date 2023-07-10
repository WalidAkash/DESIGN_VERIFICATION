module tb_i_cache;
  import rv32i_pkg::DPW;
  
  `include "../include/tb_ess.sv"

  //-Parameters

  localparam int ElemWidth = 8;
  localparam int Depth = 120;

  //-Signals
  
  logic [DPW-1:0] PCF;
  logic [DPW-1:0] instr;

  //-Variables
  
  int error = 0;

  //-DUT Instantiations
  
  i_cache 
  #(
    .ElemWidth(ElemWidth ),
    .Depth (
        Depth )
  )
  i_cache_dut (
    .PCF (PCF ),
    .instr  ( instr)
  );


  //-Procedurals
  
  initial begin
    PCF = 0;
    #10;

    $display("PCF = ", PCF);
    $display("instr = %h", instr);

    PCF = 4; 
    #10;
    
    $display("PCF = ", PCF);
    $display("instr = %h", instr);
    $finish;
  end

endmodule  
