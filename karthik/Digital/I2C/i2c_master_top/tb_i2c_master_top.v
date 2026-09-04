`timescale 1ns/1ps

module tb_i2c_master_top;

    localparam CLK_DIV = 4;

    reg         clk;
    reg         rst_n;
    reg         start_i;
    reg  [6:0]  slave_addr;
    reg         rw;
    reg  [7:0]  tx_data;      // NEW: Drive the payload
    wire [7:0]  rx_data;      // NEW: Monitor received data
    wire        scl;
    wire        sda;
    wire        busy;
    wire        done;

    reg slave_ack_drive;
    assign sda = slave_ack_drive ? 1'b0 : 1'bz;
    pullup (sda);   // Models the external pull-up resistor on the bus

    // Instantiate your Unified Top Module
    i2c_master_top #(.CLK_DIV(CLK_DIV)) DUT (
        .clk        (clk),
        .rst_n      (rst_n),
        .start_i    (start_i),
        .slave_addr (slave_addr),
        .rw         (rw),
        .tx_data    (tx_data),
        .rx_data    (rx_data),
        .scl        (scl),
        .sda        (sda),
        .busy       (busy),
        .done       (done)
    );

    always #5 clk = ~clk;

    // Slave ACK Logic for Simulation
    integer bitcnt;
    reg start_seen;
    
    always @(negedge sda)
        if (scl) start_seen = 1'b1;

    always @(posedge scl) begin
        if (start_seen) bitcnt = bitcnt + 1;
    end

    // Slave drives ACK on the 9th bit (Address ACK) and 18th bit (Data ACK)
    always @(negedge scl) begin
        if (bitcnt == 8 || bitcnt == 17) begin
            slave_ack_drive <= 1'b1; // Slave pulls SDA low to ACK
        end else begin
            slave_ack_drive <= 1'b0; // Slave releases SDA
        end
    end

    initial begin
        $dumpfile("i2c_top.vcd");
        $dumpvars(0, tb_i2c_master_top);

        // Initialize
        clk        = 1'b0;
        rst_n      = 1'b0;
        start_i    = 1'b0;
        slave_addr = 7'h55; 
        rw         = 1'b0;    // Write Mode
        tx_data    = 8'hAA;   // Let's send the alternating bit pattern 10101010
        slave_ack_drive = 1'b0;
        bitcnt     = 0;
        start_seen = 1'b0;

        // Reset Sequence
        #20  rst_n   = 1'b1;
        #20  
        
        // Trigger the Transaction
        $display("[%0t ns] Triggering Top-Level Write Transaction...", $time);
        start_i = 1'b1;
        #10  start_i = 1'b0;
        
        // Wait for the 'done' signal from the FSM
        @(posedge done);
        $display("[%0t ns] Transaction Complete! Check GTKWave for the SDA payload.", $time);
        
        #200;
        $finish;
    end

endmodule
