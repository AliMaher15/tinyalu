class coverage extends  uvm_subscriber #(sequence_item);

  // add to factory
  `uvm_component_utils(coverage);

  // variables
  byte  unsigned  A;
  byte  unsigned  B;
  operation_t   op_set;

  extern function new(string name, uvm_component parent);
  extern function void write(sequence_item t);

  // Cover Groups

  covergroup op_cov; //All operations
    
    coverpoint op_set {
      bins single_cycle[] = {[add_op : xor_op], rst_op, no_op};
      bins multi_cycle = {mul_op};


      //transitions (op to rst) and (rst to op)
      bins opn_rst[] = ([add_op : mul_op] => rst_op); 
      bins rst_opn[] = (rst_op => [add_op : mul_op]);

      // transitions (single cycle to multi cycle) and (multi cycle to single cycle)
      bins sngl_mul[] = ([add_op:xor_op],no_op => mul_op); 
      bins mul_sngl[] = (mul_op => [add_op:xor_op],no_op);

      // back to back operations
      bins twoops[] = ([add_op:mul_op] [* 2]);
      bins manymult = (mul_op [* 3:5]);

      // Patterns
      bins rstmulrst   = (rst_op => mul_op [=  2] => rst_op);
      bins rstmulrstim = (rst_op => mul_op [-> 2] => rst_op);
    }

  endgroup : op_cov

  covergroup zeros_or_ones_on_ops;

    // Operations
    all_ops : coverpoint op_set {
       ignore_bins null_ops = {rst_op, no_op};}

    // A bins
    a_leg: coverpoint A {
       bins zeros = {'h00};
       bins others= {['h01:'hFE]};
       bins ones  = {'hFF};
    }

    // B bins
    b_leg: coverpoint B {
       bins zeros = {'h00};
       bins others= {['h01:'hFE]};
       bins ones  = {'hFF};
    }

    // All operations crossing All ones and All zeros
    op_00_FF:  cross a_leg, b_leg, all_ops {
       bins add_00 = binsof (all_ops) intersect {add_op} &&
                     (binsof (a_leg.zeros) || binsof (b_leg.zeros));

       bins add_FF = binsof (all_ops) intersect {add_op} &&
                     (binsof (a_leg.ones) || binsof (b_leg.ones));

       bins and_00 = binsof (all_ops) intersect {and_op} &&
                     (binsof (a_leg.zeros) || binsof (b_leg.zeros));

       bins and_FF = binsof (all_ops) intersect {and_op} &&
                     (binsof (a_leg.ones) || binsof (b_leg.ones));

       bins xor_00 = binsof (all_ops) intersect {xor_op} &&
                     (binsof (a_leg.zeros) || binsof (b_leg.zeros));

       bins xor_FF = binsof (all_ops) intersect {xor_op} &&
                     (binsof (a_leg.ones) || binsof (b_leg.ones));

       bins mul_00 = binsof (all_ops) intersect {mul_op} &&
                     (binsof (a_leg.zeros) || binsof (b_leg.zeros));

       bins mul_FF = binsof (all_ops) intersect {mul_op} &&
                     (binsof (a_leg.ones) || binsof (b_leg.ones));

       bins mul_max = binsof (all_ops) intersect {mul_op} &&
                      (binsof (a_leg.ones) && binsof (b_leg.ones));

       ignore_bins others_only = binsof(a_leg.others) && binsof(b_leg.others);

    }
    
  endgroup : zeros_or_ones_on_ops
  
endclass : coverage


// Constructor
function coverage::new(string name, uvm_component parent);
  super.new(name,parent);
  // CoverGroups
  op_cov = new();
  zeros_or_ones_on_ops = new();
endfunction : new


// Write Transaction and Sample Covergroups
function void coverage::write(sequence_item t);
  A = t.A;
  B = t.B;
  op_set = t.op;

  // Sample Covergroups
  op_cov.sample();
  zeros_or_ones_on_ops.sample();
  
endfunction : write