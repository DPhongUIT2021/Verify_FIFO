`include "driver.sv"
`include "generator.sv"
//`include "packet.sv"
`include "monitor.sv"
`include "checker.sv"

class env;
    driver d0;
    generator g0;
    monitor m0;
    check c0;

    mailbox drv_mbox;
    mailbox checker_mbox;
    event drv_done;

    virtual fifo_if vif;

    function new();
        drv_mbox = new();
        checker_mbox = new();
        
        d0 = new(drv_mbox);
        g0 = new(drv_mbox);
        
        m0 = new(checker_mbox);
        c0 = new(checker_mbox);
    endfunction

    virtual task run();

        d0.drv_done = drv_done;
        g0.drv_done = drv_done;

        d0.vif = vif;
        m0.vif = vif;
        c0.vif = vif;

        fork
            d0.run();
            m0.run();
            c0.run();
        join_none

    endtask
endclass
