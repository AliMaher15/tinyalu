class vsequencer extends  uvm_sequencer;
  `uvm_component_utils(vsequencer)

  tinyalu_sequencer  talu_sqr_h;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
  
endclass : vsequencer