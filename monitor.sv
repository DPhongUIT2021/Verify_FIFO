//`ifndef MONITOR_SV
`include "packet.sv"
//`define MONITOR_SV

class monitor;
    virtual fifo_if vif;
    mailbox checker_mbox;
    packet pkt;
    
    function new (mailbox mbx);
        this.checker_mbox = mbx;    
    endfunction
    
    task run();
        forever begin
            @(posedge   vif.clk);
            #1;
                pkt = new;
                pkt.data_in = vif.data_in;
                pkt.REn = vif.readp;
                pkt.WEn = vif.writep; 
                
                if(vif.readp)  pkt.data_out = vif.data_out;
                
                pkt.Empty = vif.emptyp;
                pkt.Full = vif.fullp;
                
                //pkt.display_monitor("Monitor");
                checker_mbox.put(pkt);
        end
    endtask

endclass
//`endif