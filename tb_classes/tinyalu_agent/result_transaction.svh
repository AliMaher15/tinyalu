class result_transaction extends  uvm_sequence_item;

  shortint result;

  // add to factory and implement (print,compare,copy,...)
  `uvm_object_utils_begin(result_transaction)
    `uvm_field_int ( result, UVM_DEFAULT)
  `uvm_object_utils_end

  extern function new(string name = "");
  extern function string convert2string();
  
endclass : result_transaction



// constructor
function result_transaction::new(string name = "");
  super.new(name);
endfunction : new



// convert2string
function string result_transaction::convert2string();
  string s;
  s = $sformatf("result = %4h", result);
  return s;
endfunction : convert2string