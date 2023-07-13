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

  // 0x00022203 lw x4, 0(x4)
  i_cache_mem[0] = 8'h03;
  i_cache_mem[1] = 8'h22;
  i_cache_mem[2] = 8'h02;
  i_cache_mem[3] = 8'h00;

  // 0x0042A283	lw x5, 4(x5)
  i_cache_mem[4] = 8'h83;
  i_cache_mem[5] = 8'hA2;
  i_cache_mem[6] = 8'h42;
  i_cache_mem[7] = 8'h00;

  // 0x00428333	add x6, x5, x4
  i_cache_mem[8] = 8'h33;
  i_cache_mem[9] = 8'h83;
  i_cache_mem[10] = 8'h42;
  i_cache_mem[11] = 8'h00;

  // 0x00602423	sw x6, 8(x0) 
  i_cache_mem[12] = 8'h23;
  i_cache_mem[13] = 8'h24;
  i_cache_mem[14] = 8'h60;
  i_cache_mem[15] = 8'h00;

  end

  always_comb begin : memory
    for (int i = 0; i < 4 ; i++) begin
      instr[(8*(i+1)-1)-:8] = i_cache_mem[PCF+i]; 
      //$display("i_cache_mem[PCF+i] = %h", i_cache_mem[PCF+i]);
    end
  end
endmodule
