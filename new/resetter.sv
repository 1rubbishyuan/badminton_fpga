`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/28 14:58:35
// Design Name: 
// Module Name: resetter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// 初始化复位模块

module init_resetter(
    input wire clk,
    input wire rst_in,
    output reg rst_out
);

    parameter CONTAIN = 65535;
    
    reg [15:0] counter = 16'b0;
    
    always_ff @(posedge clk) begin
        if(counter == CONTAIN) begin
            rst_out <= rst_in;
        end
        else begin
            counter <= counter + 1;
            rst_out <= 1;
        end
    end

endmodule