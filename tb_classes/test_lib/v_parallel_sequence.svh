class v_parallel_sequence extends vseq_base;
   `uvm_object_utils(v_parallel_sequence)

   function new(string name = "v_parallel_sequence");
      super.new(name);
   endfunction : new

   task body();
      reset_sequence reset_h;
      short_random_sequence short_random_h;
      fibonacci_sequence fibonacci_h;
      //----------------------------------//
      super.body();
      `uvm_info("v_parallel_sequence", "Executing sequence", UVM_HIGH)

      `uvm_do_on(reset_h, talu_sqr_h) // seqr inside agent
      fork
	    `uvm_do_on(fibonacci_h, talu_sqr_h)
   	 `uvm_do_on(short_random_h, talu_sqr_h)
      join
      `uvm_info("v_seq_fibonacci", "Sequence complete", UVM_HIGH)
      
   endtask : body

endclass : v_parallel_sequence

     