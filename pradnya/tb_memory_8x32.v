module tb_memory_8x32;

reg clk;
reg reset;
reg we;
reg[4:0]address;
reg[7:0] data_in;
wire[7:0] data_out;

memory_8x32 m(
.clk(clk),
.reset(reset),
.we(we),
.address(address),
.data_in(data_in),
.data_out(data_out)
);

always #5 clk=~clk;

initial
begin
$dumpfile("memory_8x32.vcd");
$dumpvars(0, tb_memory_8x32);


clk=0;
reset=1;
we=0;
address=0;
data_in=0;

#10
reset=0;

#2;
we=1;
address=5'd5;
data_in=8'h55;

#10;
address=5'd17;
data_in=8'hAA;

#10;
we=0;
address=5'd5;
#10;
address=5'd17;
#10;
$finish;

end

initial
begin
$monitor("Time=%0t WE=%b Address=%d Data_in=%h Data_out=%h", $time, we, 
address, data_in, data_out);
end

endmodule
