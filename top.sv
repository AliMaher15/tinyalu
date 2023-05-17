module top;

  // import pakages and macros
  import uvm_pkg::*;
  import tinyalu_pkg::*;
  `include "uvm_macros.svh"

  // interface
  tinyalu_bfm bfm();
  
  // connect dut
  tinyalu DUT ( .A(bfm.A), .B(bfm.B), .op(bfm.op),
                .clk(bfm.clk), .reset_n(bfm.reset_n),
                .start(bfm.start), .done(bfm.done),
                .result(bfm.result) 
              );

  // begin test
  initial begin
    uvm_config_db#(virtual tinyalu_bfm)::set(null, "*", "bfm", bfm);
    run_test();
  end
  
endmodule : top