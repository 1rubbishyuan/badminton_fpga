`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/09 10:58:32
// Design Name: 
// Module Name: sram_reader
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


module sram_reader(
     input wire clk,
     input wire rst_n,
     input wire[11:0] read_x,
     input wire[11:0] read_y,
     inout  wire [31:0] base_ram_data,   
     output reg [19:0] base_ram_addr,   
     output wire [3: 0] base_ram_be_n,   
     output wire        base_ram_ce_n,   
     output wire        base_ram_oe_n,  
     output wire        base_ram_we_n,   
     output reg[23:0] pixel_data
    );

    (*mark_debug="true"*)wire valid;
    assign valid=(read_x>=40&&read_x<=760&&read_y>=30&&read_y<=570);
    assign base_ram_addr = (read_x-40)+(read_y-30)*720;

    assign base_ram_we_n=1'b1;
    assign base_ram_ce_n=1'b0;
    assign base_ram_oe_n=1'b0;
    assign base_ram_be_n=4'b0000;
    always_ff @(posedge clk) begin
         if(valid) pixel_data=base_ram_data[31:8];
        else pixel_data=24'd000000;
    end
endmodule
