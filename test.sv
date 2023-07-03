`include "env.sv"

class test;
    parameter T = 10;
    env e0;
    
    virtual task run();
            e0.run();
    endtask
    
    function new();
        e0 = new;
    endfunction
    
    task run_test_case_1();
        // ** Write 3 values.
        e0.g0.gen_write(0,1,16'h1111);
        e0.g0.gen_write(1,2,16'h2222);
        e0.g0.gen_write(3,4,16'h3333);
        
        // ** Read 2 values
            e0.g0.gen_read(2);
            
            // ** Write one more
        e0.g0.gen_write(5,6,16'h4444);
        
        // ** Read a bunch of values
        e0.g0.gen_read(6);
        
        // *** Write a bunch more values
        e0.g0.gen_write (0,1,16'h0001);
        e0.g0.gen_write (0,1,16'h0002);
        e0.g0.gen_write (0,1,16'h0003);
        e0.g0.gen_write (0,1,16'h0004);
        e0.g0.gen_write (0,1,16'h0005);
        e0.g0.gen_write (0,1,16'h0006);
        e0.g0.gen_write (0,1,16'h0007);
        e0.g0.gen_write (0,1,16'h0008);
        e0.g0.gen_write (0,1,16'h0009);
        
        // ** Read a bunch of values
        e0.g0.gen_read(8);
        
        $display ("Done TEST1.");
    endtask
       
    
endclass