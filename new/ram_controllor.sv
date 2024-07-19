`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/14 17:09:55
// Design Name: 
// Module Name: ram_controllor
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


module ram_controllor#(
    parameter COOR_WIDTH = 12,
    parameter RAM_WIDTH = 19,
    parameter HSIZE = 720,
    parameter VSIZE = 540
)(
    input wire clk_rd,
    input wire clk_wr,
    input wire rst_n,
    input wire [11:0] input_pixel,

    input wire [COOR_WIDTH-1:0] write_x,
    input wire [COOR_WIDTH-1:0] write_y,

    input wire [COOR_WIDTH-1:0] read_x,
    input wire [COOR_WIDTH-1:0] read_y,

    input wire write_finished,

    output reg [11:0] output_pixel,
    output wire output_valid
);
    reg en_wr_1, en_wr_2, we_wr_1, we_wr_2, en_rd_1, en_rd_2;
    wire [RAM_WIDTH-1:0] wr_address, rd_address;
    wire read_finished;

    // Write and read addresses
    assign wr_address = write_x + write_y * HSIZE;
    assign rd_address = (read_x-40) + (read_y-30) * HSIZE;
    
    // Write control logic
    always_ff @(posedge clk_wr) begin
        if (rst_n) begin
            en_wr_1 <= 1;
            en_wr_2 <= 0;
            we_wr_1 <= 1;
            we_wr_2 <= 0;
            en_rd_1 <= 0;
            en_rd_2 <= 1;
        end
        else if (write_finished) begin
            en_wr_1 <= ~en_wr_1;
            en_wr_2 <= ~en_wr_2;
            we_wr_1 <= ~we_wr_1;
            we_wr_2 <= ~we_wr_2;
            en_rd_1 <= ~en_rd_1;
            en_rd_2 <= ~en_rd_2;
        end
        else begin
            en_wr_1 <= en_wr_1;
            en_wr_2 <= en_wr_2;
            we_wr_1 <= we_wr_1;
            we_wr_2 <= we_wr_2;
        end
    end

    // Read finished signal
    assign read_finished = (read_y == VSIZE - 1 && read_x == HSIZE - 1);


    // Output signals for RAM instances
    reg [11:0] doutb_1, doutb_2;
    
    // RAM instance 1
    ram_dual ram_1(
        .addra(wr_address),
        .clka(clk_wr),
        .dina(input_pixel),
        .ena(en_wr_1),
        .wea(we_wr_1),
        .addrb(rd_address),
        .clkb(clk_rd),
        .doutb(doutb_1),
        .enb(en_rd_1)
    );

    // RAM instance 2
    ram_dual ram_2(
        .addra(wr_address),
        .clka(clk_wr),
        .dina(input_pixel),
        .ena(en_wr_2),
        .wea(we_wr_2),
        .addrb(rd_address),
        .clkb(clk_rd),
        .doutb(doutb_2),
        .enb(en_rd_2)
    );

    // Mux to select the correct output pixel
    always_ff @(posedge clk_rd) begin
        if (en_rd_1) begin
            output_pixel <= doutb_1;
        end
        else if (en_rd_2) begin
            output_pixel <= doutb_2;
        end
    end

    assign output_valid = en_rd_1 || en_rd_2;

endmodule

