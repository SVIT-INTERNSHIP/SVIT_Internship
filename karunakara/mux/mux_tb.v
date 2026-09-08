module mux8to1_tb;
reg[7:0] I;
reg[2:0] S;
wire Y;
mux8to1 uut(.I(I), .S(S), .Y(Y));
initial begin
 
	$dumpfile("mux8to1.vcd");
	$dumpvars(0,mux8to1_tb);
	I=8'b10101010;
	S=3'b000;
	#10;
	S=3'b001;
	#10;
	S=3'b010;
	#10;
        S=3'b011;
        #10;
        S=3'b100;
	#10;
        S=3'b101;
        #10;
        S=3'b110;
	#10;
        S=3'b111;
        #10;
        $finish;
end
endmodule






