`timescale 1ns/1ps

module tb_mp3_sideinfo;

reg clk,reset,start;
reg [31:0] header;
reg [255:0] side_info;

wire done,error;
wire [8:0] main_data_begin;
wire [2:0] private_bits;
wire [7:0]scfsi;

wire [11:0] part23_0,part23_1,part23_2,part23_3;
wire [8:0] big_0,big_1,big_2,big_3;
wire [7:0] gain_0,gain_1,gain_2,gain_3;
wire  win_0,win_1,win_2,win_3;

mp3_sideinfo dut(
.clk(clk),
.reset(reset),
.start(start),
.header(header),
.side_info(side_info),
.done(done),
.error(error),
.main_data_begin(main_data_begin),
.private_bits(private_bits),
.scfsi(scfsi),
.part23_0(part23_0),
.part23_1(part23_1),
.part23_2(part23_2),
.part23_3(part23_3),
.big_0(big_0),
.big_1(big_1),
.big_2(big_2),
.big_3(big_3),
.gain_0(gain_0),
.gain_1(gain_1),
.gain_2(gain_2),
.gain_3(gain_3),
.win_0(win_0),
.win_1(win_1),
.win_2(win_2),
.win_3(win_3)
);

always #5 clk=~clk;

initial begin

clk=0;
reset=1;
start=0;
header=32'hFFFFB900;
side_info=256'h0;

side_info[255:247]=9'h055;
side_info[246:244]=3'b101;
side_info[243:236]=8'hAC;


$dumpfile("mp3.vcd");
$dumpvars(0,tb_mp3_sideinfo);

#20 reset=0;
#10 start=1;
#10 start=0;



side_info=256'b0;

side_info[255:247]=9'h055;
side_info[246:244]=3'b101;
side_info[243:236]=8'hAC;

side_info[235:224]=12'h123;
side_info[223:215]=9'h055;
side_info[221:214]=8'hA0;
side_info[142]=1'b0;

side_info[117:106]=12'h234;
side_info[105:97]=9'h066;
side_info[96:89]=8'hA1;
side_info[142]=1'b1;

side_info[117:106]=12'h345;
side_info[105:97]=9'h077;
side_info[96:89]=8'hA2;
side_info[83]=1'b0;

side_info[58:47]=12'h456;
side_info[46:38]=9'h088;
side_info[37:30]=8'hA3;
side_info[24]=1'b1;

#20 reset=0;
#10 start=1;
#10 start=0;

wait(done);

$display("");
$display("=================================================");
$display("mp3 side information decoder");
$display("=================================================");

if(error==0)
$display("header status:valid");
else
$display("header status:error");

$display("");
$display("general side info");
$display("main_data_begin=%h",main_data_begin);
$display("private_bits   =%b",private_bits);
$display("scfsi          =%b",scfsi);

$display("");
$display("granule/channel results");

$display("g0c0:part23=%h big=%h gain=%h win=%b",
         part23_0,big_0,gain_0,win_0);

$display("g0c1:part23=%h big=%h gain=%h win=%b",
         part23_1,big_1,gain_1,win_1);

$display("g1c0:part23=%h big=%h gain=%h win=%b",
         part23_2,big_2,gain_2,win_2);

$display("g1c1:part23=%h big=%h gain=%h win=%b",
         part23_3,big_3,gain_3,win_3);

$display("");
if(error==0&&done)
$display("********mp3 decoder:pass*****");
else
$display("********mp3 decoder:fail*****");

$display("==============================");

$finish;

end

endmodule






