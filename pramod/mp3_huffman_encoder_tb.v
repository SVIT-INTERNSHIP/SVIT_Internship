module tb_mp3_huffman_encoder;
    reg clk=0, rst=1, valid=0, flush=0; reg [3:0] pcm_data=0;
    wire out_valid; wire [31:0] main_data_word; wire [5:0] bit_count;
    
    mp3_huffman_encoder DUT (clk,rst,valid,flush, pcm_data, out_valid, main_data_word, bit_count);
    always #5 clk = ~clk;

    initial begin
        $dumpfile("mp3_huffman.vcd");
        $dumpvars(0, tb_mp3_huffman_encoder);
        $monitor("T=%0t | v=%b f=%b pcm=%d | out_v=%b word=0x%h bits=%0d", 
        $time, valid, flush, pcm_data, out_valid, main_data_word, bit_count);
        #10 rst = 0;
        repeat(12) begin @(posedge clk); valid <= 1; pcm_data <= 3; end
        @(posedge clk); valid <= 0; flush <= 1;
        @(posedge clk); flush <= 0;
        #20 $finish;
    end
endmodule 
