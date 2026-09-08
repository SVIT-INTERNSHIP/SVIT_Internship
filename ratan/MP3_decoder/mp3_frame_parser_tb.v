`timescale 1ns/1ps
module mp3_frame_parser_tb;
	reg clk;
	reg reset;
	reg data_valid;
	reg data_bit;
	wire farme_start;
	wire header_valid;
	wire main_data_valid;
	wire frame_done;
	wire [31:0] header_data;
	wire [15:0] main_data;
	mp3_frame_parser DUT (.clk(clk), .reset(reset), .data_valid(data_valid), .data_bit(data_bit), .frame_start(frame_start), .header_valid(header_valid), .main_data_valid(maain_data_valid), .frame_done(frame_done), .header_data(header_data), .main_data(main_data));
	always #5 clk=~clk;
	task send_bit;
		input bit_value;
		begin
			@(negedge clk);
			data_valid=1'b1;
			data_bit=bit_value;
			@(negedge clk);
			data_valid=1'b0;
		end
	endtask
	reg [31:0] test_header;
	reg [15:0] test_main_data;
	integer i;
	initial begin
		$dumpfile("frame_parser.vcd");
		$dumpvars(0,mp3_frame_parser_tb);
		clk=1'b0;
		reset=1'b1;
		data_valid=1'b0;
		data_bit=1'b0;
		test_header=32'b10101010101010101010101010101010;
		test_main_data=16'b1100110011001100;
		#20;
		reset=0;
		$display("Sending SYNC.....");
		for (i=0;i<8;i=i+1) begin
			send_bit(1'b1);
		end
		$display("Sending HEADER....");
		for (i=31;i>=0;i=i-1) begin
                        send_bit(test_header[i]);
		end
		$display("Sending MAIN DATA...");
		for (i=15;i>=0;i=i-1) begin
                        send_bit(test_main_data[i]);
		end
		#50;
		$display("");
		$display("===============================");
		$display("           MP3 FRAME PARSER TEST");
		$display("===============================");
		$display("Expected Header:");
		$display("10101010101010101010101010101010");
		$display("Received Header:");
		$display("%b",header_data);
		$display("");
		$display("Expected Main Data:");
		$display("1100110011001100");
		$display("Received Main Data:");
		$display("%b",main_data);
		$display("");
		if (header_data==test_header)
			$display("HEADER TEST=PASS");
		else
			$display("HEADER TEST=FAIL");
		if (main_data==test_main_data)
			$display("MAIN DATA TEST=PASS");
		else
			$display("MAIN DATA TEST=FAIL");
		$display("");
		$display("Simulation completed.");
		$display("================================");
		$finish;
	end
endmodule

