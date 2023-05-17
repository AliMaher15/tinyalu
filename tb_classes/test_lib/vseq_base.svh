class vseq_base extends  uvm_sequence;
  `uvm_object_utils(vseq_base)
  `uvm_declare_p_sequencer(vsequencer)

  tinyalu_sequencer  talu_sqr_h;

  function new(string name = "vseq_base");
    super.new(name);
  endfunction : new

  
  virtual task body();
    talu_sqr_h = p_sequencer.talu_sqr_h;
  endtask : body

endclass : vseq_base