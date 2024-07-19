`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/20 17:19:22
// Design Name: 
// Module Name: input_reader
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


module input_reader(
    input wire clk_ps2,    
    input wire clk_uart,
    input wire clk_uart_locked,
    input wire clk_hdmi,
    input wire clk_locked,
    input wire rst_ps2,
    input wire rst_uart, 

    input wire ps2_keyboard_clk,
    input wire ps2_keyboard_data,

    input wire ps2_mouse_clk_i,
    input wire ps2_mouse_clk_o,
    input wire ps2_mouse_clk_t,

    input wire ps2_mouse_data_i,
    input wire ps2_mouse_data_o,
    input wire ps2_mouse_data_t,

    input wire wireless_tx,

    output reg[3:0][5:0] input_signal
);
    reg [31:0] dpy_input_signal;
    wire [7:0] scancode;   
    reg [31:0] number;

    wire scancode_valid;
    ps2_keyboard u_ps2_keyboard (
        .clock     (clk_ps2            ),
        .reset     (rst          ),
        .ps2_clock (ps2_keyboard_clk ),
        .ps2_data  (ps2_keyboard_data),
        .scancode  (scancode         ),
        .valid     (scancode_valid   )
    );
    
    wire [2:0] btn_click;
    wire [11:0] mouse_x;
    wire [11:0] mouse_y;

    // 锟斤拷锟斤拷锟斤拷氪︼拷�????

    // 锟斤拷�?�锟斤拷
    assign ps2_mouse_clk = ps2_mouse_clk_t ? 1'bz : ps2_mouse_clk_o;
    assign ps2_mouse_clk_i = ps2_mouse_clk;

    assign ps2_mouse_data = ps2_mouse_data_t ? 1'bz : ps2_mouse_data_o;
    assign ps2_mouse_data_i = ps2_mouse_data;

    // PS/2 IP 锟斤拷锟斤拷锟斤拷时锟斤拷锟斤拷 50MHz锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷锟??? VGA/HDMI 锟斤拷锟斤拷锟斤拷时锟斤�?
    ps2_mouse u_ps2_mouse (
        .clock(clk_hdmi),
        .reset(!clk_locked),

        .ps2_clock_i(ps2_mouse_clk_i),
        .ps2_clock_o(ps2_mouse_clk_o),
        .ps2_clock_t(ps2_mouse_clk_t),
        .ps2_data_i(ps2_mouse_data_i),
        .ps2_data_o(ps2_mouse_data_o),
        .ps2_data_t(ps2_mouse_data_t),

        .mouse_x(mouse_x),
        .mouse_y(mouse_y),
        .btn_click(btn_click)
    );

    // 锟斤拷锟??? 锟斤拷锟斤拷锟斤拷锟诫处锟斤�?
    ps2_decoder u_ps2_decoder (
        .clk(clk_in),
        .rst(btn_rst),
        
        .mouse_click(btn_click),
        
        .scancode_valid(scancode_valid),
        .in_number(number),
        .scancode(scancode),
        .out_number(number),
        
        .api(input_signal)
    );

    // 锟斤拷锟斤拷锟斤�? 锟斤拷锟诫处锟斤�?
    wire [7:0] raw;
    wire [15:0] angle;
    wire signed [15:0] angular_v;
    
    reset_filter resetter_uart (
        .clk(clk_uart),
        .rst_in(btn_rst),
        .rst_out(reset_uart)
    );

    sensor_reader sensor_reader_inst (
      .clk(clk_uart),
      .rst(reset_uart),
      .rxd(wireless_tx),
      .angular_v(angular_v)
    );
    
    wire a;
    wire b;
    
    sensor_decoder sensor_decoder_inst(
        .raw_data(angular_v),
        .api(input_signal)
    );


async_receiver async_receiver_inst(

);
endmodule
