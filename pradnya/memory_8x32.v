
module memory_7x32(
input clk,
input reset,
input we,
input [4:0]address,
input[7:0] data_in,
output reg[7:0] data_out
);

reg[7:0]memory[0:31];

integer i;

always@(posedge clk or posedge reset)
begin
if(reset)
begin
data_out<=8'h00;
for(i=0; i<32; i=i+1)

memory[i]<=8'h00;
end
else 
begin
if(we)
memory[address]<=data_in;
else
data_out<=memory[address];
end
end
endmodule



