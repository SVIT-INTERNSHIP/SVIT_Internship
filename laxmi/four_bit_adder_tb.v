module four_bit_adder_tb;
reg[3:0]a,b;
reg cin;
wire[3:0]sum;
wire cout;
four_bit_adder uut(a,b,cin,sum,cout);
initial
begin
$dumpfile("four_bit_adder.vcd");
$dumpvars(0,four_bit_adder_tb);

a=4'b0000;b=4'b0000;cin=0;
#10 a=4'b0001;b=4'b0010;cin=0;
#10 a=4'b0011;b=4'b0011;cin=0;
#10 a=4'b0101;b=4'b0010;cin=0;
#10 a=4'b0111;b=4'b0001;cin=0;
#10 a=4'b1001;b=4'b0110;cin=0;
#10 a=4'b1111;b=4'b0001;cin=0;
#10 a=4'b1111;b=4'b1111;cin=0;
#10 $finish;
end
endmodule

