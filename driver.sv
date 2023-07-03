//`ifndef  DRIVER_SV
////`include "packet.sv"
//`define DRIVER_SV
//`include "packet.sv"

class driver;
    virtual fifo_if vif;
    event drv_done;
    mailbox drv_mbox;
    packet pkt;
    
    function new (mailbox mbx);
        this.drv_mbox = mbx;    
    endfunction
    
    task run();
        @(negedge   vif.clk);
            forever begin
                drv_mbox.get(pkt);
                
                vif.writep <= pkt.WEn;
                vif.readp <= pkt.REn;
                if(pkt.WEn) begin
                    vif.src_in <= pkt.src_in;
                    vif.dst_in <= pkt.dst_in;
                    vif.data_in <= pkt.data_in;
                end
                else begin 
                    vif.src_in <= 8'bz;
                    vif.dst_in <= 8'bz;
                    vif.data_in <= 32'bz;
                end
                //pkt.display("driver get pkt from gen");
                //->drv_done;
                @(negedge vif.clk);
                ->drv_done;
            end
    endtask

endclass
//`endif 