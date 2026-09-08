module i2c_slave_top (
    input wire clk,
    input wire reset,

    // --- Signals for Your Address Matcher ---
    input wire [6:0] i2c_address_in,
    input wire check_addr_flag,
    output wire slave_ack,

    // --- Signals for Nisarga's FIFO ---
    input wire [7:0] i2c_data_in,
    input wire write_data_flag,
    input wire read_data_flag,
    output wire [7:0] fifo_data_out,
    output wire fifo_empty,
    output wire fifo_full
);

    // 1. Instantiate Your Address Matcher
    i2c_slave_address_matcher u_address_matcher (
        .clk(clk),
        .reset(reset),
        .received_addr(i2c_address_in),
        .check_addr_flag(check_addr_flag),
        .ack_bit(slave_ack)
    );

    // 2. Instantiate Nisarga's FIFO
    fifo u_data_fifo (
        .clk(clk),
        .reset(reset),
        .write_en(write_data_flag),
        .read_en(read_data_flag),
        .data_in(i2c_data_in),
        .data_out(fifo_data_out),
        .empty(fifo_empty),
        .full(fifo_full)
    );

endmodule
