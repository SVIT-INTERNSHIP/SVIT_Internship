module half_adder(input a,input b,output sum,output carry);
assign sum=a^b;
assign carry=a&b;
endmodule

module full_adder(input a,input b,input cin,output sum,output cout);
wire s1,c1,c2;

half_adder ha1(a,b,s1,c1);
half_adder ha2(s1,cin,sum,c2);
assign cout=c1|c2;
endmodule

module four_bit_adder(input [3:0]a,input[3:0]b,input cin,output [3:0]sum,
output cout);
wire c1,c2,c3;
full_adder fa0(a[0],b[0],cin,sum[0],c1);
full_adder fa1(a[1],b[1],c1,sum[1],c2);
full_adder fa2(a[2],b[2],c2,sum[2],c3);
full_adder fa3(a[3],b[3],c3,sum[3],cout);
endmodule
