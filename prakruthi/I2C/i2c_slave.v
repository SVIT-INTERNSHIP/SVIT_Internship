module i2c_slave_address_matcher (
    input clk,
    input reset,
    input [6:0] received_addr,
    input check_addr_flag,
    output reg ack_bit
);
    reg [6:0] my_slave_address;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            my_slave_address <= 7'b1010101;
            ack_bit <= 0;
        end else begin
            if (check_addr_flag == 1) begin
                if (received_addr == my_slave_address) begin
                    ack_bit <= 1;
                end else begin
                    ack_bit <= 0;
                end
            end else begin
                ack_bit <= 0;
            end
        end
    end
endmodule
