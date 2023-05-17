class tinyalu_base_test extends  uvm_test;
  `uvm_component_utils(tinyalu_base_test)
  
  // handles
  env env_h;
  
  virtual tinyalu_bfm bfm;
  env_config env_config_h;

  extern function new(string name, uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void start_of_simulation_phase(uvm_phase phase);
  
endclass : tinyalu_base_test


// Constructor
function tinyalu_base_test::new(string name, uvm_component parent);
  super.new(name,parent);
endfunction : new


// Build Phase
function void tinyalu_base_test::build_phase(uvm_phase phase);
  super.build_phase(phase);


  if(!uvm_config_db #(virtual tinyalu_bfm)::get(this, "","bfm", bfm))
  `uvm_fatal("TEST", "Failed to get BFM")

  env_config_h = new(.bfm(bfm));
      
  uvm_config_db #(env_config)::set(this, "env_h*", "bfm", env_config_h);

  env_h = env::type_id::create("env_h",this);
endfunction : build_phase


// Print Testbench structure and factory contents
function void tinyalu_base_test::start_of_simulation_phase(uvm_phase phase);
  
  super.start_of_simulation_phase(phase);

  if (uvm_report_enabled(UVM_MEDIUM)) begin
    this.print();
    factory.print();
  end

endfunction : start_of_simulation_phase