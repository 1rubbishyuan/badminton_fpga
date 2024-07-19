// 数码管模块，自带

`timescale 1ns/1ps
module dpy_decode (
    input wire [3:0] x,
    output wire [6:0] z
);

    reg [6:0] z_comb;
    assign z = z_comb;

    always_comb begin
        case (x)
            4'b0000 : z_comb = 7'b0111111;
            4'b0001 : z_comb = 7'b0000110;
            4'b0010 : z_comb = 7'b1011011;
            4'b0011 : z_comb = 7'b1001111;
            4'b0100 : z_comb = 7'b1100110;
            4'b0101 : z_comb = 7'b1101101;
            4'b0110 : z_comb = 7'b1111101;
            4'b0111 : z_comb = 7'b0000111;
            4'b1000 : z_comb = 7'b1111111;
            4'b1001 : z_comb = 7'b1101111;
            4'b1010 : z_comb = 7'b1110111;
            4'b1011 : z_comb = 7'b1111100;
            4'b1100 : z_comb = 7'b0111001;
            4'b1101 : z_comb = 7'b1011110;
            4'b1110 : z_comb = 7'b1111001;
            4'b1111 : z_comb = 7'b1110001;
        endcase
    end

endmodule

module dpy_scan #(
    parameter SCAN_INTERVAL = 10_000
)(
    input wire clk,
    input wire [31:0] number,  // 32-bit binary number to display
    input wire [7:0]  dp,       // each bit represents to a dot

    output wire [7:0] digit,   // output to circuit
    output wire [7:0] segment  // output to circuit
);

    reg [2:0] scan_digit;
    wire [3:0] scan_number;

    // scan current digit
    reg [31:0] counter;
    always_ff @ (posedge clk) begin
        counter <= counter + 32'b1;
        if (counter == SCAN_INTERVAL) begin
            counter <= 32'd0;
            scan_digit <= scan_digit + 3'd1;
        end
    end

    assign scan_number = number[4 * scan_digit +: 4];

    // decode scanned number
    dpy_decode decode (
        .x (scan_number),
        .z (segment[6:0])
    );

    assign segment[7] = dp[scan_digit];

    // scan digit output
    assign digit = 1'b1 << scan_digit;

endmodule
