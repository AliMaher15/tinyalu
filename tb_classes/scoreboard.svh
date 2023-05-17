class scoreboard extends  uvm_subscriber #(result_transaction);
  
  // Add to Factory
  `uvm_component_utils(scoreboard)

  uvm_tlm_analysis_fifo  #(sequence_item)  cmd_f;

  extern function new(string name, uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function result_transaction predictor(sequence_item cmd);
  extern function void write(result_transaction t);


endclass : scoreboard



// Constructor
function scoreboard::new(string name, uvm_component parent);
  super.new(name,parent);
endfunction : new


// Build Phase
function void scoreboard::build_phase(uvm_phase phase);
  cmd_f = new("cmd_f",this);
endfunction : build_phase


// Predictor
function result_transaction scoreboard::predictor(sequence_item cmd);
  result_transaction predicted;

  predicted = new("predicted");

  case(cmd.op)
    add_op: predicted.result = cmd.A + cmd.B;
    and_op: predicted.result = cmd.A & cmd.B;
    xor_op: predicted.result = cmd.A ^ cmd.B;
    mul_op: predicted.result = cmd.A * cmd.B;
  endcase // cmd.op

  return predicted;

endfunction : predictor


// Write
function void scoreboard::write(result_transaction t);
  string  data_str;
  sequence_item  cmd;
  result_transaction  predicted;

  do
    if (!cmd_f.try_get(cmd)) begin
      $fatal(1, "Missing command in self checker");
    end
  while( (cmd.op == no_op) || (cmd.op == rst_op)); // wait for an actual cmd

  predicted = predictor(cmd);

  // group data into a string
  data_str = {                cmd.convert2string(),
               "==> Actual ", t.convert2string(),
               "/predicted ", predicted.convert2string()};

  if (!predicted.compare(t)) // compare predicted and result_transaction
    `uvm_error("SCOREBOARD", {"FAIL", data_str})
  else
    `uvm_info ("SCOREBOARD", {"PASS: ", data_str}, UVM_HIGH)

endfunction : write