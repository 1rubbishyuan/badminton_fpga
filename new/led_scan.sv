// LEDµÆÄ£¿é£¬×Ô´ø

`timescale 1ns/1ps
module led_scan #(
    parameter SCAN_INTERVAL = 100_000
)(
    input wire clk,
    input wire [31: 0] leds,  // 32-bit led to display

    output wire [7: 0] led_bit,   // output to circuit
    output wire [3: 0] led_com    // output to circuit
);

    reg [1:0] scan_part;

    // scan current part
    reg [31:0] counter;
    always_ff @ (posedge clk) begin
        counter <= counter + 32'b1;
        if (counter == SCAN_INTERVAL) begin
            counter <= 32'd0;
            scan_part <= scan_part + 2'd1;
        end
    end

    assign led_bit = leds[8 * scan_part +: 8];
    assign led_com = 1'b1 << scan_part;
endmodule
