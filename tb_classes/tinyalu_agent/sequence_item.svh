class sequence_item extends  uvm_sequence_item;
  
  // variables
  rand byte unsigned       A;
  rand byte unsigned       B;
  rand operation_t        op;
  shortint unsigned   result;

  // add to factory and implement (print,compare,copy,...)
  `uvm_object_utils_begin(sequence_item)
    `uvm_field_int ( A,      UVM_DEFAULT)
    `uvm_field_int ( B,      UVM_DEFAULT)
    `uvm_field_int ( result, UVM_DEFAULT)
  `uvm_object_utils_end // enum type must be explicitly written for "op"

  // Constraints
  constraint op_con {
                     op dist { 
                               no_op := 1, add_op := 5,  and_op:=5, 
                               xor_op:=5 ,  mul_op:=5  , rst_op:=1 
                             }; // give less probability to rst and no_op
                    }

  constraint data { 
                   A dist {8'h00:=1, [8'h01 : 8'hFE]:=1, 8'hFF:=1};
                   B dist {8'h00:=1, [8'h01 : 8'hFE]:=1, 8'hFF:=1};
                  } // more probability to all zeros and all ones

  extern function new(string name = "");
  extern function string convert2string();
  extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
  extern function void do_copy(uvm_object rhs);

endclass : sequence_item


// constructor
function sequence_item::new(string name = "");
  super.new(name);
endfunction : new

// convert2string
function string sequence_item::convert2string();
  string s;
  //--------------------------------------//
  s = $sformatf("A: %2h   B: %2h  op: %s = %4h",
                 A, B, op.name(), result);
  return s;
endfunction : convert2string


// Do Compare
function bit sequence_item::do_compare(uvm_object rhs, uvm_comparer comparer);
      sequence_item     tested;
      bit               same;
      //-------------------------------------------//
      if (rhs==null) `uvm_fatal(get_type_name(), 
                                "Tried to do comparison to a null pointer");
      
      if (!$cast(tested,rhs))
        same = 0;
      else
        same = super.do_compare(rhs, comparer) && (tested.op == op);

      return same;

endfunction : do_compare


// Do Copy
function void sequence_item::do_copy(uvm_object rhs);
  sequence_item RHS;
  //-----------------------------------//
  assert(rhs != null) else
    $fatal(1,"Tried to copy null transaction");
  super.do_copy(rhs);
  assert($cast(RHS,rhs)) else
    $fatal(1,"Faied cast in do_copy");
  op = RHS.op;
endfunction : do_copy