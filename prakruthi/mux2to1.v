module mux2is1(input d0,d1, input s, output y);
	assign y = s ? d1:d0;
endmodule

