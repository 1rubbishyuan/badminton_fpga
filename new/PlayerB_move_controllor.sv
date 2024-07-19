`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/24 20:08:47
// Design Name: 
// Module Name: playerB_move_controllor
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

// 玩家B控制模块

// 玩家B运动状态机
package playerB_move_machine;
    import main_package::*;
    typedef enum{
        Idle,
        Move_1,
        Move_2,
        Move_3,
        Move_4
    }playerB_move_states_name;

    // 玩家B运动状态
    typedef struct packed{
        reg [11:0] width;
        reg [11:0] height;
        reg [11:0] rom_pos_x;
        reg [11:0] rom_pos_y;
    } playerB_move_state;

    // 硬编码玩家B状态
    parameter playerB_move_state playerB_move_states[5]='{
        Idle:'{sprite_size[PlayerB][0],sprite_size[PlayerB][1],pos_in_rom[PlayerB][0],pos_in_rom[PlayerB][1]},
        Move_1:'{sprite_size[PlayerB_move1][0],sprite_size[PlayerB_move1][1],pos_in_rom[PlayerB_move1][0],pos_in_rom[PlayerB_move1][1]},
        Move_2:'{sprite_size[PlayerB_move2][0],sprite_size[PlayerB_move2][1],pos_in_rom[PlayerB_move2][0],pos_in_rom[PlayerB_move2][1]},
        Move_3:'{sprite_size[PlayerB_move3][0],sprite_size[PlayerB_move3][1],pos_in_rom[PlayerB_move3][0],pos_in_rom[PlayerB_move3][1]},
        Move_4:'{sprite_size[PlayerB_move4][0],sprite_size[PlayerB_move4][1],pos_in_rom[PlayerB_move4][0],pos_in_rom[PlayerB_move4][1]}
    };
endpackage

import playerB_move_machine::playerB_move_state;
import playerB_move_machine::playerB_move_states_name;
module playerB_move_controllor(
       input wire clk,
       input wire rst_n,
       input wire move_left,
       input wire move_right,
       input wire jump,
       input wire gaming,
       input wire write_finished,
       output wire [11:0] player_x, // 玩家B位置
       output wire [11:0] player_y,
       output playerB_move_states_name curr_state, // 玩家B状态
       output playerB_move_state playerB_curr_state
);

    reg [11:0] current_x,current_y;
    parameter move_velocity=4'd1;
    parameter jump_velocity=4'd1;
    parameter start_line = 12'd460;
    parameter net_line = 12'd370;
    parameter jump_force = 4'd2;
    parameter move_force = 4'd4;
    integer bound_line =start_line;
    
    // B位置控制状态机
    reg [3:0] move_counter;
    reg [3:0] jump_counter;
    reg jumping;
    reg is_up;
    always_ff@(posedge clk)begin
        if(rst_n)begin
            current_x <= 12'd630;
            current_y <= 12'd380;
            move_counter<=4'd0;
            jump_counter<=4'd0;
            jumping<=0;
            is_up<=0;
        end
        else begin
            if(write_finished)begin
                if(move_right)begin
                    if(current_x<=630)begin
                        if(move_counter<move_velocity)begin
                            move_counter<=move_counter+1; 
                        end
                        else begin
                            current_x <= current_x+move_force;
                            move_counter<=0;
                        end
                    end
                end
                else if(move_left)begin
                    if(gaming)begin
                        bound_line = net_line;
                    end
                    else begin
                        bound_line = start_line;
                    end
                    if(current_x>=bound_line)begin
                        if(move_counter<move_velocity)begin
                            move_counter<=move_counter+1; 
                        end
                        else begin
                            current_x <= current_x-move_force;
                            move_counter<=0;
                        end
                    end
                end
                if(jump&&current_y==380)begin
                    jumping<=1;
                    is_up<=1;
                end
                
                if(jumping) begin
                    if(jump_counter<jump_velocity)begin
                        jump_counter <= jump_counter+1;
                    end
                    else begin
                        if(current_y>300&&is_up)begin
                            current_y<=current_y-jump_force;
                        end
                        else begin
                            is_up<=0;
                            if(current_y!=380)begin
                                current_y<=current_y+jump_force;
                            end
                            else begin
                                jumping<=0;
                            end
                        end
                    end
                end
            end
        end
    end
    assign player_x = current_x;
    assign player_y = current_y;
    
    import playerB_move_machine::*;
    playerB_move_states_name next_state;
    
    parameter change_picture_count=32'd1500000;
    reg [31:0] change_picture_record;
        
    // B状态控制机
    always_ff@(posedge clk)begin
        if(rst_n)begin
            curr_state<=Idle;
            next_state<=Idle;
            change_picture_record<=0;
        end
        else begin
            curr_state<=next_state;
            if(move_right&&!jumping)begin
                change_picture_record<=change_picture_record+1;
                if(change_picture_record>=change_picture_count)begin
                    case(next_state)
                        Idle:next_state<=Move_4;
                        Move_4:next_state<=Move_3;
                        Move_3:next_state<=Move_2;
                        Move_2:next_state<=Move_1;
                        Move_1:next_state<=Idle;
                        default: next_state<=Idle;
                    endcase
                    change_picture_record<=0;
               end
            end
            else if(move_left&&!jumping)begin
                change_picture_record<=change_picture_record+1;
                if(change_picture_record>=change_picture_count)begin
                    case(next_state)
                        Idle: next_state<=Move_1;
                        Move_1:next_state<=Move_2;
                        Move_2:next_state<=Move_3;
                        Move_3:next_state<=Move_4;
                        Move_4:next_state<=Idle;
                        default:next_state<=Idle;
                    endcase
                    change_picture_record<=0;
               end
            end
            else begin
                    curr_state<=Idle;
                    next_state<=Move_1;
            end
        end
    end
    assign playerB_curr_state = playerB_move_states[curr_state];
    
endmodule
