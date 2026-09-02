module half_adder(input a,input b,output sum,output carry);
xor(sum,a,b);
and(carry,a,b);
endmodule

module full_adder(input a,input b,input cin,output sum,output cout);
wire s1,c1,c2;
half_adder ha1(a,b,s1,c1);
half_adder ha2(s1,cin,sum,c2);
assign cout=c1|c2;
endmodule 
