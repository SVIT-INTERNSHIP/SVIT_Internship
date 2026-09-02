module full_adder_4bit_tb;
        reg [3:0] a, b;
        reg cin;
        wire [3:0] sum;
        wire cout;
        full_adder_4bit DUT (
                .a(a),
                .b(b),
                .cin(cin),
                .sum(sum),
                .cout(cout)
        );
        initial begin
                $dumpfile("full_adder_4bit.vcd");
                $dumpvars(0, full_adder_4bit_tb);
                cin = 0;
                a = 4'b0000; b = 4'b0000; #10;
                a = 4'b0001; b = 4'b0001; #10;
                a = 4'b0101; b = 4'b0011; #10;
                a = 4'b1111; b = 4'b0001; #10;
                a = 4'b1010; b = 4'b0101; #10;
                a = 4'b1111; b = 4'b1111; #10;
                cin = 1;
                a = 4'b0000; b = 4'b0000; #10;
                a = 4'b1111; b = 4'b1111; #10;
                $finish;
        end
        initial begin
                $monitor("Time=%0t | a=%b b=%b cin=%b -> sum=%b cout=%b", $time, a, b, cin, sum, cout);
        end
endmodule
