class driver extends  uvm_driver #(sequence_item);

  // add to factory
  `uvm_component_utils(driver);

  virtual tinyalu_bfm bfm;
  
  extern function new(string name, uvm_component parent);
  extern task run_phase(uvm_phase phase);
  
endclass : driver



// Constructor
function driver::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new


// Run Phase
task driver::run_phase(uvm_phase phase);
  
  sequence_item   cmd;

  forever begin : cmd_loop
    shortint unsigned result;

    seq_item_port.get_next_item(cmd);
      
      bfm.send_op(cmd.A, cmd.B, cmd.op, result);
      cmd.result = result;

    seq_item_port.item_done();

  end : cmd_loop

endtask : run_phase