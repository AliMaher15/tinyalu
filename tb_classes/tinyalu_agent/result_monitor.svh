class result_monitor extends  uvm_component;

  // Add to Factory
  `uvm_component_utils(result_monitor);

  virtual tinyalu_bfm bfm;
  uvm_analysis_port #(result_transaction) ap; // Analysis Port

  extern function new(string name, uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern function void write_to_monitor(shortint r);
  
endclass : result_monitor



// Constructor
function result_monitor::new(string name, uvm_component parent);
  super.new(name,parent);
endfunction : new



// Build Phase
function void result_monitor::build_phase(uvm_phase phase);

  if(!uvm_config_db#(virtual tinyalu_bfm)::get(null, "*", "bfm", bfm))
    `uvm_fatal("RESULT MONITOR", "Failed to get BFM")

  ap = new("ap",this);
  
endfunction : build_phase



// Connect Phase
function void result_monitor::connect_phase(uvm_phase phase);
  bfm.result_monitor_h = this;
endfunction : connect_phase



// Write To Monitor
function void result_monitor::write_to_monitor(shortint r);

  result_transaction  result_t;

  `uvm_info("RESULT MONITOR", $sformatf("MONITOR: result: %4h", r), UVM_HIGH)

  result_t = new("result_t");

  result_t.result = r;

  ap.write(result_t);
  
endfunction : write_to_monitor