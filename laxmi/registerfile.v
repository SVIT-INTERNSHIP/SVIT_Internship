module registerfile(
input clk,
input reset,
input write_enable,
input[3:0]write_addr,
input[7:0]write_data,
input[3:0]read_addr,
output[7:0]read_data
);

reg[7:0] registers [0:15];
integer i;

always@(posedge clk) begin
if(reset) begin
for(i=0;i<16;i=i+1)
registers[i]<=8'b0;
end
else if(write_enable) begin
registers[write_addr]<=write_data;
end
end

assign read_data=registers[read_addr];
endmodule
