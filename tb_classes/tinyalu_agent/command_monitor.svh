class command_monitor extends  uvm_component;

  // add to factory
  `uvm_component_utils(command_monitor);

  virtual tinyalu_bfm bfm;
  uvm_analysis_port #(sequence_item) ap; // Analysis Port
  
  extern function new(string name, uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern function void write_to_monitor(byte A, byte B, operation_t op);

endclass : command_monitor



// Constructor
function command_monitor::new(string name, uvm_component parent);
  super.new(name,parent);
endfunction : new



// Build Phase
function void command_monitor::build_phase(uvm_phase phase);

  if(!uvm_config_db#(virtual tinyalu_bfm)::get(null, "*", "bfm", bfm))
    `uvm_fatal("COMMAND MONITOR", "Failed to get BFM")

  ap = new("ap",this);
  
endfunction : build_phase



// Connect Phase
function void command_monitor::connect_phase(uvm_phase phase);
  bfm.command_monitor_h = this;
endfunction : connect_phase



// Write To Monitor
function void command_monitor::write_to_monitor(byte A, byte B, operation_t op);

  sequence_item  cmd;

  `uvm_info("COMMAND MONITOR", $sformatf("MONITOR: A: %2h  B: %2h  op: %s",
            A, B, op.name()), UVM_HIGH)

  cmd = new("cmd");

  cmd.A = A;
  cmd.B = B;
  cmd.op = op;

  ap.write(cmd);
  
endfunction : write_to_monitor