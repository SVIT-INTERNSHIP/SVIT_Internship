module half_adder (
        input a,
        input b,
        output sum,
        output carry
);
        assign sum = a ^ b;
        assign carry = a & b;
endmodule

module full_adder (
        input a,
        input b,
        input cin,
        output sum,
        output cout
);
        wire s1, c1, c2;
        half_adder HA1 (.a(a), .b(b), .sum(s1), .carry(c1));
        half_adder HA2 (.a(s1), .b(cin), .sum(sum), .carry(c2));
        assign cout = c1 | c2;
endmodule

module full_adder_4bit (
        input [3:0] a,
        input [3:0] b,
        input cin,
        output [3:0] sum,
        output cout
);
        wire c1, c2, c3;
        full_adder FA0 (.a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .cout(c1));
        full_adder FA1 (.a(a[1]), .b(b[1]), .cin(c1), .sum(sum[1]), .cout(c2));
        full_adder FA2 (.a(a[2]), .b(b[2]), .cin(c2), .sum(sum[2]), .cout(c3));
        full_adder FA3 (.a(a[3]), .b(b[3]), .cin(c3), .sum(sum[3]), .cout(cout));
endmodule

