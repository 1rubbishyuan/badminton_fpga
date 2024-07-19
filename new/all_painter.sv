`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/21 15:23:24
// Design Name: 
// Module Name: all_painter
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
import main_package::element_pos_size_rom;
import main_package::Rend_number;
module all_painter#(COOR_WIDTH = 12,HSIZE=720,VSIZE=540)(
    input wire clk,
    input wire rst_n,
    input element_pos_size_rom elements_all[Rend_number],
    input reg [11:0] record_x[20:0],
    input reg [11:0] record_y[20:0],
    input wire show_bling,
    output reg[11:0] pixel_data,
    output reg[COOR_WIDTH-1:0] write_x,
    output reg[COOR_WIDTH-1:0] write_y,
    output wire finished,
    );
    
    reg write_finished;
    reg [4:0]cur_element_num;
    reg background_finished;
    reg [11:0] background_pixel;
    reg [COOR_WIDTH-1:0] background_x;
    reg [COOR_WIDTH-1:0] background_y;
    assign finished = write_finished;


    reg background_rst;
    background_painter b_painter(
        .clk(clk),
        .rst_n(background_rst),
        .record_x(record_x),
        .record_y(record_y),
        .show_bling(show_bling),
        .pixel_data(background_pixel),
        .write_x(background_x),
        .write_y(background_y),
        .finished(background_finished)
    );
    
    reg element_finished;
    reg [11:0] element_pixel;
    wire [3:0] red_pixel,green_pixel,blue_pixel;
    assign red_pixel = element_pixel[11:8];
    assign green_pixel = element_pixel[7:4];
    assign blue_pixel = element_pixel[3:0];
    reg [COOR_WIDTH-1:0] element_x;
    reg [COOR_WIDTH-1:0] element_y;
    reg element_rst;
    

    
    reg [COOR_WIDTH-1:0] x_pixel;
    reg [COOR_WIDTH-1:0] y_pixel;
    reg [COOR_WIDTH-1:0] width;
    reg [COOR_WIDTH-1:0] height;
    reg [COOR_WIDTH-1:0] sprite_x;
    reg [COOR_WIDTH-1:0] sprite_y;


    always_comb begin
        {x_pixel,y_pixel,width,height,sprite_x,sprite_y} = elements_all[cur_element_num];
    end

    element_painter e_painter (
        .clk(clk),
        .rst_n(element_rst),
        .ena(1'b1),
        .sprite_x(sprite_x),
        .sprite_y(sprite_y),
        .x_pixel(x_pixel),
        .y_pixel(y_pixel),
        .width(width),
        .height(height),
        .write_x(element_x),
        .write_y(element_y),
        .pixel_data(element_pixel),
        .write_finished(element_finished)
    );
    
    
    always_ff@(posedge clk)begin
        write_finished=0;
         if(rst_n)begin
            element_rst<=1;
            cur_element_num<=0;
            background_rst<=1;
        end
        else begin
            if(background_rst)begin
                background_rst<=0;
            end
            else begin
                if(background_finished)begin
                    element_rst<=0;
                end
                if (element_finished) begin
                    cur_element_num<=cur_element_num+1;
                end
                if (cur_element_num>=Rend_number)begin
                    element_rst<=1;
                    background_rst<=1;
                    cur_element_num<=0;
                    write_finished <=1;
                end
            end
        end
    end
    
    always_comb begin
        if(element_rst)begin
            pixel_data = background_pixel;
            write_x = background_x;
            write_y = background_y;
        end
        else begin
            if(green_pixel<4'h9)begin
                pixel_data = element_pixel;
                write_x = element_x;
                write_y = element_y;
            end
            else begin
                if(red_pixel<4'h9&&blue_pixel<4'h9)begin
                    pixel_data = 12'hCCC;
                    write_x = 12'h000;
                    write_y = 12'h000;
                end
                else begin
                    pixel_data = element_pixel;
                    write_x = element_x;
                    write_y = element_y;
                end
            end
        end
    end
        
    endmodule
