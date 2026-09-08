module logic_unit(input A,input B,input[1:0] SEL,output reg Y);
always @(*) begin
	case(SEL)
		2'b00: Y=A&B;
		2'b01: Y=A|B;
		2'b10: Y=A^B;
		2'b11: Y=~(A&B);
		default: Y=1'b0;
	endcase
end
endmodule
