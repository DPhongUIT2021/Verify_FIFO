//`ifndef GENERATOR_SV
//`define GENERATOR_SV
`include "packet.sv"

class generator;
    mailbox gen_mbox;
    event drv_done;
    packet pkt;
    
    function new (mailbox mbx);
        this.gen_mbox = mbx;    
    endfunction

    task gen_write(logic[7:0] src=0, logic[7:0] dst=0, logic[31:0] data=0); 
        pkt = new;
        pkt.WEn = 1;
        pkt.REn = 0;
        pkt.src_in = src;
        pkt.dst_in = dst;
        pkt.data_in = data;
        //pkt.display("gen write");
        gen_mbox.put(pkt);
        @(drv_done);
        //gen_end();
    endtask

    task gen_write_random(int n=0);  
        for (int i=0; i<n; i++) begin
            pkt = new;
            pkt.WEn = 1;
            pkt.REn = 0;
            assert(pkt.randomize());
            //pkt.display("gen write random");
            gen_mbox.put(pkt);
            @(drv_done);
        end
        //gen_end();
    endtask

    task gen_read(int n=0); 
        //  gen read src_in 8'bz==== 
        for (int i=0; i<n; i++) begin
            pkt = new;
            pkt.WEn = 0;
            pkt.REn = 1;
            //pkt.display_moniter("gen read");
            gen_mbox.put(pkt);
            @(drv_done);
        end
        //gen_end();
    endtask

    task gen_end();  
        pkt = new;
        pkt.REn = 0;
        pkt.WEn = 0;
        pkt.src_in = 8'bz;
        pkt.dst_in = 8'bz;
        pkt.data_in = 32'bz;
        //pkt.display("Gen END");
        gen_mbox.put(pkt);
        @(drv_done);
    endtask
    
endclass
//`endif 