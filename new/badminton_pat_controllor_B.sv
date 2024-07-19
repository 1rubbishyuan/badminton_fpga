`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/28 16:58:14
// Design Name: 
// Module Name: badminton_pat_controllor_B
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

// 球拍B控制模块

// 球拍B状态机
package pat_B_state_machine;
    import main_package::*;
    import collision::*;

    typedef enum {
        Idle_1,    // 40
        Idle_2,    // 140
        Up_1,      // 20
        Up_2,      // 0
        Up_3,      // 340
        Up_4,      // 320
        Up_5,      // 300
        Up_6,      // 280
        Up_7,      // 260
        Down_1,    // 160
        Down_2,    // 180
        Down_3,    // 200
        Down_4,    // 220
        Down_5,    // 240
        Down_6,    // 260
        Down_7,    // 280
        Down_8,    // 300
        Down_9,    // 320
        Down_10,   // 340
        Down_11,   // 0
        Down_12   // 20
    } pat_B_state_name;

    typedef struct packed {
        reg [11:0] width;
        reg [11:0] height;
        reg [11:0] rom_pos_x;
        reg [11:0] rom_pos_y;
        reg [11:0] pat_B_collision_size_x;
        reg [11:0] pat_B_collision_size_y;
    } pat_B_state;

    parameter int pat_B_state_to_degree[21] = '{
        Idle_1:enum_to_index[Pat_4],     // 40
        Idle_2:enum_to_index[Pat_14],    // 140
        Up_1:enum_to_index[Pat_2],       // 20
        Up_2:enum_to_index[Pat_0],       // 0
        Up_3:enum_to_index[Pat_34],      // 340
        Up_4:enum_to_index[Pat_32],      // 320
        Up_5:enum_to_index[Pat_30],      // 300
        Up_6:enum_to_index[Pat_28],      // 280
        Up_7:enum_to_index[Pat_26],      // 260
        Down_1:enum_to_index[Pat_16],    // 160
        Down_2:enum_to_index[Pat_18],    // 180
        Down_3:enum_to_index[Pat_20],    // 200
        Down_4:enum_to_index[Pat_22],    // 220
        Down_5:enum_to_index[Pat_24],    // 240
        Down_6:enum_to_index[Pat_26],    // 260
        Down_7:enum_to_index[Pat_28],    // 280
        Down_8:enum_to_index[Pat_30],    // 300
        Down_9:enum_to_index[Pat_32],    // 320
        Down_10:enum_to_index[Pat_34],   // 340
        Down_11:enum_to_index[Pat_0],    // 0
        Down_12:enum_to_index[Pat_2]     // 20
    };

    // 球拍B状态硬编码
    parameter pat_B_state pat_B_states[21] = '{
        Idle_1: '{
            sprite_size[Pat_4][0], sprite_size[Pat_4][1], pos_in_rom[Pat_4][0], pos_in_rom[Pat_4][1],
            collision_boxes_sizes[Pat_4 - collision_boxes_size_index_bias][0], collision_boxes_sizes[Pat_4 - collision_boxes_size_index_bias][1]
        },    // 40
        Idle_2: '{
            sprite_size[Pat_14][0], sprite_size[Pat_14][1], pos_in_rom[Pat_14][0], pos_in_rom[Pat_14][1],
            collision_boxes_sizes[Pat_14 - collision_boxes_size_index_bias][0], collision_boxes_sizes[Pat_14 - collision_boxes_size_index_bias][1]
        },    // 140
        Up_1: '{
            sprite_size[Pat_2][0], sprite_size[Pat_2][1], pos_in_rom[Pat_2][0], pos_in_rom[Pat_2][1],
            collision_boxes_sizes[Pat_2 - collision_boxes_size_index_bias][0], collision_boxes_sizes[Pat_2 - collision_boxes_size_index_bias][1]
        },      // 20
        Up_2: '{
            sprite_size[Pat_0][0], sprite_size[Pat_0][1], pos_in_rom[Pat_0][0], pos_in_rom[Pat_0][1],
            collision_boxes_sizes[Pat_0 - collision_boxes_size_index_bias][0], collision_boxes_sizes[Pat_0 - collision_boxes_size_index_bias][1]
        },      // 0
        Up_3: '{
            sprite_size[Pat_34][0], sprite_size[Pat_34][1], pos_in_rom[Pat_34][0], pos_in_rom[Pat_34][1],
            collision_boxes_sizes[Pat_34 - collision_boxes_size_index_bias][0], collision_boxes_sizes[Pat_34 - collision_boxes_size_index_bias][1]
        },      // 340
        Up_4: '{
            sprite_size[Pat_32][0], sprite_size[Pat_32][1], pos_in_rom[Pat_32][0], pos_in_rom[Pat_32][1],
            collision_boxes_sizes[Pat_32 - collision_boxes_size_index_bias][0], collision_boxes_sizes[Pat_32 - collision_boxes_size_index_bias][1]
        },      // 320
        Up_5: '{
            sprite_size[Pat_30][0], sprite_size[Pat_30][1], pos_in_rom[Pat_30][0], pos_in_rom[Pat_30][1],
            collision_boxes_sizes[Pat_30 - collision_boxes_size_index_bias][0], collision_boxes_sizes[Pat_30 - collision_boxes_size_index_bias][1]
        },      // 300
        Up_6: '{
            sprite_size[Pat_28][0], sprite_size[Pat_28][1], pos_in_rom[Pat_28][0], pos_in_rom[Pat_28][1],
            collision_boxes_sizes[Pat_28 - collision_boxes_size_index_bias][0], collision_boxes_sizes[Pat_28 - collision_boxes_size_index_bias][1]
        },      // 280
        Up_7: '{
            sprite_size[Pat_26][0], sprite_size[Pat_26][1], pos_in_rom[Pat_26][0], pos_in_rom[Pat_26][1],
            collision_boxes_sizes[Pat_26 - collision_boxes_size_index_bias][0], collision_boxes_sizes[Pat_26 - collision_boxes_size_index_bias][1]
        },      // 260
        Down_1: '{
            sprite_size[Pat_16][0], sprite_size[Pat_16][1], pos_in_rom[Pat_16][0], pos_in_rom[Pat_16][1],
            collision_boxes_sizes[Pat_16 - collision_boxes_size_index_bias][0], collision_boxes_sizes[Pat_16 - collision_boxes_size_index_bias][1]
        },    // 160
        Down_2: '{
            sprite_size[Pat_18][0], sprite_size[Pat_18][1], pos_in_rom[Pat_18][0], pos_in_rom[Pat_18][1],
            collision_boxes_sizes[Pat_18 - collision_boxes_size_index_bias][0], collision_boxes_sizes[Pat_18 - collision_boxes_size_index_bias][1]
        },    // 180
        Down_3: '{
            sprite_size[Pat_20][0], sprite_size[Pat_20][1], pos_in_rom[Pat_20][0], pos_in_rom[Pat_20][1],
            collision_boxes_sizes[Pat_20 - collision_boxes_size_index_bias][0], collision_boxes_sizes[Pat_20 - collision_boxes_size_index_bias][1]
        },    // 200
        Down_4: '{
            sprite_size[Pat_22][0], sprite_size[Pat_22][1], pos_in_rom[Pat_22][0], pos_in_rom[Pat_22][1],
            collision_boxes_sizes[Pat_22 - collision_boxes_size_index_bias][0], collision_boxes_sizes[Pat_22 - collision_boxes_size_index_bias][1]
        },    // 220
        Down_5: '{
            sprite_size[Pat_24][0], sprite_size[Pat_24][1], pos_in_rom[Pat_24][0], pos_in_rom[Pat_24][1],
            collision_boxes_sizes[Pat_24 - collision_boxes_size_index_bias][0], collision_boxes_sizes[Pat_24 - collision_boxes_size_index_bias][1]
        },    // 240
        Down_6: '{
            sprite_size[Pat_26][0], sprite_size[Pat_26][1], pos_in_rom[Pat_26][0], pos_in_rom[Pat_26][1],
            collision_boxes_sizes[Pat_26 - collision_boxes_size_index_bias][0], collision_boxes_sizes[Pat_26 - collision_boxes_size_index_bias][1]
        },    // 260
        Down_7: '{
            sprite_size[Pat_28][0], sprite_size[Pat_28][1], pos_in_rom[Pat_28][0], pos_in_rom[Pat_28][1],
            collision_boxes_sizes[Pat_28 - collision_boxes_size_index_bias][0], collision_boxes_sizes[Pat_28 - collision_boxes_size_index_bias][1]
        },    // 280
        Down_8: '{
            sprite_size[Pat_30][0], sprite_size[Pat_30][1], pos_in_rom[Pat_30][0], pos_in_rom[Pat_30][1],
            collision_boxes_sizes[Pat_30 - collision_boxes_size_index_bias][0], collision_boxes_sizes[Pat_30 - collision_boxes_size_index_bias][1]
        },    // 300
        Down_9: '{
            sprite_size[Pat_32][0], sprite_size[Pat_32][1], pos_in_rom[Pat_32][0], pos_in_rom[Pat_32][1],
            collision_boxes_sizes[Pat_32 - collision_boxes_size_index_bias][0], collision_boxes_sizes[Pat_32 - collision_boxes_size_index_bias][1]
        },    // 320
        Down_10: '{
            sprite_size[Pat_34][0], sprite_size[Pat_34][1], pos_in_rom[Pat_34][0], pos_in_rom[Pat_34][1],
            collision_boxes_sizes[Pat_34 - collision_boxes_size_index_bias][0], collision_boxes_sizes[Pat_34 - collision_boxes_size_index_bias][1]
        },   // 340
        Down_11: '{
            sprite_size[Pat_0][0], sprite_size[Pat_0][1], pos_in_rom[Pat_0][0], pos_in_rom[Pat_0][1],
            collision_boxes_sizes[Pat_0 - collision_boxes_size_index_bias][0], collision_boxes_sizes[Pat_0 - collision_boxes_size_index_bias][1]
        },   // 0
        Down_12: '{
            sprite_size[Pat_2][0], sprite_size[Pat_2][1], pos_in_rom[Pat_2][0], pos_in_rom[Pat_2][1],
            collision_boxes_sizes[Pat_2 - collision_boxes_size_index_bias][0], collision_boxes_sizes[Pat_2 - collision_boxes_size_index_bias][1]
        }    // 20
    };
    
endpackage

import playerB_move_machine::playerB_move_states_name;
import pat_B_state_machine::*;
import collision::*;
module badminton_pat_controllor_B(
    input wire clk,
    input wire rst_n,
    input wire up_swing, // 上挥拍
    input wire down_swing, // 下挥拍
    input wire holding, // 是否持球
    input playerB_move_states_name playerB_curr_state, // B的状态
    input wire [11:0] player_B_x, // B在屏幕上的位置
    input wire [11:0] player_B_y, 
    input wire write_finished, // 上一帧读完
    output reg gaming_B, // B开始游戏
    output wire [11:0] pat_B_x, // 拍B在屏幕上的位置
    output wire [11:0] pat_B_y,
    output collision_box pat_B_collision, // 拍B碰撞箱
    output pat_B_state pat_B_curr_state, // 拍B状态
    output pat_B_state_name pat_B_curr_state_name
);

    parameter change_picture_count = 32'd2;

    import playerB_move_machine::*;
    import pat_B_state_machine::*;
    import collision::*;
    import main_package::*;

    pat_B_state_name curr_state, next_state;
    assign pat_B_curr_state_name =curr_state;
    reg [31:0] change_picture_record;
    reg up_back;
    reg finished;
    reg [1:0] direction;

    // 确定挥拍方向，防止相互干扰
    always_ff @(posedge clk) begin
        if(rst_n) begin
            direction <= 2'b00;
        end
        else if(direction == 2'b00) begin
            direction[0] <= up_swing;
            direction[1] <= down_swing;
        end
        else if((direction == 2'b11) || finished) begin
            direction <= 2'b00;
        end
    end

    // 根据挥拍方向来修改拍的状态
    always_ff @(posedge clk) begin
        if(rst_n) begin
            gaming_B <= 1'b0;
            change_picture_record <= 32'd0;
            up_back <= 0;
            finished <= 0;
            if(!holding) begin
                curr_state <= Idle_1;
                next_state <= Idle_1;
            end
            else begin
                curr_state <= Idle_2;
                next_state <= Idle_2;
            end
        end
        else if(write_finished) begin
            curr_state <= next_state;
            if(direction == 2'b00) begin
                finished <= 0;
                next_state <= Idle_1;
            end
            else if(direction == 2'b01) begin
                change_picture_record <= change_picture_record + 1;
                if(change_picture_record == change_picture_count) begin
                    change_picture_record <= 0;
                    case (next_state)
                        Idle_1: begin
                            if(up_back == 1'b0) begin
                                next_state <= Up_1;
                            end
                            else begin
                                next_state <= Idle_1;
                                finished <= 1;
                                up_back <= 1'b0;
                            end
                        end 
                        Up_1: next_state <= (up_back == 1'b0) ? Up_2 : Idle_1;
                        Up_2: next_state <= (up_back == 1'b0) ? Up_3 : Up_1;
                        Up_3: next_state <= (up_back == 1'b0) ? Up_4 : Up_2;
                        Up_4: next_state <= (up_back == 1'b0) ? Up_5 : Up_3;
                        Up_5: next_state <= (up_back == 1'b0) ? Up_6 : Up_4;
                        Up_6: next_state <= (up_back == 1'b0) ? Up_7 : Up_5;
                        Up_7: begin
                            up_back <= 1'b1;
                            next_state <= Up_6;
                        end
                        default: next_state <= Idle_1;
                    endcase
                end
            end
            else if (direction == 2'b10) begin
                if(holding) begin
                    gaming_B <= 1'b1;
                end 
                change_picture_record <= change_picture_record + 1;
                if(change_picture_record == change_picture_count) begin
                    change_picture_record <= 0;
                    case (next_state)
                        Idle_1: next_state <= Idle_2;
                        Idle_2: next_state <= Down_1;
                        Down_1: next_state <= Down_2;
                        Down_2: next_state <= Down_3;
                        Down_3: next_state <= Down_4;
                        Down_4: next_state <= Down_5;
                        Down_5: next_state <= Down_6;
                        Down_6: next_state <= Down_7;
                        Down_7: next_state <= Down_8;
                        Down_8: next_state <= Down_9;
                        Down_9: next_state <= Down_10;
                        Down_10: next_state <= Down_11;
                        Down_11: next_state <= Down_12;
                        Down_12: begin 
                            next_state <= Idle_1;
                            finished <= 1;
                        end
                        default: next_state <= Idle_1;
                    endcase
                end
            end
            else begin
                next_state <= Idle_1;
            end
        end
    end

    // 相对应的分配拍B的状态
    assign pat_B_x = player_B_x + armbias[playerB_curr_state + 5][pat_B_state_to_degree[curr_state] - armbias_index_bias][0];
    assign pat_B_y = player_B_y + armbias[playerB_curr_state + 5][pat_B_state_to_degree[curr_state] - armbias_index_bias][1];
    assign pat_B_curr_state = pat_B_states[curr_state];
    // 一些情况下删除碰撞箱，例如未挥拍状态
    assign pat_B_collision = ((direction==2'b01 && !up_back)||direction==2'b10)? '{
        pat_B_curr_state.pat_B_collision_size_x,
        pat_B_curr_state.pat_B_collision_size_y,
        pat_B_x + collision_boxes_bias[pat_B_state_to_degree[curr_state] - collision_boxes_bias_index_bias][0],
        pat_B_y + collision_boxes_bias[pat_B_state_to_degree[curr_state] - collision_boxes_bias_index_bias][1]
    }:'{
        pat_B_curr_state.pat_B_collision_size_x,
        pat_B_curr_state.pat_B_collision_size_y,
        12'd0,
        12'd0
    };
endmodule
