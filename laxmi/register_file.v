module register_file(clk,reset,write_enable,write_addr,
write_data,read_addr,read_data);
input clk,reset,write_enable;
input [3:0]write_addr;
input [7:0]write_data;
input [3:0]read_addr;
output [7:0]read_data;

reg[7:0] registers [0:15];
integer i;

always @(posedge clk)
begin
if(reset) begin
for(i=0;i<16;i=1+1)
registers[i]<=8'b00000000;
end
else if(write_enable) begin
registers[write_addr]<=write_data;
end
end

assign read_data=registers[read_addr];
endmodule
