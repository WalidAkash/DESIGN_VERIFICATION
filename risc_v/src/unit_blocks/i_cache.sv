// Designer : Walid Akash (walidakash070@gmail.com)
// Company  : DSi 

module i_cache 
  import rv32i_pkg::*;
  # (
    parameter int ElemWidth = 8,
    parameter int Depth = 120   // For number of instructions = 30. Depth = (30 X 32)/ElemWidth = 120
) (
  input logic [DPW-1:0] PCF,

  output logic [DPW-1:0] instr
);

//-Signals

  logic [ElemWidth-1:0] i_cache_mem [Depth]; 
    
  initial begin
  // addi x2, x0, 5
  i_cache_mem[0] = 8'h13;
  i_cache_mem[1] = 8'h01;
  i_cache_mem[2] = 8'h50;
  i_cache_mem[3] = 8'h00;

  // addi x3, x0, 12
  i_cache_mem[4] = 8'h93;
  i_cache_mem[5] = 8'h01;
  i_cache_mem[6] = 8'hC0;
  i_cache_mem[7] = 8'h00; 
  end 
  
  always_comb begin : memory
    for (int i = 0; i < 4 ; i++) begin
      instr[(8*(i+1)-1)-:8] = i_cache_mem[PCF+i]; 
      $display("i_cache_mem[PCF+i] = %h", i_cache_mem[PCF+i]);
    end
  end
endmodule
