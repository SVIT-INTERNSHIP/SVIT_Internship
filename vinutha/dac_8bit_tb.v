module dac_8bit_tb;
reg [7:0]d; wire [7:0]a;
dac_8bit uut(d,a);
initial begin $dumpfile("wave.vcd");$dumpvars(0,dac_8bit_tb);
end
initial begin d=0;#10;d=64;#10;d=128;#10;d=255;#10;
$finish;end
endmodule
