`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/21 14:50:47
// Design Name: 
// Module Name: background_painter
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


module background_painter#(COOR_WIDTH = 12, ROM_WIDTH=14,ROM_PICTURE_WIDTH=96,HSIZE=720,VSIZE=540)(
    input wire clk,
    input wire rst_n,
    input reg[11:0] record_x[20:0],
    input reg[11:0] record_y[20:0],
    input wire show_bling,
    output reg[11:0] pixel_data,
    output wire[COOR_WIDTH-1:0] write_x,
    output wire[COOR_WIDTH-1:0] write_y,
    output reg finished
    );
    reg [9:0] x,y;
    reg [2:0] random_numbers[20:0];
    
    reg[11:0] rend_record_x[62:0];
    reg[11:0] rend_record_y[62:0];
    random randomer(
        .clk(clk),
        .reset(rst_n),
        .random_numbers(random_numbers)
    );

    reg [11:0] m;
    always_comb begin
        int k;
        if(finished)begin
            for(int i=0;i<=60;i=i+3)begin
                m=0;
                if(i==0)begin
                    k=0;
                end
                else begin
                    k=k+1;
                end
                for(int j=0;j<3;j++)begin
                    m = m + random_numbers[k];
                    rend_record_x[i+j]=record_x[k]+m-random_numbers[k];
                    rend_record_y[i+j]=record_y[k]+m;
                end
            end
        end
    end
    
    function logic check_write_in_record(
        input logic [11:0] write_x,
        input logic [11:0] write_y,
        input reg [11:0] record_x[62:0],
        input reg [11:0] record_y[62:0]
    );
        // 内部变量，用于遍历数组
        int i;
        logic found_x;
        logic found_y;

        // 初始化标志位
        found_x = 0;
        found_y = 0;

        // 遍历record_x和record_y数组
        for (i = 0; i < 62; i++) begin
            found_x=0;
            found_y=0;
            if (record_x[i] == write_x) begin
                found_x = 1;
            end
            if (record_y[i] == write_y) begin
                found_y = 1;
            end
            if(found_x&&found_y)begin
                break;
            end
        end
    
        // 如果在record_x和record_y中都找到匹配的值，则返回1，否则返回0
        return found_x && found_y;
    endfunction
    
    always_ff@(posedge clk)begin
        if(rst_n)begin
            x<=0;
            y<=0;
            finished<=0;
        end
        else begin
            finished<=0;
            if(y!=VSIZE)begin
                if(x == HSIZE-1)begin
                    x<=0;
                    y<=y+1;
                end
                else begin
                    x<=x+1;
                end
            end
            else begin
                x<=0;
                y<=0;
                finished<=1;
            end
        end
    end
    
    parameter gray = 12'hCCC;
    //parameter yellow = 12'hFA4;CCC
    parameter yellow = 12'hEA5;
    parameter black = 12'h000;
    parameter white = 12'hFFF;
    parameter bling = 12'hF65;
    
    wire [9:0] pad;
    wire [9:0] pad_start_line;
    assign write_x = x;
    assign write_y = y;
    assign pad = 540-y;
    assign pad_start_line = 720-y;
    always_comb begin
        if(write_y<450)begin
            if(write_x==90||write_x==630) begin
                pixel_data = black;
            end
            else begin
                pixel_data = gray;
            end
        end
        else begin
            if(write_x <=pad || (720-write_x)<=pad)begin
                pixel_data = gray;
            end
            else begin
                if(write_x==pad_start_line||write_x==720-pad_start_line)begin
                    pixel_data = white;
                end
                else begin
                    pixel_data = yellow;
                end
            end
        end
        
        if(write_x>297&&write_x<423&&write_y>9&&write_y<63)begin
            pixel_data = black;
        end
        if(show_bling&&check_write_in_record(write_x,write_y,rend_record_x,rend_record_y))begin
            pixel_data = bling;
        end
    end
    
    
    
endmodule
