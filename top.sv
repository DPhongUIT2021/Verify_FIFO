`timescale 1ps/1ps


module top;
    parameter T = 10;
    reg clk, rst;

    fifo_if inf(clk, rst);
    test t0;
    
    fifo #(3) U1(clk, rst, inf.src_in, inf.dst_in, inf.data_in, inf.writep, inf.readp, 
	            inf.src_out, inf.dst_out, inf.data_out, inf.emptyp, inf.fullp);
    initial begin
            t0 = new;
            t0.e0.vif = inf;
            reset();
            t0.e0.run();

            t0.run_test_case_1();
            run_test_case_2();
    
           $finish;
        end
        
        always #(T/2) clk = ~clk;
        
        task reset();
                clk = 0;
                rst = 1;
                #T; 
                rst = 0;
                #T;
        endtask
        
        task run_test_case_2();
                fork
                      begin  // Writer
                             repeat (500) begin
                                        if (inf.fullp == 1'b0) begin
                                               t0.e0.g0.gen_write_random (1);
                                               #(T/2);
                                        end
                                        else begin
                                                $display ("WRITER is waiting..");
                                        end
                                #(50 + ($random % 50)); // Delay a random amount of time between 0ns and 100ns
                             end
                             $display ("Done with WRITER fork..");
                             $finish;
                      end
                      begin     // Reader
                             forever begin
                                    if (inf.emptyp == 1'b0) begin
                                        t0.e0.g0.gen_read (1);
                                    end  
                                    else begin
                                        $display ("READER is waiting..");
                                    end
                                    #(50 + ($random % 50));    
                             end
                      end
                   join
                   $display ("Done TEST2.");
        endtask
        
endmodule
