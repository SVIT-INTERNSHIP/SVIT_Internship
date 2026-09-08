odule mp3_huffman_encoder (
    input             clk,
    input             rst,
    input	      valid,
    input      [3:0]  pcm_data,
    output reg        out_valid,
    output reg [31:0] main_data,
    output reg [5:0]  bit_count
);
    reg [2:0] huff_code;
    reg [2:0] huff_len;

    always @(*) begin
        case (pcm_data)
            4'd0: begin
                huff_code = 3'b001;
                huff_len  = 3'd1;
            end
            4'd1: begin
                huff_code = 3'b001;
                huff_len  = 3'd2;
            end
            4'd2: begin
                huff_code = 3'b001;
                huff_len  = 3'd3;
            end
            4'd3: begin
                huff_code = 3'b000;
                huff_len  = 3'd3;
            end
            default: begin
                huff_code = 3'b000;
                huff_len  = 3'd0;
            end
        endcase

    end 
    wire [2:0] masked_code = huff_code & ((1'b1 << huff_len)-1'b1);
   
    always @(posedge clk or posedge rst) begin
        if (rst) begin 
            main_data <= 32'b0;
            bit_count <= 6'd0;
            out_valid <= 1'b0;
        end else begin
            out_valid <= 1'b0;
            if (valid) begin
                main_data <= (main_data << huff_len) | masked_code;
                bit_count <= bit_count + huff_len;
                out_valid <= 1'b1;
            end
        end
    end
endmodule
