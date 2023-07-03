	
class check;
    mailbox checker_mbox;
    virtual fifo_if vif;
    packet pkt;
    
    logic[31:0] queue_lib[$:7]; //create FIFO library of  SV
    logic empty_lib, full_lib;
    
    function new (mailbox mbx);
        this.checker_mbox = mbx;    
    endfunction

    task run();
        forever begin
            checker_mbox.get(pkt);  // get output of driver, get output of DUT
            if(vif.rst) queue_lib = {};
            else begin
                if(pkt.WEn) begin 
                    if(queue_lib.size() < 8) queue_lib.push_back(pkt.data_in);
                    else begin
                            $display("FAILURE: Overflow Detected at time T=%0t!.  Exiting test.", $time );
                    end 
                end 
                if(pkt.REn) begin
                    if(queue_lib.size() > 0)    queue_lib.pop_front();
                    else begin
                            $display("FAILURE: Underflow Detected at time T=%0t!.  Exiting test.", $time);
                    end
                end
                if(queue_lib.size() == 8) full_lib = 1;
                else full_lib = 0;
                if(queue_lib.size() == 0) empty_lib = 1;
                else empty_lib = 0;       
                         
               if(full_lib == 1 &&  pkt.Full == 0 || full_lib == 0 && pkt.Full == 1) begin
                       $display("FAILURE: Full flag missed at time T=%0t.  Exiting test.", $time);
               end
               if(empty_lib == 1 &&  pkt.Empty == 0 || empty_lib == 0 && pkt.Empty == 1) begin
                        $display("FAILURE: Empty flag missed at time T=%0t.  Exiting test.", $time);
               end
                // if(queue_lib.size() == 8) begin
                //         if(pkt.Full != 1) $display("FAILURE: Full flag missed at time T=%0t.  Exiting test.", $time);
                // end
                // if(queue_lib.size() == 0) begin
                //          if(pkt.Empty != 1) $display("FAILURE: Empty flag missed at time T=%0t.  Exiting test.", $time);
                // end
            end
        end
    endtask
endclass
