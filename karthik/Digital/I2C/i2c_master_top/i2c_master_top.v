module i2c_master_top #(
    parameter CLK_DIV = 4   // Number of clk cycles per SCL half-period
)(
    input  wire       clk,         
    input  wire       rst_n,       // Active-low reset (Bharadwaj/Karunakara style)
    input  wire       start_i,     
    input  wire [6:0] slave_addr,  
    input  wire       rw,          // 0 = write, 1 = read
    input  wire [7:0] tx_data,     // NEW: 8-bit payload to transmit (Fixes Laxmi's missing TX)
    
    output reg        scl,         
    inout  wire       sda,         // Single wire, open-drain
    output reg  [7:0] rx_data,     // 8-bit payload received (Bharadwaj's RX)
    output reg        busy,        
    output reg        done         
);

    // Karthik's 7-State Architecture
    localparam IDLE      = 3'd0,
               START     = 3'd1,
               ADDRESS   = 3'd2,
               ACK_ADDR  = 3'd3,
               DATA      = 3'd4,
               ACK_DATA  = 3'd5,
               STOP      = 3'd6;

    reg [2:0] state;
    reg [3:0] bit_idx;      
    reg [7:0] shift_reg;    
    reg       sda_out;      
    reg       sda_oe;       
    integer   half_cnt;     

    // Karunakara's Open-Drain SDA Control
    assign sda = sda_oe ? sda_out : 1'bz;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state     <= IDLE;
            scl       <= 1'b1;
            sda_out   <= 1'b1;
            sda_oe    <= 1'b1;
            half_cnt  <= 0;
            bit_idx   <= 4'd0;
            shift_reg <= 8'h00;
            rx_data   <= 8'h00;
            busy      <= 1'b0;
            done      <= 1'b0;
        end else begin
            done <= 1'b0; 

            case (state)
                // ---------------------------------------------------
                IDLE: begin
                    scl      <= 1'b1;
                    sda_out  <= 1'b1;
                    sda_oe   <= 1'b1;
                    half_cnt <= 0;
                    if (start_i) begin
                        busy      <= 1'b1;
                        shift_reg <= {slave_addr, rw}; // Load Address
                        bit_idx   <= 4'd7;
                        state     <= START;
                    end
                end

                // ---------------------------------------------------
                START: begin
                    if (half_cnt == 0) sda_out <= 1'b0;
                    if (half_cnt == CLK_DIV-1) begin
                        half_cnt <= 0;
                        scl      <= 1'b0;   
                        state    <= ADDRESS;
                    end else half_cnt <= half_cnt + 1;
                end

                // ---------------------------------------------------
                ADDRESS: begin
                    if (half_cnt == 0) begin
                        sda_out <= shift_reg[bit_idx];
                        scl     <= 1'b0;
                    end
                    if (half_cnt == CLK_DIV) scl <= 1'b1;

                    if (half_cnt == 2*CLK_DIV-1) begin
                        half_cnt <= 0;
                        if (bit_idx == 0) state <= ACK_ADDR;
                        else bit_idx <= bit_idx - 1'b1;
                    end else half_cnt <= half_cnt + 1;
                end

                // ---------------------------------------------------
                ACK_ADDR: begin
                    if (half_cnt == 0) begin
                        sda_oe <= 1'b0; // Release SDA for slave ACK
                        scl    <= 1'b0;
                    end
                    if (half_cnt == CLK_DIV) scl <= 1'b1;

                    if (half_cnt == 2*CLK_DIV-1) begin
                        half_cnt <= 0;
                        // PREPARE FOR DATA STATE
                        if (rw == 1'b0) begin
                            sda_oe <= 1'b1;       // Master drives TX
                            shift_reg <= tx_data; // Load payload!
                        end else begin
                            sda_oe <= 1'b0;       // Master receives RX
                        end
                        bit_idx <= 4'd7;
                        scl     <= 1'b0;
                        state   <= DATA;
                    end else half_cnt <= half_cnt + 1;
                end

                // ---------------------------------------------------
                DATA: begin
                    if (half_cnt == 0) begin
                        if (rw == 1'b0) sda_out <= shift_reg[bit_idx]; // TX mode
                        scl <= 1'b0;
                    end
                    
                    if (half_cnt == CLK_DIV) begin
                        scl <= 1'b1;
                        if (rw == 1'b1) rx_data[bit_idx] <= sda; // Bharadwaj's RX capture
                    end

                    if (half_cnt == 2*CLK_DIV-1) begin
                        half_cnt <= 0;
                        if (bit_idx == 0) state <= ACK_DATA;
                        else bit_idx <= bit_idx - 1'b1;
                    end else half_cnt <= half_cnt + 1;
                end

                // ---------------------------------------------------
                ACK_DATA: begin
                    if (half_cnt == 0) begin
                        if (rw == 1'b0) sda_oe <= 1'b0; // Write: wait for Slave ACK
                        else begin
                            sda_oe <= 1'b1; // Read: Master sends ACK/NACK
                            sda_out <= 1'b1; // NACK to end read cycle
                        end
                        scl <= 1'b0;
                    end
                    if (half_cnt == CLK_DIV) scl <= 1'b1;

                    if (half_cnt == 2*CLK_DIV-1) begin
                        half_cnt <= 0;
                        sda_oe   <= 1'b1;   
                        sda_out  <= 1'b0;   
                        scl      <= 1'b0;
                        state    <= STOP;
                    end else half_cnt <= half_cnt + 1;
                end

                // ---------------------------------------------------
                STOP: begin
                    if (half_cnt == 0) begin
                        sda_out <= 1'b0;
                        scl     <= 1'b0;
                    end
                    if (half_cnt == CLK_DIV) scl <= 1'b1; 
                    if (half_cnt == CLK_DIV + CLK_DIV/2) sda_out <= 1'b1; // SDA rises -> STOP

                    if (half_cnt == 2*CLK_DIV-1) begin
                        half_cnt <= 0;
                        busy  <= 1'b0;
                        done  <= 1'b1;
                        state <= IDLE;
                    end else half_cnt <= half_cnt + 1;
                end

                default: state <= IDLE;
            endcase
        end
    end
endmodule
