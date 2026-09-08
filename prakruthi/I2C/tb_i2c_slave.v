module tb_i2c_slave;
    reg clk;
    reg reset;
    reg [6:0] received_addr;
    reg check_addr_flag;
    wire ack_bit;

    // Connect the testbench to your module
    i2c_slave_address_matcher uut (
        .clk(clk),
        .reset(reset),
        .received_addr(received_addr),
        .check_addr_flag(check_addr_flag),
        .ack_bit(ack_bit)
    );

    // Generate a clock signal
    always #5 clk = ~clk;

    initial begin
        // Setup GTKWave files
        $dumpfile("i2c_dump.vcd");
        $dumpvars(0, tb_i2c_slave);

        // Initial state
        clk = 0;
        reset = 1;
        check_addr_flag = 0;
        received_addr = 7'b0000000;
        
        #10 reset = 0; // Turn off reset
        
        // Test 1: Send the WRONG address (e.g., 1111111)
        #10;
        received_addr = 7'b1111111;
        check_addr_flag = 1; 
        #10 check_addr_flag = 0; // ACK should remain 0

        // Test 2: Send the CORRECT address (1010101)
        #20;
        received_addr = 7'b1010101;
        check_addr_flag = 1;
        #10 check_addr_flag = 0; // ACK should jump to 1

        #20 $finish;
    end
endmodule
