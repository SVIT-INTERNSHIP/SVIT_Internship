module vga_vsync (
	input wire clk,
	input wire reset,
	input wire h_sync_tick,
	output reg v_sync,
	output reg [9:0] v_count,
	output reg v_active
);
	localparam V_ACTIVE = 480;
	localparam V_FRONT_PORCH  = 10;
	localparam V_SYNC_PULSE = 2;
	localparam V_BACK_PORCH = 33;
	localparam V_TOTAL = V_ACTIVE + V_FRONT_PORCH + V_SYNC_PULSE + V_BACK_PORCH;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			v_count <= 10'd0;
		end
		else if (h_sync_tick) begin
			if (v_count == V_TOTAL - 1)
				v_count <= 10'd0;
			else 
				v_count <= v_count + 1'b1;
		end
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			v_sync <= 1'b1;
			v_active <= 1'b0;
		end 
		else begin
			v_active <= (v_count < V_ACTIVE);

			if ((v_count >= (V_ACTIVE + V_FRONT_PORCH) && v_count < (V_ACTIVE +
			V_FRONT_PORCH + V_SYNC_PULSE))) begin
 
				v_sync <= 1'b0;
			end 
			else begin
				v_sync <= 1'b1;
			end
		end
	end
endmodule


			

	
