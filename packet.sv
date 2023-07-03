`ifndef PACKET_SV
`define PACKET_SV
 
class packet;
    rand logic[7:0] src_in;
    rand logic[7:0] dst_in;
    rand logic[31:0] data_in;

    logic WEn, REn;
    constraint r_w {    WEn != REn;
                             }
    logic [7:0] 	src_out;
    logic [7:0]	    dst_out;
    logic [31:0]   data_out;
    logic		Empty;
    logic		Full;

    function void  display(string tag="");
        $display("T=%0t [%s] src_in=%0d dst_in=%0d data_in=%0h WEn=%0d REn=%0d Empty=%0d Full=%0d",
                        $time, tag, src_in, dst_in, data_in, WEn, REn, Empty, Full);
    endfunction

    function void display_moniter(string tag="");
        $display("T=%0t [%s] data_out=%0h Empty=%0d Full=%0d", $time, tag, data_out, Empty, Full);
    endfunction
    
endclass

`endif
