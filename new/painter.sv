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


module painter#(COOR_WIDTH = 12, ROM_WIDTH=14)( // ¨¦??????????????????????????????????¡§ROM????????¡§??????????????????????¡¦?????¡ì??????????¨¦???????????
    input wire vga_clk,
    input wire rst_n,
    input wire [COOR_WIDTH-1:0] x_pixel,
    input wire [COOR_WIDTH-1:0] y_pixel,
    input wire ena,
    output wire [23:0] pixel_data
    ); 
        parameter white = 24'b111111111111111111111111   ;
        parameter black = 24'b000000000000000000000000   ;
        parameter red   = 24'b111111110000000000000000   ;
        parameter green = 24'b000000001111111100000000   ;
        parameter bule  = 24'b000000000000000011111111   ;
        //---------------------------------
        parameter height = 10'd94;
        parameter wide   = 10'd96;
        parameter pos_x  = 0;
        parameter pos_y  = 0;
        /*pos_x??????pos_y ?????????????????????????????????????????????????????????????????????????????*/
        //---------------------------------
        wire rom_rd_en;//??????ROM????????????????
        reg [ROM_WIDTH-1:0] rom_addr;//??????ROM???????¡ì????????
        reg [23:0] color_bar;
//        reg ena;
        wire [32:0] total;
        assign total = height * wide ;
        //---------------------------------
        wire [23:0] rom_data;
        assign pixel_data =  rom_rd_en ? rom_data : color_bar;
//        assign pixel_data =  color_bar;
        assign rom_rd_en = (x_pixel > pos_x) && (x_pixel <= pos_x + wide ) && (y_pixel > pos_y) && (y_pixel <= pos_y + height ) ? 1'b1 : 1'b0;
        always@(posedge vga_clk)
        begin
//            ena=1;
            if(rst_n)
                rom_addr <= 14'd1;
            else 
                if(rom_rd_en)
                    begin
                        if(rom_addr < total - 1'b1 )
                            rom_addr <= rom_addr + 1'b1;
                        else 
                            rom_addr <= 'b0;
                    end
                else 
                    rom_addr <= rom_addr;
        end
        always@(posedge vga_clk)
        begin
            if(rst_n)
                color_bar <= 24'd0;
            else 
                if(~rom_rd_en)
                    if(y_pixel >= 240)
                        color_bar <= bule;
                    else 
                        color_bar <= green;
        end
        
        blk_mem_gen_0 rom (
            .clka(vga_clk), // input clka
            .addra(rom_addr), // input [13 : 0] addra
            .douta(rom_data), // output [23 : 0] douta
            .ena(ena)
        );

endmodule
