`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/11 17:56:28
// Design Name: 
// Module Name: painter
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


module element_painter#(COOR_WIDTH = 12, ROM_WIDTH=19,ROM_PICTURE_WIDTH=404)( 
    input wire clk,
    input wire rst_n,
    input wire ena,

    input wire [COOR_WIDTH-1:0] sprite_x,
    input wire [COOR_WIDTH-1:0] sprite_y,

    input wire [COOR_WIDTH-1:0] x_pixel,
    input wire [COOR_WIDTH-1:0] y_pixel,

    input wire [COOR_WIDTH-1:0] width,
    input wire [COOR_WIDTH-1:0] height,

    output reg [COOR_WIDTH-1:0] write_x,
    output reg [COOR_WIDTH-1:0] write_y,
    output wire [11:0] pixel_data,
    output wire write_finished

    ); 
    
        
        reg [ROM_WIDTH-1:0] rom_addr;
        reg [COOR_WIDTH-1:0] x;
        reg [COOR_WIDTH-1:0] y;
        reg [COOR_WIDTH-1:0] last_x[1:0];
        reg [COOR_WIDTH-1:0] last_y[1:0];
        reg finished;

        always_ff @(posedge clk) begin
            finished<=0;
            if(rst_n)begin
                x<=0;
                y<=0;
                finished<=0;
                last_x[0]<=0;
                last_y[0]<=0;
                last_x[1]<=0;
                last_y[1]<=0;
            end
            else begin
                if (y!=height)begin
                    if (x==width-1)begin
                        x<=0;
                        y<=y+1;
                    end
                    else begin
                        x<=x+1;
                    end
                end
                else begin 
                    finished<=1;
                    y<=0;
                end
            end
             last_x[0]<=x;
             last_x[1]<=last_x[0];
             last_y[0]<=y;
             last_y[1]<=last_y[0];
        end
        assign write_finished=finished;
        assign rom_addr = (sprite_x+x)+ROM_PICTURE_WIDTH*(sprite_y+y);
        
        blk_mem_gen_0 rom (
            .clka(clk), // input clka
            .addra(rom_addr), // input addra
            .douta(pixel_data), // output [11 : 0] douta
            .ena(ena)
        );

        always_comb begin
            write_x = x_pixel + last_x[1];//x;
            write_y = y_pixel + last_y[1];//y;
        end

endmodule
