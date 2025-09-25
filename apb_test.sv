class apb_test extends uvm_test;
  
  `uvm_component_utils(apb_test)
  
  apb_sequence seq;
  apb_env env;
  
  function new(string name = "apb_test",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = apb_env::type_id::create("env",this);
    //seq = apb_sequence::type_id::create("seq",this);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq = apb_sequence::type_id::create("seq");
    seq.start(env.act_agt.seqr);
    #30;
    phase.drop_objection(this);    
  endtask
  
endclass

class apb_regression_test extends apb_test;
  
  `uvm_component_utils(apb_regression_test)  
  
  function new(string name = "apb_regression_test",uvm_component parent);
    super.new(name,parent);
  endfunction 
  
  task run_phase(uvm_phase phase);
    apb_regression seq_reg;
    phase.raise_objection(this);
    seq_reg = apb_regression::type_id::create("seq_reg");
    seq_reg.start(env.act_agt.seqr);
    #30;
    phase.drop_objection(this);    
  endtask
  
endclass
