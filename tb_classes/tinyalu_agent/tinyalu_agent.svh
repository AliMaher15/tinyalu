class tinyalu_agent extends  uvm_agent;
  
  // Add to Factory
  `uvm_component_utils(tinyalu_agent)

  tinyalu_agent_config tinyalu_agent_config_h;

  driver              driver_h;
  scoreboard          scoreboard_h;
  coverage            coverage_h;
  command_monitor     command_monitor_h;
  result_monitor      result_monitor_h;
  tinyalu_sequencer   sqr_h;

  //uvm_analysis_port #(sequence_item)      cmd_mon_ap;
  //uvm_analysis_port #(result_transaction) result_ap;

  extern function new(string name, uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);

  extern function void get_vif();

endclass : tinyalu_agent


// Constructor
function tinyalu_agent::new(string name, uvm_component parent);
  super.new(name,parent);
endfunction : new


// Build
function void tinyalu_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);
  get_vif();

  is_active = tinyalu_agent_config_h.get_is_active();

  if(is_active == UVM_ACTIVE) begin : make_stimulus
      driver_h = driver::type_id::create("driver_h",this);
      sqr_h    = tinyalu_sequencer::type_id::create("sqr_h", this);
  end

  command_monitor_h = command_monitor::type_id::create("command_monitor_h",this);
  result_monitor_h  = result_monitor::type_id::create("result_monitor_h",this);

  coverage_h = coverage::type_id::create("coverage_h",this);
  scoreboard_h = scoreboard::type_id::create("scoreboard_h",this);

  //cmd_mon_ap = new("cmd_mon_ap",this);
  //result_ap  = new("result_ap", this);

endfunction : build_phase


// Connect
function void tinyalu_agent::connect_phase(uvm_phase phase);
  super.connect_phase(phase);

   if (is_active == UVM_ACTIVE) begin : make_stimulus
    driver_h.seq_item_port.connect(sqr_h.seq_item_export);
    driver_h.bfm = tinyalu_agent_config_h.bfm;
  end
    
  //command_monitor_h.ap.connect(cmd_mon_ap);
  //result_monitor_h.ap.connect(result_ap);

  command_monitor_h.ap.connect(scoreboard_h.cmd_f.analysis_export);
  command_monitor_h.ap.connect(coverage_h.analysis_export);
  result_monitor_h.ap.connect(scoreboard_h.analysis_export);

endfunction : connect_phase


function void tinyalu_agent::get_vif();
  // get config
  if(!uvm_config_db#(tinyalu_agent_config)::get(this, "", "bfm", tinyalu_agent_config_h))
      `uvm_fatal("AGENT","Failed to get bfm")
endfunction : get_vif