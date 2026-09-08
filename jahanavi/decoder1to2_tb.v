module tb_decoder_1to2;

reg A, EN;
wire Y0, Y1;

decoder_1to2 uut(A, EN, Y0, Y1);

initial begin
$dumpfile("decoder1to2.vcd");
$dumpvars(0, tb_decoder_1to2);
EN =0; A =0; #10;
EN =1; A =0; #10;
EN =1; A= 1; #10;
$finish;

end 
endmodule
