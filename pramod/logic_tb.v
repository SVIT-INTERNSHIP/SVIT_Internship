module logic_unit_tb;
reg A, B;
reg [1:0] SEL;
wire Y;
logic_unit DUT(A, B,SEL, Y);
initial begin
    $dumpfile("logic_wave.vcd");
    $dumpvars(0, logic_unit_tb);
    A=0; B=1; SEL=2'b00; #10;
    A=1; B=0; SEL=2'b01; #10;
    A=1; B=1; SEL=2'b10; #10;
    A=1; B=1; SEL=2'b11; #10;
    $finish;
end
endmodule


