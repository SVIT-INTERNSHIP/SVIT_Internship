module tb_memory_16x32;

reg clk;
reg reset;
reg we;
reg[4:0]address;
reg[15:0]data_in;
wire[15:0]data_out;

memory_16x32 m(
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

$dumpfile("memory_16x32.vcd");
$dumpvars(0, tb_memory_16x32);

clk=0;
reset=1;
we=0;
address=5'd0;
data_in=16'h0000;
#10;
reset=0;

#10;
we=1;
address=5'd1;
data_in=16'hABCD;

#10;
address=5'd2;
data_in=16'h5678;

#10;
we=0;
address=5'd1;

#10;
address=5'd2;

#10;
$finish;

end

initial
begin

$monitor("Time=%0t WE=%b Address=%d Data_in=%h Data_out=%h",
$time,we,address,data_in,data_out);
end
endmodule
