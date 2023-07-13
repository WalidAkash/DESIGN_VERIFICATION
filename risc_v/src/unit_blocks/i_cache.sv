// Designer : Walid Akash (walidakash070@gmail.com)
// Company  : DSi 

module i_cache 
  import rv32i_pkg::*;
  # (
    parameter int ElemWidth = 8,
    parameter int Depth = 120   // For number of instructions = 30. Depth = (30 X 32)/ElemWidth = 120
) (
  input logic [DPW-1:0] PCF,
  input logic [DPW-1:0] instr_input,

  output logic [DPW-1:0] instr
);

//-Signals

  logic [ElemWidth-1:0] i_cache_mem [Depth]; 
    
  initial begin

  // lw x6, -4(x9)
  i_cache_mem[0] = 8'h03;
  i_cache_mem[1] = 8'hA3;
  i_cache_mem[2] = 8'hC4;
  i_cache_mem[3] = 8'hFF;

  // lw x5, 8(x9)
  i_cache_mem[4] = 8'h03;
  i_cache_mem[5] = 8'h02;
  i_cache_mem[6] = 8'h40;
  i_cache_mem[7] = 8'h00; 

  // add x7, x5, x4
  i_cache_mem[4] = 8'hB3;
  i_cache_mem[5] = 8'h83;
  i_cache_mem[6] = 8'h42;
  i_cache_mem[7] = 8'h00; 

  // add x9, x7, x0 
  i_cache_mem[4] = 8'hB3;
  i_cache_mem[5] = 8'h84;
  i_cache_mem[6] = 8'h03;
  i_cache_mem[7] = 8'h00; 

  // sub x6, x7, x4
  i_cache_mem[4] = 8'h33;
  i_cache_mem[5] = 8'h83;
  i_cache_mem[6] = 8'h43;
  i_cache_mem[7] = 8'h40; 
  end 
  
  always_comb begin : memory
    for (int i = 0; i < 4 ; i++) begin
      instr[(8*(i+1)-1)-:8] = i_cache_mem[PCF+i]; 
      //$display("i_cache_mem[PCF+i] = %h", i_cache_mem[PCF+i]);
    end
  end
endmodule
