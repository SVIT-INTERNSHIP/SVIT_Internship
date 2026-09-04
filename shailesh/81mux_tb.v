module mux81_tb;
reg I0, I1, I2, I3, I4, I5, I6, I7;
reg [2:0] S;
wire Y;
integer k;
mux81 uut (
    .I0(I0), .I1(I1), .I2(I2), .I3(I3),
    .I4(I4), .I5(I5), .I6(I6), .I7(I7),
    .S(S),
    .Y(Y)
);

initial begin
    $dumpfile("81mux.vcd");
    $dumpvars(0, mux81_tb);
    $monitor("Time=%0t | S=%b | I7I6I5I4I3I2I1I0=%b%b%b%b%b%b%b%b | Y=%b", $time, S, I7, I6, I5, I4, I3, I2, I1, I0, Y);
    for (k =0; k < 8; k = k + 1) begin
        {I7,I6,I5,I4,I3,I2,I1,I0} = 8'b0;
        case (k)
            0: I0 = 1;
            1: I1 = 1;
            2: I2 = 1;
            3: I3 = 1;
            4: I4 = 1;
            5: I5 = 1;
            6: I6 = 1;
            7: I7 = 1;
        endcase
        S = k; #10;
    end
    $finish;
end
endmodule
    
