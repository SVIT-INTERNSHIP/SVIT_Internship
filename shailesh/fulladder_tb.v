module fulladder_tb;
	reg a, b, cin;
	wire sum, cout;

	fulladder uut (
		.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

	integer i;
	initial begin
		$dumpfile("fulladder_tb.vcd");
		$dumpvars(0, fulladder_tb);
		$display("a b cin | sum cout");
		$display("-----------------------");
		for (i = 0; i < 8; i = i + 1) begin
			{a, b, cin} = i[2:0];
			#10;
			$display(" %b %b %b | %b %b", a, b, cin, sum, cout);
		end
		$finish;
	end
endmodule
