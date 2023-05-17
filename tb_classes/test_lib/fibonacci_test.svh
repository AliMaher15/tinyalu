class fibonacci_test extends  tinyalu_base_test;

  // add to factory
  `uvm_component_utils(fibonacci_test);

  extern function new(string name, uvm_component parent);
  extern task run_phase(uvm_phase phase);
  
endclass : fibonacci_test


// Constructor
function fibonacci_test::new(string name, uvm_component parent);
  super.new(name,parent);
endfunction : new


// Run Phase
task fibonacci_test::run_phase(uvm_phase phase);
  v_seq_fibonacci vseq = v_seq_fibonacci::type_id::create("vseq");

  phase.raise_objection(this);
    `uvm_info("fibonacci_test run","Starting test", UVM_MEDIUM)
    vseq.start(env_h.v_sqr_h);
    `uvm_info("fibonacci_test run","Ending test", UVM_MEDIUM)
  phase.drop_objection(this);

endtask : run_phase