module test;
parameter DataWidth = 16;
parameter Depth = 8;

logic clk_i;
logic arst_ni;

//write interface
logic [DataWidth-1:0] din_i;
logic din_val_i;
logic din_rdy_o;

//read interface
logic [DataWidth-1:0] dout_o;
logic dout_val_o;
logic dout_rdy_i;

fifo_interface #(DataWidth, Depth) DUT (clk_i, arst_ni, din_i, din_val_i, din_rdy_o, dout_o, dout_val_o, dout_rdy_i);

initial begin
    clk_i = 0;
    arst_ni = 0;
    din_i = '0;
    din_val_i = 0;
    dout_rdy_i = 0;

    @(negedge clk_i) arst_ni = 1;
    //call the write task
    din_hs_data;
    //call the read task
    dout_hs_data;

    //write to a location and read the next cycle
    @(negedge clk_i);
    din_val_i = 1;
    dout_rdy_i = 1;
    din_i = 8'haa;
    @(negedge clk_i) din_val_i = 0;

    #10 $finish;
end

//input side handshake operation
task din_hs_data;
    @(negedge clk_i);
    for (int i = 1; i < Depth; i++) begin
        din_val_i = 1;
        din_i = $urandom;
        @(negedge clk_i);
    end
    din_val_i = 0;
endtask

//output side handshake operation
task dout_hs_data;
    @(negedge clk_i);
    for (int i = 1; i < Depth; i++) begin
        dout_rdy_i = 1;
        @(negedge clk_i);
    end
endtask

always #1 clk_i = ~clk_i;



// below two lines are used to show waveform
initial begin
    $dumpfile("dump2.vcd");
    $dumpvars;
  end
endmodule
