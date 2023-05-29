// ### Author : Walid Akash

module fifo_test;


  // bring the testbench essential files
  `include "tb_ns.sv"

  //-Localparams

  localparam int Datawidth = 16;
  localparam int Depth = 8;

  //-Signals

  //-Static Clock

  `CREATE_CLK(clk_i, 1, 1)
  //logic arst_n = 1;

  logic arst_ni;

  logic [Datawidth-1:0] data_in_i;
  logic data_in_valid_i;
  logic data_in_ready_o;

  logic [Datawidth-1:0] data_out_o;
  logic data_out_valid_o;
  logic data_out_ready_i;

  //-Variables

  int err;
  int inp_count;
  int out_count;

  logic [Datawidth-1:0] data_queue[$];

  //-RTL

  fifo #(
      .Datawidth(Datawidth),
      .Depth(Depth)
  ) fifo_dut (
      .clk_i(clk_i),
      .arst_ni(arst_ni),
      .data_in_i(data_in_i),
      .data_in_valid_i(data_in_valid_i),
      .data_in_ready_o(data_in_ready_o),
      .data_out_o(data_out_o),
      .data_out_valid_o(data_out_valid_o),
      .data_out_ready_i(data_out_ready_i)
  );

  //-Methods

  task static apply_reset();
    data_queue.delete();
    err = 0;
    inp_count = 0;
    out_count = 0;
    clk_i = 1;
    data_in_i = 0;
    data_in_valid_i = 0;
    data_out_ready_i = 0;
    #5;
    arst_ni = 0;
    #5;
    arst_ni = 1;
    #5;
  endtask  //static


  //-Procedurals

  always @(posedge clk_i) begin
    if (data_in_valid_i && data_in_ready_o) begin  // Input side handshake Verification
      inp_count++;
      data_queue.push_back(data_in_i);
    end
    if (data_out_valid_o && data_out_ready_i) begin  //Output side handshake verification
      out_count++;
      if (data_queue.pop_front() != data_out_o) begin
        err++;
      end
    end
  end


  initial begin
    bit prev_data_in_valid;
    bit prev_data_in_ready;
    bit prev_data_out_valid;
    bit prev_data_out_ready;

    apply_reset();
    start_clk_i();

    data_in_valid_i  <= '1;
    data_out_ready_i <= '0;
    for (int i = 0; i < Depth; i++) begin
      prev_data_in_ready = data_in_ready_o;
      @(posedge clk_i);
    end

    @(posedge clk_i);
    data_in_valid_i <= '0;

    result_print(~data_in_ready_o & prev_data_in_ready, "sync reset");

    arst_ni <= '0;
    @(posedge clk_i);
    arst_ni <= '1;
    @(posedge clk_i);

    data_in_valid_i <= '1;
    for (int i = 0; i < Depth; i++) begin
      prev_data_in_ready = data_in_ready_o;
      @(posedge clk_i);
    end

    @(posedge clk_i);
    data_in_valid_i <= '0;

    result_print(~data_in_ready_o & prev_data_in_ready, "data_in_ready_o LOW at exact full");

    data_out_ready_i <= '1;
    for (int i = 0; i < Depth; i++) begin
      prev_data_out_valid = data_out_valid_o;
      @(posedge clk_i);
    end

    @(posedge clk_i);
    data_out_ready_i <= '0;

    result_print(~data_out_valid_o & prev_data_out_valid, "data_out_valid_o LOW at exact empty");

    repeat (2) @(posedge clk_i);

    data_in_valid_i  <= '0;
    data_out_ready_i <= '0;

    @(posedge clk_i);
    prev_data_in_valid  = data_in_valid_i;
    prev_data_in_ready  = data_in_ready_o;
    prev_data_out_valid = data_out_valid_o;
    prev_data_out_ready = data_out_ready_i;

    data_in_valid_i  <= '1;
    data_out_ready_i <= '1;
    @(posedge clk_i);

    result_print(
        ~prev_data_in_valid
      & prev_data_in_ready
      & ~prev_data_out_valid
      & ~prev_data_out_ready
      & data_in_valid_i
      & data_in_ready_o
      & data_out_valid_o
      & data_out_ready_i
        , "direct bypass when EMPTY");

    data_out_ready_i <= '0;
    data_in_valid_i  <= '1;
    do @(posedge clk_i); while (data_in_ready_o);
    data_in_valid_i <= '0;

    @(posedge clk_i);
    prev_data_in_valid  = data_in_valid_i;
    prev_data_in_ready  = data_in_ready_o;
    prev_data_out_valid = data_out_valid_o;
    prev_data_out_ready = data_out_ready_i;

    data_in_valid_i  <= '1;
    data_out_ready_i <= '1;
    @(posedge clk_i);

    result_print(
        ~prev_data_in_valid
      & ~prev_data_in_ready
      & prev_data_out_valid
      & ~prev_data_out_ready
      & data_in_valid_i
      & data_in_ready_o
      & data_out_valid_o
      & data_out_ready_i
        , "both sides handshake when FULL");

    // Reset again

    apply_reset();

    arst_ni <= '0;
    @(posedge clk_i);
    arst_ni <= '1;
    @(posedge clk_i);

    data_in_valid_i <= '1;
    for (int i = 0; i < Depth; i++) begin
      @(posedge clk_i);
    end

    @(posedge clk_i);
    data_in_valid_i  <= '0;
    data_out_ready_i <= '1;

    repeat (2) @(posedge clk_i);

    prev_data_in_valid  = data_in_valid_i;
    prev_data_in_ready  = data_in_ready_o;
    prev_data_out_valid = data_out_valid_o;
    prev_data_out_ready = data_out_ready_i;

    @(posedge clk_i);

    result_print(
        ~prev_data_in_valid & prev_data_in_ready & prev_data_out_valid & prev_data_out_ready
        , "Only OUTPUT side handshake during FIFO-full");


    for (int i = 0; i < Depth; i++) begin
      @(posedge clk_i);
    end

    @(posedge clk_i);
    data_in_valid_i  <= '1;
    data_out_ready_i <= '0;

    @(posedge clk_i);
    prev_data_in_valid  = data_in_valid_i;
    prev_data_in_ready  = data_in_ready_o;
    prev_data_out_valid = data_out_valid_o;
    prev_data_out_ready = data_out_ready_i;

    result_print(
        prev_data_in_valid & prev_data_in_ready & prev_data_out_valid & ~prev_data_out_ready,
        "Only INPUT side handshake during FIFO-empty");

    apply_reset();
    start_clk_i();

    while (out_count < 100) begin
      data_in_i <= $urandom;
      data_in_valid_i <= ($urandom_range(0, 9) > 8);
      data_out_ready_i <= ($urandom_range(0, 9) > 0);
      @(posedge clk_i);
    end

    while (inp_count < 200) begin
      data_in_i <= $urandom;
      data_in_valid_i <= $urandom_range(0, 1);
      data_out_ready_i <= $urandom_range(0, 1);
      @(posedge clk_i);
    end
    //data_out_ready_i <= 0;

    result_print(err == 0, "Data First-In-First-Out Verified");

    $finish();
  end

endmodule
