module tb_mp3_huffman_encoder;
    reg clk;
    reg rst;
    reg valid;
    reg [3:0] pcm_data;

    wire out_valid;
    wire [31:0] main_data;
    wire [5:0] bit_count;
  
    mp3_huffman_encoder DUT (
        .clk(clk),
        .rst(rst),
        .valid(valid),
        .pcm_data(pcm_data),
        .out_valid(out_data),
        .main_data(main_data),
        .bit_count(bit_count)
    );
    always #5 clk = ~clk;
    initial begin
        $dumpfile("mp3_huffman.vcd");
        $dumpvars(0, tb_mp3_huffman_encoder);
      
        clk      = 1'b0;
        rst      = 1'b1;
        valid    = 1'b0;
        pcm_data = 4'd0;

        #10;
        rst = 1'b0;

        @(posedge clk); valid <= 1'b1; pcm_data <= 4'd0;
        @(posedge clk); valid <= 1'b1; pcm_data <= 4'd0;
        @(posedge clk); valid <= 1'b1; pcm_data <= 4'd1;
        @(posedge clk); valid <= 1'b1; pcm_data <= 4'd0;
        @(posedge clk); valid <= 1'b1; pcm_data <= 4'd2;
        @(posedge clk); valid <= 1'b1; pcm_data <= 4'd0;
        @(posedge clk); valid <= 1'b1; pcm_data <= 4'd3;
        @(posedge clk); valid <= 1'b0; pcm_data <= 4'd0;

        #30;
        $finish;
    end
    always @(posedge clk) begin
        if (out_valid) begin
            $strobe("Time=%0t | PCM Input=%d | Main Data=%b | Bit Count=%0d",
                    $time, pcm_data, main_data, bit_count);

        end
    end
endmodule
