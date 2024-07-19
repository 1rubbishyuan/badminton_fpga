`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/24 20:08:47
// Design Name: 
// Module Name: playerA_move_controllor
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

// ���A����ģ��

// ���A�˶�״̬��
package playerA_move_machine;
    import main_package::*;
    typedef enum{
        Idle,
        Move_1,
        Move_2,
        Move_3,
        Move_4
    }playerA_move_states_name;

    // ���A�˶�״̬��
    typedef struct packed{
        reg [11:0] width;
        reg [11:0] height;
        reg [11:0] rom_pos_x;
        reg [11:0] rom_pos_y;
    } playerA_move_state;

    // Ӳ����
    parameter playerA_move_state playerA_move_states[5]='{
        Idle:'{sprite_size[PlayerA][0],sprite_size[PlayerA][1],pos_in_rom[PlayerA][0],pos_in_rom[PlayerA][1]},
        Move_1:'{sprite_size[PlayerA_move1][0],sprite_size[PlayerA_move1][1],pos_in_rom[PlayerA_move1][0],pos_in_rom[PlayerA_move1][1]},
        Move_2:'{sprite_size[PlayerA_move2][0],sprite_size[PlayerA_move2][1],pos_in_rom[PlayerA_move2][0],pos_in_rom[PlayerA_move2][1]},
        Move_3:'{sprite_size[PlayerA_move3][0],sprite_size[PlayerA_move3][1],pos_in_rom[PlayerA_move3][0],pos_in_rom[PlayerA_move3][1]},
        Move_4:'{sprite_size[PlayerA_move4][0],sprite_size[PlayerA_move4][1],pos_in_rom[PlayerA_move4][0],pos_in_rom[PlayerA_move4][1]}
    };
endpackage

import playerA_move_machine::playerA_move_state;
import playerA_move_machine::playerA_move_states_name;
module playerA_move_controllor(
       input wire clk,
       input wire rst_n,
       input wire move_left, 
       input wire move_right,
       input wire jump,
       input wire gaming,
       input wire write_finished,
       output wire [11:0] player_x, // ���Aλ��
       output wire [11:0] player_y,
       output playerA_move_states_name curr_state, // ���A״̬
       output playerA_move_state playerA_curr_state
    );

    reg [11:0] current_x,current_y;
    parameter move_velocity=4'd1;
    parameter jump_velocity=4'd1;
    parameter change_picture_count=32'd3000000;
    parameter start_line = 12'd200;
    parameter net_line = 12'd280;
    parameter jump_force = 4'd2;
    parameter move_force =4'd4;
    integer bound_line =start_line;
    
    // Aλ�ÿ���״̬��
    reg [31:0] change_picture_record;
    reg [3:0] move_counter;
    reg [3:0] jump_counter;
    reg jumping;
    reg is_up;
    always_ff@(posedge clk)begin
        if(rst_n)begin
            current_x  <=  12'd50;
            current_y  <=  12'd380;
            move_counter <= 4'd0;
            jump_counter <= 4'd0;
            jumping <= 0;
            is_up <= 0;
        end
        else begin
            if(write_finished)begin
                if(move_left)begin
                    if(current_x>=50)begin
                        if(move_counter<move_velocity)begin
                            move_counter <= move_counter+1; 
                        end
                        else begin
                            current_x  <=  current_x-move_force;
                            move_counter <= 0;
                        end
                    end
                end
                else if(move_right)begin
                    if(gaming)begin
                        bound_line = net_line;
                    end
                    else begin
                        bound_line = start_line;
                    end
                    if(current_x <= bound_line)begin
                        if(move_counter<move_velocity)begin
                            move_counter <= move_counter+1; 
                        end
                        else begin
                            current_x  <=  current_x+move_force;
                            move_counter <= 0;
                        end
                    end
                end
                if(jump && current_y==380)begin
                    jumping <= 1;
                    is_up <= 1;
                end
                
                if(jumping) begin
                    if(jump_counter<jump_velocity)begin
                        jump_counter  <=  jump_counter+1;
                    end
                    else begin
                        if(current_y>300 && is_up)begin
                            current_y <= current_y-jump_force;
                        end
                        else begin
                            is_up <= 0;
                            if(current_y!=380)begin
                                current_y <= current_y+jump_force;
                            end
                            else begin
                                jumping  <=  0;
                            end
                        end
                    end
                end
            end
        end
    end
    assign player_x = current_x;
    assign player_y = current_y;
    
    import playerA_move_machine::*;
    playerA_move_states_name next_state;
    
    // A״̬���ƻ�
    always_ff@(posedge clk)begin
        if(rst_n)begin
            curr_state <= Idle;
            next_state <= Idle;
            change_picture_record <= 0;
        end
        else begin
            curr_state <= next_state;
            if(move_right && !jumping)begin
                change_picture_record <= change_picture_record + 1;
                if(change_picture_record>=change_picture_count)begin
                    case(next_state)
                        Idle: next_state <= Move_1;
                        Move_1:next_state <= Move_2;
                        Move_2:next_state <= Move_3;
                        Move_3:next_state <= Move_4;
                        Move_4:next_state <= Idle;
                        default: next_state <= Idle;
                    endcase
                    change_picture_record <= 0;
               end
            end
            else if(move_left && !jumping)begin
                change_picture_record <= change_picture_record+1;
                if(change_picture_record>=change_picture_count)begin
                    case(next_state)
                        Idle:next_state <= Move_4;
                        Move_4:next_state <= Move_3;
                        Move_3:next_state <= Move_2;
                        Move_2:next_state <= Move_1;
                        Move_1:next_state <= Idle;
                        default:next_state <= Idle;
                    endcase
                    change_picture_record <= 0;
               end
            end
            else begin
                    curr_state <= Idle;
                    next_state <= Move_1;
            end
        end
    end
    assign playerA_curr_state = playerA_move_states[curr_state];
    
endmodule
