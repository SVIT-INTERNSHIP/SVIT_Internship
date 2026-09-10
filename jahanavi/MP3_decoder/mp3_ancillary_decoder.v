`timescale 1ns/1ps

module mp3_ancillary_decoder(
     clk,
     reset,
     start_frame,
     data_valid,
     data_in,
     ancillary_data,
     ancillary_valid,
     ancillary_last
);

input clk;
input reset;
input start_frame;
input data_valid;
input [7:0] data_in;

output reg [7:0] ancillary_data;
output reg ancillary_valid;
output reg ancillary_last;

reg [8:0] byte_count;

always @(posedge clk)begin

    if (reset) begin

        byte_count <= 9'd0;
        ancillary_data <= 8'd0;
        ancillary_valid <= 1'b0;
        ancillary_last <= 1'b0;
    end
    else begin
    
     ancillary_valid <= 1'b0;
     ancillary_last <=1'b0;

     if (start_frame)  
        byte_count <=9'd0;
     

     if (data_valid) begin

     if (byte_count >=9'd136) begin
       ancillary_data <= data_in;
       ancillary_valid <= 1'b1;
     end

      if (byte_count == 9'd416)
          ancillary_last <= 1'b1;
      

      byte_count <= byte_count + 9'd1;
  
    end

  end

end
endmodule
