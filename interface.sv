`timescale 1ps/1ps
//module fifo (clk, rstp, src_in, dst_in, data_in, writep, readp, 
//	src_out, dst_out, data_out, emptyp, fullp);

interface fifo_if(input bit clk, input bit rst);  
    logic[7:0] src_in;
    logic[7:0] dst_in;
    logic[31:0] data_in;
    
    logic writep;
    logic readp;
    
    logic[7:0] src_out;
    logic[7:0] dst_out;
    logic[31:0] data_out;
    
    logic emptyp;
    logic fullp;

endinterface