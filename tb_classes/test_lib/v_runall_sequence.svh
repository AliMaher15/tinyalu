class v_runall_sequence extends vseq_base;
   `uvm_object_utils(v_runall_sequence); 
   
 function new(string name = "v_runall_sequence");
   super.new(name);
 endfunction : new

 task body();
   reset_sequence reset;
   maxmult_sequence maxmult;
   random_sequence random;
   uvm_component uvm_component_h;
   //----------------------------------//
   super.body();
   `uvm_info("v_runall_sequence", "Executing sequence", UVM_HIGH)
      `uvm_do_on(reset, talu_sqr_h) // seqr inside agent
      `uvm_do_on(maxmult, talu_sqr_h)
      `uvm_do_on(random, talu_sqr_h)
      `uvm_info("v_runall_sequence", "Sequence complete", UVM_HIGH)
 endtask : body
   
endclass : v_runall_sequence



