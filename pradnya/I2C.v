module i2c_tx(
input reset,
input start,
input scl,
input[7:0] data,
output reg sda
);

reg[7:0] tx_reg;
reg[3:0] count;

always @(negedge scl or posedge reset)
begin
if(reset) begin
tx_reg<=8'b0;
count<=0;
sda <=1'b1;
end

else if(start) 
begin
tx_reg<=data;
count<=1;
sda<=data[7];
end

else if(count<8) 
begin
sda<=tx_reg[6];
tx_reg<={tx_reg[6:0],1'b0};
count<=count+1;

end
else
begin
sda<=1'b1;
end
end
endmodule

