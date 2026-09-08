module counter8(
input clk,
input reset,
input load,
input up_down,
input [7:0] data_in,
output reg [7:0] count
);

always @(posedge clk) begin
if (reset)
count <= 8'b0;
else if (load)
count <= data_in;
else if (up_down)
count <= count + 1;
else
count <= count - 1;
end 
endmodule
