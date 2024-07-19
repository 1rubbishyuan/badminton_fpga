`timescale 1ns / 1ps
package move_pkg;
    typedef enum{
        RST,
        JUMP,
        LEFT,
        RIGHT,
        UP_SWING,
        DOWN_SWING
    } move_t;
endpackage

// 输入处理模块

module ps2_decoder(
    input wire clk,
    input wire rst,
    input wire [2:0] mouse_click, // 鼠标按下
    input wire scancode_valid, // 键盘扫描码合法
    input reg [31:0] in_number, // 扫描码记录
    input reg [7:0] scancode, // 扫描码
    input wire signed [15:0] angular_v, // 传感器角速度
    output reg [31:0] out_number, // 更新后的扫描码记录
    output reg [3:0][5:0] api // 传递给主逻辑的信号
);

    import move_pkg::*;

    parameter ESC    =  8'h76;
    parameter W      =  8'h1D;
    parameter A      =  8'h1C;
    parameter D      =  8'h23;
    parameter J      =  8'h3B;
    parameter K      =  8'h42;
    parameter K1     =  8'h69;
    parameter K2     =  8'h72;
    parameter UPA    =  8'h75;
    parameter LEFTA  =  8'h6B;
    parameter RIGHTA =  8'h74;
    parameter START  =  8'hE0;
    parameter STOP   =  8'hF0;

    parameter DIS_ABLE = 1'b0;
    parameter ABLE = 1'b1;

    always @(posedge clk) begin
        if (rst) begin
            out_number <= 32'b0;
            api <= 24'b0;
        end else begin
            if (scancode_valid) begin
                out_number <= {in_number, scancode};
                unique case(scancode)
                    ESC: begin
                        if (in_number[7:0] == STOP) begin
                            api[0][RST] <= DIS_ABLE;
                        end 
                        else begin
                            api[0][RST] <= ABLE; // ESC
                        end
                    end
                    W: begin 
                        if (in_number[7:0] == STOP) begin
                            api[1][JUMP] <= DIS_ABLE;
                        end
                        else begin 
                            api[1][JUMP] <= ABLE; // W
                        end
                    end 
                    A: begin 
                        if (in_number[7:0] == STOP) begin
                            api[1][LEFT] <= DIS_ABLE;
                        end
                        else begin 
                            api[1][LEFT] <= ABLE; // A
                        end
                    end 
                    D: begin 
                        if (in_number[7:0] == STOP) begin
                            api[1][RIGHT] <= DIS_ABLE;
                        end
                        else begin 
                            api[1][RIGHT] <= ABLE; // D
                        end
                    end 
                    J: begin 
                        if (in_number[7:0] == STOP) begin
                            api[1][UP_SWING] <= DIS_ABLE;
                        end
                        else begin 
                            api[1][UP_SWING] <= ABLE; // J
                        end
                    end 
                    K: begin 
                        if (in_number[7:0] == STOP) begin
                            api[1][DOWN_SWING] <= DIS_ABLE;
                        end
                        else begin 
                            api[1][DOWN_SWING] <= ABLE; // K
                        end
                    end 
                    UPA: begin
                        if (in_number[7:0] == STOP) begin
                            api[2][JUMP] <= DIS_ABLE; // UP
                        end
                        else if (in_number[7:0] == START) begin
                            api[2][JUMP] <= ABLE;
                        end
                    end 
                    LEFTA: begin 
                        if (in_number[7:0] == STOP) begin
                            api[2][LEFT] <= DIS_ABLE; // Left
                        end if (in_number[7:0] == START) begin
                            api[2][LEFT] <= ABLE;
                        end
                    end
                    RIGHTA: begin
                        if (in_number[7:0] == STOP) begin
                            api[2][RIGHT] <= DIS_ABLE; // Right
                        end if (in_number[7:0] == START) begin
                            api[2][RIGHT] <= ABLE;
                        end
                    end
                    K1: begin 
                        if (in_number[7:0] == STOP) begin
                            api[2][UP_SWING] <= DIS_ABLE;
                        end
                        else begin 
                            api[2][UP_SWING] <= ABLE; // 1
                        end
                    end 
                    K2: begin 
                        if (in_number[7:0] == STOP) begin
                            api[2][DOWN_SWING] <= DIS_ABLE;
                        end
                        else begin 
                            api[2][DOWN_SWING] <= ABLE; // 2
                        end
                    end 
                    default: api <= api;
                endcase
            end
            else begin
                if (mouse_click[0] == 1'b1) begin
                    api[3][LEFT] <= ABLE;
                end
                else begin
                    api[3][LEFT] <= DIS_ABLE;
                end
                if (mouse_click[1] == 1'b1) begin
                    api[3][RIGHT] <= ABLE;
                end
                else begin
                    api[3][RIGHT] <= DIS_ABLE;
                end
                if (mouse_click[2] == 1'b1) begin
                    api[3][JUMP] <= ABLE;
                end
                else begin
                    api[3][JUMP] <= DIS_ABLE;
                end
                if (angular_v > 5744) begin
                    api[3][UP_SWING] <= ABLE;
                end
                else begin
                    api[3][UP_SWING] <= DIS_ABLE;
                end
                if(angular_v < -5744) begin
                    api[3][DOWN_SWING] <= ABLE;
                end
                else begin
                    api[3][DOWN_SWING] <= DIS_ABLE;
                end
            end
        end
    end

endmodule