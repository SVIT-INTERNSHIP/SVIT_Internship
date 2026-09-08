module vga_vsync_tb;
	reg clk, reset, h_sync_tick;
	wire v_sync, v_active;
	wire [9:0] v_count;
	reg prev_active, prev_sync;
       
	vga_vsync DUT (
		.clk(clk), 
		.reset(reset), 
		.h_sync_tick(h_sync_tick), 
		.v_sync(v_sync), 
		.v_count(v_count), 
		.v_active(v_active)
	);
	initial begin
		clk = 0;
		forever #10 clk = ~clk;
	end

	initial begin
		h_sync_tick = 0;
		forever begin
			#(20*40);
			h_sync_tick = 1;
			#40;
			h_sync_tick = 0;
		end
	end
	initial begin
		$dumpfile("vga_vsyn_tb.vcd");
		$dumpvars(0, vga_vsync_tb);
	end
	initial begin
		prev_active = 0;
		prev_sync = 1;
		
		reset = 1;
		repeat (5) @(posedge clk);
		reset = 0;
		repeat (11000) @(posedge clk);
		$display("Simulation finished at time %0t", $time);
		$finish;
	end
	
	always @(posedge clk) begin
		if (v_active !== prev_active || v_sync !== prev_sync) begin
			$display("time=%0t v_count=%0d v_active=%b v_sync=%b", $time, v_count, v_active, v_sync);
			prev_active <= v_active;
			prev_sync <= v_sync;
		end
	end
endmodule



