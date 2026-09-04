module tb_i2c_slave_top;
    reg clk;
    reg reset;
    
    // Signals for Address Matcher
    reg [6:0] i2c_address_in;
    reg check_addr_flag;
    wire slave_ack;
    
    // Signals for FIFO
    reg [7:0] i2c_data_in;
    reg write_data_flag;
    reg read_data_flag;
    wire [7:0] fifo_data_out;
    wire fifo_empty;
    wire fifo_full;

    // Plug in the Master IP
    i2c_slave_top uut (
        .clk(clk),
        .reset(reset),
        .i2c_address_in(i2c_address_in),
        .check_addr_flag(check_addr_flag),
        .i2c_data_in(i2c_data_in),
        .write_data_flag(write_data_flag),
        .read_data_flag(read_data_flag),
        .slave_ack(slave_ack),
        .fifo_data_out(fifo_data_out),
        .fifo_empty(fifo_empty),
        .fifo_full(fifo_full)
    );

    // Generate System Clock
    always #5 clk = ~clk;

    initial begin
        $dumpfile("top_dump.vcd");
        $dumpvars(0, tb_i2c_slave_top);

        // Initialize all signals
        clk = 0; reset = 1;
        i2c_address_in = 0; check_addr_flag = 0;
        i2c_data_in = 0; write_data_flag = 0; read_data_flag = 0;
        #10 reset = 0;

        // 1. Test the Address Matcher (Trigger ACK)
        #10 i2c_address_in = 7'b1010101; check_addr_flag = 1; 
        #10 check_addr_flag = 0;

        // 2. Test the FIFO Write (Load data 10101010)
        #10 i2c_data_in = 8'hAA; write_data_flag = 1; 
        #10 write_data_flag = 0;

        // 3. Test the FIFO Read (Extract data)
        #10 read_data_flag = 1;
        #10 read_data_flag = 0;

        #20 $finish;
    end
endmodule
