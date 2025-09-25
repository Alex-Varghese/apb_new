class apb_driver extends uvm_driver#(apb_seq_item);
  
  `uvm_component_utils(apb_driver)
  virtual apb_intf vif;
  apb_seq_item req;
  function new(string name = "apb_driver", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual apb_intf)::get(this, "", "apb_intf", vif))
      `uvm_error(get_type_name(), "Failed to get Interface");
    
  endfunction
  
  task drive_inputs();
      	vif.apb_write_paddr <= req.apb_write_paddr;
        vif.apb_write_data <= req.apb_write_data;
        vif.READ_WRITE <= req.READ_WRITE;
        vif.apb_read_paddr <= req.apb_read_paddr;
				vif.transfer <= req.transfer;
				vif.PRESETn <= req.PRESETn;
				`uvm_info(get_type_name(),$sformatf("@(0%t) transfer = %b | reset = %b | read_write = %b | write_addr = %d | read_addr = %d | wdata = %d",$time, req.transfer,req.PRESETn, req.READ_WRITE, req.apb_write_paddr, req.apb_read_paddr, req.apb_write_data),UVM_MEDIUM)
  endtask
      
  task run_phase(uvm_phase phase);
    forever begin : f1
      seq_item_port.get_next_item(req);
      drive_inputs();
      seq_item_port.item_done();
      repeat(3)@(vif.drv_cb);
    end : f1
  endtask  
endclass

