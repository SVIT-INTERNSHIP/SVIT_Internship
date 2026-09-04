module fulladder(A,B,Cin,sum,Cout);
input A,B,Cin;
output sum,Cout;
assign sum=A^B^Cin;
assign Cout=(A&B)|(B&Cin)|(A&Cin);
endmodule

module tb_fulladder;
reg A,B,Cin;
wire sum,Cout;
fulladder FA(A,B,Cin,sum,Cout);
initial
begin
   A=0;B=0;Cin=0;
#10A=0,B=0;Cin=1;
#10A=0;B=1;Cin=0;
#10A=0;B=1;Cin=1;
#10A=1;B=0;Cin=0;
#10A=1;B=0;Cin=1;
#10A=1;B=1;Cin=0;
#10A=1;B=1;Cin=1;
#10 $finish;
end

initial
begin
   $monitor("A&%b B=%b Cin=%b sum=%b Cout=%b",A,B,Cin,sum,Cout);
end
endmodule

