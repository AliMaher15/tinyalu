class parallel_test extends tinyalu_base_test;
   `uvm_component_utils(parallel_test);
      
   function new(string name, uvm_component parent);
      super.new(name,parent);
   endfunction : new

   task run_phase(uvm_phase phase);
      v_parallel_sequence vseq = v_parallel_sequence::type_id::create("vseq");
      phase.raise_objection(this);
         `uvm_info("parallel_test run","Starting test", UVM_MEDIUM)
         vseq.start(env_h.v_sqr_h);
         `uvm_info("parallel_test run","Ending test", UVM_MEDIUM)
      phase.drop_objection(this);
   endtask : run_phase

endclass


