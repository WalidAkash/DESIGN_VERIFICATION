module d_cacahe
  import rv32i_pkg::DPW;
  import rv32i_pkg::ADW;
  # ( parameter int ElemWidth = 8,
      parameter int Depth = 120
    ) (
    input logic clk,
    input logic [DPW-1:0] addr,   // aluresultM
    input logic [DPW-1:0] wd,     // Rd2M
    input logic [DPW-1:0] we,     // memwriteM

    output logic [DPW-1:0] rd
  );

   logic [ElemWidth-1:0] d_cache_mem [Depth];

   always @(posedge clk) begin
    if (we) begin
      for (int i = 0; i < 4 ; i++) begin
        d_cache_mem[addr+i] = wd[(8*(i+1)-1)-:8]; 
        $display("d_cache_mem[(addr*4)+i] = %h", d_cache_mem[addr+i]);
      end
    end else begin
      for (int i = 0; i < 4 ; i++) begin
        rd[(8*(i+1)-1)-:8] = d_cache_mem[addr+i];
        $display("rd[(8*(i+1)-1)-:8] = %h", rd[(8*(i+1)-1)-:8]);
      end
    end

  end
    
endmodule