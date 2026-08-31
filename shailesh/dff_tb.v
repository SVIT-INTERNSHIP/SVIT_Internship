module dff_tb;
reg D, CLK;
wire Q;
dff uut (
    .D(D),
    .CLK(CLK),
    .Q(Q)
);

always #5 CLK = ~CLK;

initial begin
    $dumpfile("dff.vcd");
    $dumpvars(0, dff_tb);

    CLK = 0;
    D = 0;

    #10 D = 1;
    #10 D = 0;
    #10 D = 1;
    #10 D = 0;
    #10 $finish;
end
endmodule

