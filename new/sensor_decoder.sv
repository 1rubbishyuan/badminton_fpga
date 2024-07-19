`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/28 20:14:34
// Design Name: 
// Module Name: sensor_decoder
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

// 传感器解码模块

module sensor_decoder(
    input wire clk,
    input wire rst,
    input wire signed [15:0] raw_data,
    output reg [3:0][5:0] api
);

parameter UPBOUND = 8192;
parameter DOWNBOUND = -8192;

always_ff @(posedge clk) begin
    if(rst) begin
        api <= 24'b0;
    end
    else begin
        if(raw_data > UPBOUND) begin
            api[3][4] <= 1'b1; 
            api[3][5] <= 1'b0;
        end
        else if(raw_data < DOWNBOUND) begin
            api[3][5] <= 1'b1;
            api[3][4] <= 1'b0;
        end
        else begin
            api[3][4] <= 1'b0;
            api[3][5] <= 1'b0;
        end
    end
end 

endmodule
