class v_seq_fibonacci extends  vseq_base;
  `uvm_object_utils(v_seq_fibonacci)

  function new(string name = "v_seq_fibonacci");
    super.new(name);
  endfunction : new

  virtual task body();
    fibonacci_sequence  fibo_seq_h;
    //----------------------------------//
    super.body();
    
    `uvm_info("v_seq_fibonacci", "Executing sequence", UVM_HIGH)

    `uvm_do_on(fibo_seq_h, talu_sqr_h)

    `uvm_info("v_seq_fibonacci", "Sequence complete", UVM_HIGH)
    
  endtask : body

endclass : v_seq_fibonacci