module i2c_master_fsm (
    input wire clk,
    input wire reset,
    input wire start_transfer,
    input wire rw_flag,        // 0 = Write, 1 = Read
    input wire ack_in,         // Acknowledgment from slave
    output reg gen_start,
    output reg gen_stop,
    output reg tx_enable,
    output reg rx_enable,
    output wire [2:0] current_state
);
    localparam IDLE      = 3'b000;
    localparam START     = 3'b001;
    localparam ADDRESS   = 3'b010;
    localparam ACK_ADDR  = 3'b011;
    localparam DATA      = 3'b100;
    localparam ACK_DATA  = 3'b101;
    localparam STOP      = 3'b110;

    reg [2:0] state, next_state;
    reg [3:0] bit_count;

    assign current_state = state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 4'd0;
        end else begin
            state <= next_state;
            
            
            if (state == ADDRESS || state == DATA)
                bit_count <= bit_count + 1'b1;
            else
                bit_count <= 4'd0;
        end
    end

  
    always @(*) begin
       
        next_state = state;
        gen_start  = 1'b0;
        gen_stop   = 1'b0;
        tx_enable  = 1'b0;
        rx_enable  = 1'b0;

        case (state)
            IDLE: begin
                if (start_transfer) begin
                    gen_start = 1'b1;
                    next_state = START;
                end
            end
            
            START: begin
                next_state = ADDRESS;
            end
            
            ADDRESS: begin
                tx_enable = 1'b1;
                if (bit_count == 4'd7)
                    next_state = ACK_ADDR;
            end
            
            ACK_ADDR: begin
                next_state = DATA; 
            end
            
            DATA: begin
              
                if (rw_flag == 1'b0)
                    tx_enable = 1'b1;
                else
                    rx_enable = 1'b1;
                    
                if (bit_count == 4'd7)
                    next_state = ACK_DATA;
            end
            
            ACK_DATA: begin
                next_state = STOP;
            end
            
            STOP: begin
                gen_stop = 1'b1;
                next_state = IDLE;
            end
            
            default: next_state = IDLE;
        endcase
    end
endmodule
