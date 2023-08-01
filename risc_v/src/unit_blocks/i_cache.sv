// Designer : Walid Akash (walidakash070@gmail.com)
// Company  : DSi

module i_cache
  import rv32i_pkg::DPW;
  import rv32i_pkg::ElemWidth;
  import rv32i_pkg::Depth;
(
    input logic [DPW-1:0] PCF,

    output logic [DPW-1:0] instr
);

  //-Signals

  logic [ElemWidth-1:0] i_cache_mem[Depth];

  initial begin

    // 0x00022203 lw x4, 0(x4)
    i_cache_mem[0]  = 8'h03;
    i_cache_mem[1]  = 8'h22;
    i_cache_mem[2]  = 8'h02;
    i_cache_mem[3]  = 8'h00;

    // 0x0042A283	lw x5, 4(x5)
    i_cache_mem[4]  = 8'h83;
    i_cache_mem[5]  = 8'hA2;
    i_cache_mem[6]  = 8'h42;
    i_cache_mem[7]  = 8'h00;

    // 0x00C3A383 lw x7, 12(x7)
    i_cache_mem[8]  = 8'h83;
    i_cache_mem[9]  = 8'hA3;
    i_cache_mem[10] = 8'hC3;
    i_cache_mem[11] = 8'h00;

    // 0x01042403 lw x8, 16(x8)
    i_cache_mem[12] = 8'h03;
    i_cache_mem[13] = 8'h24;
    i_cache_mem[14] = 8'h04;
    i_cache_mem[15] = 8'h01;

    // 0x00428333	add x6, x5, x4
    i_cache_mem[16] = 8'h33;
    i_cache_mem[17] = 8'h83;
    i_cache_mem[18] = 8'h42;
    i_cache_mem[19] = 8'h00;

    // 0x008384B3 add x9, x7, x8
    i_cache_mem[20] = 8'hB3;
    i_cache_mem[21] = 8'h84;
    i_cache_mem[22] = 8'h83;
    i_cache_mem[23] = 8'h00;

    // 0x00602423	sw x6, 8(x0)
    i_cache_mem[24] = 8'h23;
    i_cache_mem[25] = 8'h24;
    i_cache_mem[26] = 8'h60;
    i_cache_mem[27] = 8'h00;

    // 0x00902A23 sw x9, 20(x0)
    i_cache_mem[28] = 8'h23;
    i_cache_mem[29] = 8'h2A;
    i_cache_mem[30] = 8'h90;
    i_cache_mem[31] = 8'h00;

  end

  always_comb begin : memory
    for (int i = 0; i < 4; i++) begin
      instr[(8*(i+1)-1)-:8] = i_cache_mem[PCF+i];
      //$display("i_cache_mem[PCF+i] = %h", i_cache_mem[PCF+i]);
    end
  end
endmodule
