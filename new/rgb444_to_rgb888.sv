`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/20 13:21:10
// Design Name: 
// Module Name: rgb444_to_rgb888
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


module rgb444_to_rgb888 (
    input wire [11:0] rgb444,
    input wire to_black,
    input wire[11:0] hdata,
    input wire[11:0] vdata,
    output reg [23:0] rgb888
);
//    wire [3:0] r4 = rgb444[11:8];
//    wire [3:0] g4 = rgb444[7:4];
//    wire [3:0] b4 = rgb444[3:0];

//    wire [7:0] r8 = {r4, r4};
//    wire [7:0] g8 = {g4, g4};
//    wire [7:8] b8 = {b4, b4};
    always_comb begin
        if(!to_black)begin
            rgb888 = {rgb444[11:8],rgb444[11:8],rgb444[3:0],rgb444[3:0],rgb444[7:4],rgb444[7:4]};
        end
        else begin
            if(hdata>=283&&vdata>=220&&hdata<=483&&vdata<=355)begin
                rgb888 = {rgb444[11:8],rgb444[11:8],rgb444[3:0],rgb444[3:0],rgb444[7:4],rgb444[7:4]};
            end
            else begin
               rgb888 = {
                (rgb444[11:8] > 4'h2 ? rgb444[11:8] - 4'h2 : 4'h0), (rgb444[11:8] > 4'h2 ? rgb444[11:8] - 4'h2 : 4'h0),
                (rgb444[3:0] > 4'h2 ? rgb444[3:0] - 4'h2 : 4'h0), (rgb444[3:0] > 4'h2 ? rgb444[3:0] - 4'h2 : 4'h0),
                (rgb444[7:4] > 4'h2 ? rgb444[7:4] - 4'h2 : 4'h0), (rgb444[7:4] > 4'h2 ? rgb444[7:4] - 4'h2 : 4'h0)
            };
            end
        end
    end
//    assign rgb888 = {rgb444[11:8],rgb444[11:8],rgb444[3:0],rgb444[3:0],rgb444[7:4],rgb444[7:4]};
endmodule

