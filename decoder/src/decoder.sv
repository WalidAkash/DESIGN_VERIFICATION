// ### Author : Walid Akash (walidakash070@gmail.com)

module decoder #(
  parameter int NUM_WIRE = 4
) (
    input logic [$clog2(NUM_WIRE)-1:0] a_i,
    input logic                        a_valid_i,
    output logic    [NUM_WIRE-1:0] d_o
  );

  ////////////////////////////////////////////////////////////////////////////
  //-RTLS
  ///////////////////////////////////////////////////////////////////////////
 
  demux #(
    .NUM_ELEM (NUM_WIRE)
  ) u_demux (
      .s_i(a_i),
      .i_i(a_valid_i),
      .o_o(d_o)
  );
  
endmodule 
