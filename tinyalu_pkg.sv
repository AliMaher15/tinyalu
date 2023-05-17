package tinyalu_pkg;
  
  //uvm pakage and macros
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  // ALU operations
  typedef enum bit[2:0] {
                         no_op  = 3'b000,
                         add_op = 3'b001,
                         and_op = 3'b010,
                         xor_op = 3'b011,
                         mul_op = 3'b100,
                         rst_op = 3'b111
  } operation_t;

`include "env_config.svh"
`include "tinyalu_agent_config.svh"

`include "sequence_item.svh"   
`include "result_transaction.svh"

`include "fibonacci_sequence.svh"
`include "random_sequence.svh"
`include "reset_sequence.svh"
`include "short_random_sequence.svh"
`include "maxmult_sequence.svh"


`include "driver.svh"
`include "tinyalu_sequencer.svh"
`include "coverage.svh"
`include "scoreboard.svh"
`include "command_monitor.svh"
`include "result_monitor.svh"
`include "tinyalu_agent.svh"

`include "vsequencer.svh"

`include "vseq_base.svh"
`include "v_seq_fibonacci.svh"
`include "v_parallel_sequence.svh"
`include "v_runall_sequence.svh"

`include "env.svh"

`include "tinyalu_base_test.svh"
`include "fibonacci_test.svh"
`include "parallel_test.svh"
`include "full_test.svh"


endpackage : tinyalu_pkg
