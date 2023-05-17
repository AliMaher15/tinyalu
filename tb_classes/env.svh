class env extends  uvm_env;
  
  // add to factory
  `uvm_component_utils(env);

  // handles
  vsequencer              v_sqr_h;

  tinyalu_agent           tinyalu_agent_h;
  tinyalu_agent_config    tinyalu_agent_config_h;

  virtual tinyalu_bfm bfm;
  env_config    env_config_h;

  extern function new(string name, uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);

endclass : env


// Constructor
function env::new(string name, uvm_component parent);
  super.new(name,parent);
endfunction : new


// Build Phase
function void env::build_phase(uvm_phase phase);
  super.build_phase(phase);

  if(!uvm_config_db #(env_config)::get(this, "","bfm", env_config_h))
    `uvm_fatal("ENV", "Failed to get BFM")

  tinyalu_agent_config_h = new(.bfm(env_config_h.bfm),  .is_active(UVM_ACTIVE));

  uvm_config_db#(tinyalu_agent_config)::set(this, "tinyalu_agent_h*", "bfm", 
                                            tinyalu_agent_config_h);

  tinyalu_agent_h = tinyalu_agent::type_id::create("tinyalu_agent_h",this);
  v_sqr_h         =    vsequencer::type_id::create("v_sqr_h" , this);

endfunction : build_phase


// Connect Phase
function void env::connect_phase(uvm_phase phase);
  super.connect_phase(phase);

  v_sqr_h.talu_sqr_h = tinyalu_agent_h.sqr_h;

endfunction : connect_phase
