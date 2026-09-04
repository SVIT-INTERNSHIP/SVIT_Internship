`timescale 1ns / 1ps

module tb_i2c_master_fsm;

    // Inputs
    reg clk;
    reg reset;
    reg start_transfer;
    reg rw_flag;
    reg ack_in;

    // Outputs
    wire gen_start;
    wire gen_stop;
    wire tx_enable;
    wire rx_enable;
    wire [2:0] current_state;

    i2c_master_fsm uut (
        .clk(clk),
        .reset(reset),
        .start_transfer(start_transfer),
        .rw_flag(rw_flag),
        .ack_in(ack_in),
        .gen_start(gen_start),
        .gen_stop(gen_stop),
        .tx_enable(tx_enable),
        .rx_enable(rx_enable),
        .current_state(current_state)
    );

    always #5 clk = ~clk;

    initial begin
        
        $dumpfile("i2c_fsm.vcd");
        $dumpvars(0, tb_i2c_master_fsm);

        
        clk = 0;
        reset = 1;
        start_transfer = 0;
        rw_flag = 0;
        ack_in = 0;

        #20;
        reset = 0;
        #10;

        // case 1: I2C Write
        $display("\n--- Starting I2C WRITE Transaction ---");
        rw_flag = 0;
        start_transfer = 1;
        #10;
        start_transfer = 0;

        #200; 
        // case 2: I2C Read
        $display("\n--- Starting I2C READ Transaction ---");
        rw_flag = 1;           // 1 means Read
        start_transfer = 1;    // Trigger the FSM
        #10;
        start_transfer = 0;

        // Wait for clock cycle to finish
        #200;

        $display("\nSimulation Complete.");
        $finish;
    end

    // Print State Changes to the Terminal
    always @(current_state) begin
        case(current_state)
            3'b000: $display("Time: %0t | State: IDLE", $time);
            3'b001: $display("Time: %0t | State: START", $time);
            3'b010: $display("Time: %0t | State: ADDRESS", $time);
            3'b011: $display("Time: %0t | State: ACK_ADDR", $time);
            3'b100: $display("Time: %0t | State: DATA", $time);
            3'b101: $display("Time: %0t | State: ACK_DATA", $time);
            3'b110: $display("Time: %0t | State: STOP", $time);
        endcase
    end

endmodule
