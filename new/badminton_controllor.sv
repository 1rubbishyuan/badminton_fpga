`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/25 22:13:41
// Design Name: 
// Module Name: badminton_controllor
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

// 羽毛球控制模块

// 羽毛球的状态机
package badminton_state_machine;
    import main_package::*;
    typedef enum {
        Ball_state_0,
        Ball_state_1,
        Ball_state_2,
        Ball_state_3,
        Ball_state_4,
        Ball_state_5,
        Ball_state_6,
        Ball_state_7,
        Ball_state_8,
        Ball_state_9,
        Ball_state_10,
        Ball_state_11,
        Ball_state_12,
        Ball_state_13,
        Ball_state_14,
        Ball_state_15,
        Ball_state_16,
        Ball_state_17
    }badminton_state_name;
    
    typedef struct packed{
        reg[11:0] box_width; // 碰撞箱宽
        reg[11:0] box_height; // 碰撞箱高
        reg[11:0] width; // 图片宽
        reg[11:0] height; // 图片高
        reg[11:0] rom_x; // 在ROM中的位置x
        reg[11:0] rom_y; // 在ROM中的位置y
    }badminton_state;
    
    // 硬编码每一个状态
    parameter badminton_state badminton_states[18] = '{
        Ball_state_0:'{sprite_size[Ball_0][0],sprite_size[Ball_0][1],sprite_size[Ball_0][0],sprite_size[Ball_0][1],pos_in_rom[Ball_0][0],pos_in_rom[Ball_0][1]},
        Ball_state_1:'{sprite_size[Ball_2][0],sprite_size[Ball_2][1],sprite_size[Ball_2][0],sprite_size[Ball_2][1],pos_in_rom[Ball_2][0],pos_in_rom[Ball_2][1]},
        Ball_state_2:'{sprite_size[Ball_4][0],sprite_size[Ball_4][1],sprite_size[Ball_4][0],sprite_size[Ball_4][1],pos_in_rom[Ball_4][0],pos_in_rom[Ball_4][1]},
        Ball_state_3:'{sprite_size[Ball_6][0],sprite_size[Ball_6][1],sprite_size[Ball_6][0],sprite_size[Ball_6][1],pos_in_rom[Ball_6][0],pos_in_rom[Ball_6][1]},
        Ball_state_4:'{sprite_size[Ball_8][0],sprite_size[Ball_8][1],sprite_size[Ball_8][0],sprite_size[Ball_8][1],pos_in_rom[Ball_8][0],pos_in_rom[Ball_8][1]},
        Ball_state_5:'{sprite_size[Ball_10][0],sprite_size[Ball_10][1],sprite_size[Ball_10][0],sprite_size[Ball_10][1],pos_in_rom[Ball_10][0],pos_in_rom[Ball_10][1]},
        Ball_state_6:'{sprite_size[Ball_12][0],sprite_size[Ball_12][1],sprite_size[Ball_12][0],sprite_size[Ball_12][1],pos_in_rom[Ball_12][0],pos_in_rom[Ball_12][1]},
        Ball_state_7:'{sprite_size[Ball_14][0],sprite_size[Ball_14][1],sprite_size[Ball_14][0],sprite_size[Ball_14][1],pos_in_rom[Ball_14][0],pos_in_rom[Ball_14][1]},
        Ball_state_8:'{sprite_size[Ball_16][0],sprite_size[Ball_16][1],sprite_size[Ball_16][0],sprite_size[Ball_16][1],pos_in_rom[Ball_16][0],pos_in_rom[Ball_16][1]},
        Ball_state_9:'{sprite_size[Ball_18][0],sprite_size[Ball_18][1],sprite_size[Ball_18][0],sprite_size[Ball_18][1],pos_in_rom[Ball_18][0],pos_in_rom[Ball_18][1]},
        Ball_state_10:'{sprite_size[Ball_20][0],sprite_size[Ball_20][1],sprite_size[Ball_20][0],sprite_size[Ball_20][1],pos_in_rom[Ball_20][0],pos_in_rom[Ball_20][1]},
        Ball_state_11:'{sprite_size[Ball_22][0],sprite_size[Ball_22][1],sprite_size[Ball_22][0],sprite_size[Ball_22][1],pos_in_rom[Ball_22][0],pos_in_rom[Ball_22][1]},
        Ball_state_12:'{sprite_size[Ball_24][0],sprite_size[Ball_24][1],sprite_size[Ball_24][0],sprite_size[Ball_24][1],pos_in_rom[Ball_24][0],pos_in_rom[Ball_24][1]},
        Ball_state_13:'{sprite_size[Ball_26][0],sprite_size[Ball_26][1],sprite_size[Ball_26][0],sprite_size[Ball_26][1],pos_in_rom[Ball_26][0],pos_in_rom[Ball_26][1]},
        Ball_state_14:'{sprite_size[Ball_28][0],sprite_size[Ball_28][1],sprite_size[Ball_28][0],sprite_size[Ball_28][1],pos_in_rom[Ball_28][0],pos_in_rom[Ball_28][1]},
        Ball_state_15:'{sprite_size[Ball_30][0],sprite_size[Ball_30][1],sprite_size[Ball_30][0],sprite_size[Ball_30][1],pos_in_rom[Ball_30][0],pos_in_rom[Ball_30][1]},
        Ball_state_16:'{sprite_size[Ball_32][0],sprite_size[Ball_32][1],sprite_size[Ball_32][0],sprite_size[Ball_32][1],pos_in_rom[Ball_32][0],pos_in_rom[Ball_32][1]}, 
        Ball_state_17:'{sprite_size[Ball_34][0],sprite_size[Ball_34][1],sprite_size[Ball_34][0],sprite_size[Ball_34][1],pos_in_rom[Ball_34][0],pos_in_rom[Ball_34][1]} 
    };
    import playerA_move_machine::*;
    // 球左上角与手左上角的偏移量
    parameter int hand_offset_A[5][2] = '{
        Idle:'{46,56},
        Move_1:'{49,57},
        Move_2:'{33,58},
        Move_3:'{37,59},
        Move_4:'{41,59}
    };
    parameter int hand_offset_B[5][2] = '{
        Idle:'{4,57},
        Move_1:'{5,54},
        Move_2:'{5,53},
        Move_3:'{4,53},
        Move_4:'{5,53}
    };
    
    import main_package::*;
    import pat_A_state_machine::*;
    parameter patsNum = 21;
    parameter ballsNum = 18;

    // 任意球状态与拍状态碰撞后的球动态状态变化
    // standard: (v_x, v_y, a_x_cnt, a_y_cnt, is_up)
    parameter int vec_acc_info[2][patsNum][ballsNum][5] = '{
        0: '{
            Idle_1: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{8, 3, 18, 24, 1},
                Ball_state_3: '{7, 3, 18, 24, 1},
                Ball_state_4: '{7, 4, 18, 24, 1},
                Ball_state_5: '{6, 4, 18, 24, 1},
                Ball_state_6: '{6, 5, 18, 24, 1},
                Ball_state_7: '{7, 5, 16, 15, 1},
                Ball_state_8: '{9, 2, 18, 24, 0},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{8, 3, 18, 24, 1},
                Ball_state_12: '{7, 3, 18, 24, 1},
                Ball_state_13: '{7, 4, 18, 24, 1},
                Ball_state_14: '{6, 4, 18, 24, 1},
                Ball_state_15: '{6, 5, 18, 24, 1},
                Ball_state_16: '{6,4, 16, 16, 1},
                Ball_state_17: '{9, 2, 18, 24, 1}
            },    // 320 0 0
            Idle_2: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{7, 3, 18, 24, 1},
                Ball_state_3: '{6, 5, 18, 24, 1},
                Ball_state_4: '{7, 3, 18, 24, 1},
                Ball_state_5: '{6, 4, 18, 24, 1},
                Ball_state_6: '{7, 4, 18, 24, 1},
                Ball_state_7: '{8, 2, 18, 24, 1},
                Ball_state_8: '{9, 3, 18, 24, 1},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{7, 4, 18, 24, 1},
                Ball_state_12: '{6, 5, 18, 24, 1},
                Ball_state_13: '{7, 5, 18, 24, 1},
                Ball_state_14: '{7, 4, 18, 24, 1},
                Ball_state_15: '{8, 4, 18, 24, 1},
                Ball_state_16: '{9, 4, 18, 24, 1},
                Ball_state_17: '{9, 3, 18, 24, 1}
            },    // 220 0 1
            Up_1: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{9, 2, 18, 24, 1},
                Ball_state_3: '{8, 3, 18, 24, 1},
                Ball_state_4: '{7, 3, 18, 24, 1},
                Ball_state_5: '{7, 4, 18, 24, 1},
                Ball_state_6: '{6, 4, 18, 24, 1},
                Ball_state_7: '{5, 4, 18, 24, 1},
                Ball_state_8: '{7, 3, 18, 24, 1},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{9, 2, 18, 24, 1},
                Ball_state_12: '{8, 3, 18, 24, 1},
                Ball_state_13: '{7, 3, 18, 24, 1},
                Ball_state_14: '{7, 4, 18, 24, 1},
                Ball_state_15: '{6, 4, 18, 24, 1},
                Ball_state_16: '{5, 4, 18, 24, 1},
                Ball_state_17: '{6, 4, 18, 24, 1}
            },      // 340 0 2 
            Up_2: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{8, 3, 18, 24, 1},
                Ball_state_3: '{7, 3, 18, 24, 1},
                Ball_state_4: '{7, 4, 18, 24, 1},
                Ball_state_5: '{7, 4, 18, 24, 1},
                Ball_state_6: '{7, 3, 18, 24, 1},
                Ball_state_7: '{8, 3, 18, 24, 1},
                Ball_state_8: '{8, 3, 18, 24, 1},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{8, 3, 18, 24, 1},
                Ball_state_12: '{7, 3, 18, 24, 1},
                Ball_state_13: '{7, 4, 18, 24, 1},
                Ball_state_14: '{7, 4, 18, 24, 1},
                Ball_state_15: '{7, 3, 18, 24, 1},
                Ball_state_16: '{8, 3, 18, 24, 1},
                Ball_state_17: '{8, 3, 18, 24, 1}
            },      // 0 0 3
            Up_3: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{9, 2, 18, 24, 1},
                Ball_state_3: '{8, 3, 20, 22, 1},
                Ball_state_4: '{7, 4, 20, 24, 1},
                Ball_state_5: '{7, 3, 20, 24, 1},
                Ball_state_6: '{7, 4, 20, 24, 1},
                Ball_state_7: '{8, 4, 20, 24, 1},
                Ball_state_8: '{7, 3, 20, 24, 1},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{8, 3, 18, 24, 1},
                Ball_state_12: '{7, 3, 18, 24, 1},
                Ball_state_13: '{7, 4, 18, 24, 1},
                Ball_state_14: '{7, 4, 18, 24, 1},
                Ball_state_15: '{7, 4, 18, 24, 1},
                Ball_state_16: '{7, 3, 18, 24, 1},
                Ball_state_17: '{8, 3, 18, 24, 1}
            },      // 20 0 4
            Up_4: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{9, 2, 18, 24, 0},
                Ball_state_3: '{9, 2, 18, 24, 0},
                Ball_state_4: '{10, 2, 18, 24, 0},
                Ball_state_5: '{9, 3, 18, 24, 0},
                Ball_state_6: '{9, 2, 18, 24, 0},
                Ball_state_7: '{8, 2, 18, 24, 0},
                Ball_state_8: '{8, 3, 18, 24, 0},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{7, 3, 18, 24, 1},
                Ball_state_12: '{8, 3, 18, 24, 1},
                Ball_state_13: '{7, 3, 18, 24, 1},
                Ball_state_14: '{7, 4, 18, 24, 1},
                Ball_state_15: '{6, 4, 18, 24, 1},
                Ball_state_16: '{7, 4, 18, 24, 1},
                Ball_state_17: '{8, 3, 18, 24, 1}
            },      // 40 0 5
            Up_5: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{8, 3, 18, 24, 1},
                Ball_state_3: '{7, 4, 24, 24, 1},
                Ball_state_4: '{10, 2, 18, 24, 1},
                Ball_state_5: '{11, 2, 18, 24, 1},
                Ball_state_6: '{10, 3, 18, 24, 1},
                Ball_state_7: '{9, 3, 18, 24, 1},
                Ball_state_8: '{9, 2, 18, 24, 1},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{8, 3, 18, 24, 1},
                Ball_state_12: '{9, 5, 16, 18, 1},
                Ball_state_13: '{6, 5, 18, 24, 1},
                Ball_state_14: '{6, 5, 18, 24, 1},
                Ball_state_15: '{7, 5, 18, 24, 1},
                Ball_state_16: '{7, 4, 18, 24, 1},
                Ball_state_17: '{6, 4, 18, 20, 1}
            },      // 60 0 6
            Up_6: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{8, 3, 18, 24, 1},
                Ball_state_3: '{8, 4, 18, 24, 1},
                Ball_state_4: '{7, 3, 20, 20, 1},
                Ball_state_5: '{5, 5, 18, 24, 1},
                Ball_state_6: '{5, 6, 18, 24, 1},
                Ball_state_7: '{4, 6, 18, 24, 1},
                Ball_state_8: '{6, 4, 18, 24, 1},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{4, 6, 18, 24, 1},
                Ball_state_12: '{5, 6, 18, 24, 1},
                Ball_state_13: '{7, 3, 18, 24, 1},
                Ball_state_14: '{7, 3, 18, 24, 1},
                Ball_state_15: '{8, 3, 18, 24, 1},
                Ball_state_16: '{8, 3, 18, 24, 1},
                Ball_state_17: '{7, 4, 18, 24, 1}
            },      // 80 0 7
            Up_7: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{7, 4, 18, 24, 1},
                Ball_state_3: '{8, 3, 18, 24, 1},
                Ball_state_4: '{7, 4, 18, 24, 1},
                Ball_state_5: '{8, 3, 20, 20, 1},
                Ball_state_6: '{7, 4, 18, 24, 1},
                Ball_state_7: '{8, 3, 18, 24, 1},
                Ball_state_8: '{7, 4, 18, 24, 1},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{7, 4, 18, 24, 1},
                Ball_state_12: '{7, 4, 18, 24, 1},
                Ball_state_13: '{7, 4, 18, 24, 1},
                Ball_state_14: '{7, 4, 18, 24, 1},
                Ball_state_15: '{7, 4, 18, 24, 1},
                Ball_state_16: '{8, 4, 18, 24, 1},
                Ball_state_17: '{8, 3, 18, 24, 1}
            },         // 100 0 8
            Down_1: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{6, 3, 18, 24, 1},
                Ball_state_3: '{7, 3, 20, 24, 1},
                Ball_state_4: '{6, 4, 18, 24, 1},
                Ball_state_5: '{7, 4, 20, 24, 1},
                Ball_state_6: '{6, 3, 18, 24, 1},
                Ball_state_7: '{7, 3, 18, 24, 1},
                Ball_state_8: '{7, 3, 18, 24, 1},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{7, 3, 18, 24, 1},
                Ball_state_12: '{7, 3, 18, 24, 1},
                Ball_state_13: '{6, 3, 18, 24, 1},
                Ball_state_14: '{6, 4, 18, 24, 1},
                Ball_state_15: '{6, 4, 18, 24, 1},
                Ball_state_16: '{6, 3, 18, 24, 1},
                Ball_state_17: '{7, 3, 18, 24, 1}
            },    // 200 0 9
            Down_2: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{7, 4, 18, 24, 1},
                Ball_state_3: '{6, 4, 18, 24, 1},
                Ball_state_4: '{6, 5, 18, 24, 1},
                Ball_state_5: '{6, 5, 18, 24, 1},
                Ball_state_6: '{6, 4, 18, 24, 1},
                Ball_state_7: '{7, 4, 18, 24, 1},
                Ball_state_8: '{8, 3, 18, 24, 1},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{8, 3, 18, 24, 1},
                Ball_state_12: '{7, 4, 18, 24, 1},
                Ball_state_13: '{6, 4, 18, 24, 1},
                Ball_state_14: '{6, 5, 18, 24, 1},
                Ball_state_15: '{6, 5, 18, 24, 1},
                Ball_state_16: '{6, 4, 18, 24, 1},
                Ball_state_17: '{7, 4, 18, 24, 1}
            },    // 180 0 a
            Down_3: '{
                Ball_state_0: '{6, 3, 16, 18, 1},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{8, 4, 18, 24, 1},
                Ball_state_3: '{7, 5, 18, 24, 1},
                Ball_state_4: '{6, 4, 18, 24, 1},
                Ball_state_5: '{6, 4, 18, 24, 1},
                Ball_state_6: '{6, 3, 18, 24, 1},
                Ball_state_7: '{7, 4, 18, 24, 1},
                Ball_state_8: '{7, 4, 18, 16, 1},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{8, 3, 18, 24, 1},
                Ball_state_12: '{7, 3, 18, 24, 1},
                Ball_state_13: '{7, 4, 18, 24, 1},
                Ball_state_14: '{6, 4, 18, 24, 1},
                Ball_state_15: '{6, 5, 18, 24, 1},
                Ball_state_16: '{6, 4, 18, 24, 1},
                Ball_state_17: '{6, 4, 18, 24, 1}
            },    // 160 0 b
            Down_4: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{8, 3, 18, 24, 1},
                Ball_state_3: '{8, 4, 18, 24, 1},
                Ball_state_4: '{7, 4, 18, 24, 1},
                Ball_state_5: '{7, 5, 18, 24, 1},
                Ball_state_6: '{6, 5, 18, 24, 1},
                Ball_state_7: '{6, 4, 16, 16, 1},
                Ball_state_8: '{8, 3, 18, 24, 0},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{8, 3, 18, 24, 1},
                Ball_state_12: '{6, 4, 16, 16, 1},
                Ball_state_13: '{7, 4, 18, 24, 1},
                Ball_state_14: '{6, 4, 18, 24, 1},
                Ball_state_15: '{6, 4, 18, 26, 1},
                Ball_state_16: '{7, 4, 17, 22, 1},
                Ball_state_17: '{6, 5, 18, 20, 1}
            },    // 140 0 c
            Down_5: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{8, 3, 18, 24, 1},
                Ball_state_3: '{7, 3, 18, 24, 1},
                Ball_state_4: '{7, 4, 18, 24, 1},
                Ball_state_5: '{7, 3, 18, 24, 1},
                Ball_state_6: '{7, 5, 16, 16, 1},
                Ball_state_7: '{8, 3, 18, 24, 0},
                Ball_state_8: '{7, 3, 18, 24, 1},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{7, 3, 18, 24, 1},
                Ball_state_12: '{7, 4, 15, 24, 1},
                Ball_state_13: '{6, 4, 18, 30, 1},
                Ball_state_14: '{6, 4, 18, 24, 1},
                Ball_state_15: '{6, 3, 16, 20, 1},
                Ball_state_16: '{6, 4, 18, 20, 1},
                Ball_state_17: '{7, 3, 14, 22, 1}
            },    // 120 0 d
            Down_6: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{7, 4, 18, 24, 1},
                Ball_state_3: '{8, 3, 18, 24, 1},
                Ball_state_4: '{7, 4, 18, 24, 1},
                Ball_state_5: '{7, 3, 14, 20, 1},
                Ball_state_6: '{6, 4, 19, 18, 1},
                Ball_state_7: '{6, 5, 17, 16, 1},
                Ball_state_8: '{6, 4, 16, 16, 1},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{7, 4, 12, 18, 1},
                Ball_state_12: '{6, 6, 19, 18, 1},
                Ball_state_13: '{6, 4, 16, 16, 1},
                Ball_state_14: '{6, 4, 16, 16, 1},
                Ball_state_15: '{7, 4, 18, 24, 1},
                Ball_state_16: '{8, 4, 18, 24, 1},
                Ball_state_17: '{8, 3, 18, 24, 1}
            },    // 100 0 e
            Down_7: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{8, 3, 18, 24, 1},
                Ball_state_3: '{8, 4, 18, 24, 1},
                Ball_state_4: '{8, 3, 18, 24, 1},
                Ball_state_5: '{5, 5, 19, 20, 1},
                Ball_state_6: '{6, 4, 18, 24, 1},
                Ball_state_7: '{7, 3, 18, 24, 1},
                Ball_state_8: '{4, 7, 16, 12, 1},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{4, 6, 18, 24, 1},
                Ball_state_12: '{5, 6, 18, 24, 1},
                Ball_state_13: '{0, 0, 0, 0, 0},
                Ball_state_14: '{7, 3, 18, 24, 1},
                Ball_state_15: '{8, 3, 18, 24, 1},
                Ball_state_16: '{8, 3, 18, 24, 1},
                Ball_state_17: '{7, 4, 18, 24, 1}
            },    // 80 0 f
            Down_8: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{8, 3, 18, 24, 1},
                Ball_state_3: '{6, 3, 18, 24, 1},
                Ball_state_4: '{6, 4, 18, 24, 1},
                Ball_state_5: '{7, 3, 16, 22, 1},
                Ball_state_6: '{7, 5, 18, 24, 1},
                Ball_state_7: '{8, 4, 18, 24, 1},
                Ball_state_8: '{9, 2, 18, 24, 1},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{8, 3, 18, 24, 0},
                Ball_state_12: '{6, 4, 18, 24, 1},
                Ball_state_13: '{6, 5, 18, 24, 1},
                Ball_state_14: '{6, 5, 18, 24, 1},
                Ball_state_15: '{7, 5, 18, 24, 1},
                Ball_state_16: '{7, 4, 18, 24, 1},
                Ball_state_17: '{8, 4, 18, 24, 1}
            },    // 60 0 10
            Down_9: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{8, 3, 18, 24, 0},
                Ball_state_3: '{9, 4, 18, 38, 1},
                Ball_state_4: '{10, 2, 18, 24, 0},
                Ball_state_5: '{9, 3, 18, 24, 0},
                Ball_state_6: '{9, 2, 18, 24, 0},
                Ball_state_7: '{8, 2, 18, 24, 0},
                Ball_state_8: '{8, 3, 18, 24, 0},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{6, 4, 18, 24, 1},
                Ball_state_12: '{8, 3, 18, 24, 1},
                Ball_state_13: '{7, 3, 18, 24, 1},
                Ball_state_14: '{7, 4, 18, 24, 1},
                Ball_state_15: '{6, 4, 18, 24, 1},
                Ball_state_16: '{7, 4, 18, 24, 1},
                Ball_state_17: '{8, 3, 18, 24, 1}
            },    // 40 0 11
            Down_10: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{9, 3, 18, 24, 0},
                Ball_state_3: '{8, 3, 18, 24, 0},
                Ball_state_4: '{7, 4, 18, 24, 0},
                Ball_state_5: '{7, 4, 18, 24, 0},
                Ball_state_6: '{7, 4, 18, 24, 0},
                Ball_state_7: '{6, 4, 18, 24, 0},
                Ball_state_8: '{6, 3, 18, 24, 0},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{8, 3, 18, 24, 1},
                Ball_state_12: '{7, 3, 18, 24, 1},
                Ball_state_13: '{7, 4, 18, 24, 1},
                Ball_state_14: '{7, 4, 18, 24, 1},
                Ball_state_15: '{7, 4, 18, 24, 1},
                Ball_state_16: '{7, 3, 18, 24, 1},
                Ball_state_17: '{8, 3, 18, 24, 1}
            },   // 20 0 12
            Down_11: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{8, 3, 18, 24, 1},
                Ball_state_3: '{7, 3, 18, 24, 1},
                Ball_state_4: '{7, 4, 18, 24, 1},
                Ball_state_5: '{7, 4, 18, 24, 1},
                Ball_state_6: '{7, 3, 18, 24, 1},
                Ball_state_7: '{8, 3, 18, 24, 1},
                Ball_state_8: '{8, 3, 18, 24, 1},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{8, 3, 18, 24, 1},
                Ball_state_12: '{7, 3, 18, 24, 1},
                Ball_state_13: '{7, 4, 18, 24, 1},
                Ball_state_14: '{7, 4, 18, 24, 1},
                Ball_state_15: '{7, 3, 18, 24, 1},
                Ball_state_16: '{8, 3, 18, 24, 1},
                Ball_state_17: '{8, 3, 18, 24, 1}
            },   // 0 0 13
            Down_12: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{9, 2, 18, 24, 1},
                Ball_state_3: '{8, 3, 18, 24, 1},
                Ball_state_4: '{7, 3, 18, 24, 1},
                Ball_state_5: '{7, 4, 18, 24, 1},
                Ball_state_6: '{6, 4, 18, 24, 1},
                Ball_state_7: '{5, 4, 18, 24, 1},
                Ball_state_8: '{7, 4, 18, 24, 1},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{9, 2, 18, 24, 0},
                Ball_state_12: '{8, 3, 18, 24, 0},
                Ball_state_13: '{7, 3, 18, 24, 0},
                Ball_state_14: '{7, 4, 18, 24, 0},
                Ball_state_15: '{6, 4, 18, 24, 0},
                Ball_state_16: '{5, 4, 18, 24, 0},
                Ball_state_17: '{6, 4, 18, 24, 0}
            }    // 340 0 14
        },
        1: '{
            Idle_1: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{8, 3, 18, 24, 1},
                Ball_state_3: '{7, 3, 18, 24, 1},
                Ball_state_4: '{7, 4, 18, 24, 1},
                Ball_state_5: '{6, 4, 18, 24, 1},
                Ball_state_6: '{6, 5, 18, 24, 1},
                Ball_state_7: '{7, 3, 18, 24, 1},
                Ball_state_8: '{9, 2, 18, 24, 0},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{8, 3, 18, 24, 1},
                Ball_state_12: '{7, 3, 18, 24, 1},
                Ball_state_13: '{7, 4, 18, 24, 1},
                Ball_state_14: '{6, 4, 18, 24, 1},
                Ball_state_15: '{6, 5, 18, 24, 1},
                Ball_state_16: '{8, 3, 20, 24, 1},
                Ball_state_17: '{9, 2, 18, 24, 1}
            },    // 320  1 0
            Idle_2: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{6, 4, 16, 16, 1},
                Ball_state_3: '{6, 5, 18, 24, 1},
                Ball_state_4: '{7, 5, 18, 24, 1},
                Ball_state_5: '{7, 4, 18, 24, 1},
                Ball_state_6: '{8, 4, 18, 24, 1},
                Ball_state_7: '{6, 3, 18, 17, 1},
                Ball_state_8: '{8, 3, 18, 24, 1},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{7, 3, 18, 24, 1},
                Ball_state_12: '{6, 5, 18, 24, 1},
                Ball_state_13: '{7, 5, 18, 24, 1},
                Ball_state_14: '{7, 4, 18, 24, 1},
                Ball_state_15: '{8, 4, 18, 24, 1},
                Ball_state_16: '{6, 4, 18, 24, 1},
                Ball_state_17: '{7, 3, 18, 24, 1}
            },    // 220  1 1
            Up_1: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{9, 2, 18, 24, 1},
                Ball_state_3: '{8, 3, 18, 24, 1},
                Ball_state_4: '{7, 3, 18, 24, 1},
                Ball_state_5: '{7, 4, 18, 24, 1},
                Ball_state_6: '{6, 4, 18, 24, 1},
                Ball_state_7: '{5, 4, 18, 24, 1},
                Ball_state_8: '{8, 3, 16, 26, 1},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{9, 2, 18, 32, 0},
                Ball_state_12: '{8, 3, 18, 24, 1},
                Ball_state_13: '{7, 3, 18, 24, 1},
                Ball_state_14: '{7, 4, 18, 24, 1},
                Ball_state_15: '{6, 4, 18, 24, 1},
                Ball_state_16: '{5, 4, 18, 24, 1},
                Ball_state_17: '{6, 4, 18, 24, 1}
            },      // 340 1 2
            Up_2: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{8, 3, 18, 24, 1},
                Ball_state_3: '{7, 3, 18, 24, 1},
                Ball_state_4: '{7, 4, 18, 24, 1},
                Ball_state_5: '{7, 4, 18, 24, 1},
                Ball_state_6: '{7, 3, 18, 24, 1},
                Ball_state_7: '{8, 3, 18, 24, 1},
                Ball_state_8: '{8, 3, 18, 24, 1},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{8, 3, 18, 24, 1},
                Ball_state_12: '{7, 3, 18, 24, 1},
                Ball_state_13: '{7, 4, 18, 24, 1},
                Ball_state_14: '{7, 4, 18, 24, 1},
                Ball_state_15: '{7, 3, 18, 24, 1},
                Ball_state_16: '{8, 3, 18, 24, 1},
                Ball_state_17: '{8, 3, 18, 24, 1}
            },      // 0 1 3
            Up_3: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{9, 3, 16, 20, 1},
                Ball_state_3: '{8, 3, 18, 24, 1},
                Ball_state_4: '{7, 3, 18, 24, 1},
                Ball_state_5: '{7, 4, 18, 24, 1},
                Ball_state_6: '{7, 3, 18, 24, 1},
                Ball_state_7: '{8, 3, 20, 24, 1},
                Ball_state_8: '{5, 3, 24, 24, 1},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{8, 3, 18, 24, 1},
                Ball_state_12: '{7, 3, 18, 24, 1},
                Ball_state_13: '{7, 4, 18, 24, 1},
                Ball_state_14: '{7, 4, 18, 24, 1},
                Ball_state_15: '{7, 4, 18, 24, 1},
                Ball_state_16: '{7, 3, 18, 24, 1},
                Ball_state_17: '{8, 3, 18, 24, 1}
            },      // 20 1 4
            Up_4: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{7, 3, 25, 40, 1},
                Ball_state_3: '{9, 2, 18, 24, 0},
                Ball_state_4: '{10, 2, 18, 24, 1},
                Ball_state_5: '{9, 3, 18, 24, 0},
                Ball_state_6: '{9, 2, 18, 24, 0},
                Ball_state_7: '{8, 2, 18, 24, 0},
                Ball_state_8: '{8, 3, 18, 24, 0},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{6, 4, 18, 24, 1},
                Ball_state_12: '{8, 3, 18, 24, 1},
                Ball_state_13: '{7, 3, 18, 24, 1},
                Ball_state_14: '{7, 4, 18, 24, 1},
                Ball_state_15: '{6, 4, 18, 24, 1},
                Ball_state_16: '{7, 4, 18, 24, 1},
                Ball_state_17: '{8, 3, 18, 24, 1}
            },      // 40 1 5
            Up_5: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{8, 3, 18, 24, 1},
                Ball_state_3: '{9, 3 ,18, 24, 0},
                Ball_state_4: '{10, 2, 18, 24, 0},
                Ball_state_5: '{11, 2, 18, 24, 0},
                Ball_state_6: '{10, 3, 18, 24, 0},
                Ball_state_7: '{9, 3, 18, 24, 0},
                Ball_state_8: '{9, 2, 18, 24, 0},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{8, 3, 18, 24, 0},
                Ball_state_12: '{6, 4, 16, 26, 1},
                Ball_state_13: '{6, 5, 18, 24, 1},
                Ball_state_14: '{6, 5, 18, 24, 1},
                Ball_state_15: '{7, 5, 18, 24, 1},
                Ball_state_16: '{7, 4, 18, 24, 1},
                Ball_state_17: '{8, 4, 18, 24, 1}
            },      // 60 1 6
            Up_6: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{8, 3, 18, 24, 1},
                Ball_state_3: '{8, 4, 18, 24, 1},
                Ball_state_4: '{6, 4, 16, 16, 1},
                Ball_state_5: '{5, 5, 18, 24, 1},
                Ball_state_6: '{5, 6, 18, 24, 1},
                Ball_state_7: '{8, 3, 28, 35, 1},
                Ball_state_8: '{4, 6, 18, 24, 1},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{4, 6, 18, 24, 1},
                Ball_state_12: '{5, 6, 18, 24, 1},
                Ball_state_13: '{7, 3, 18, 24, 1},
                Ball_state_14: '{7, 3, 18, 24, 1},
                Ball_state_15: '{8, 3, 18, 24, 1},
                Ball_state_16: '{8, 3, 18, 24, 1},
                Ball_state_17: '{7, 4, 18, 24, 1}
            },      // 80 1 7
            Up_7: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{7, 4, 18, 24, 1},
                Ball_state_3: '{8, 3, 18, 24, 1},
                Ball_state_4: '{7, 4, 18, 24, 1},
                Ball_state_5: '{8, 3, 20, 20, 1},
                Ball_state_6: '{7, 4, 20, 22, 1},
                Ball_state_7: '{9, 3, 18, 24, 1},
                Ball_state_8: '{7, 3, 18, 24, 1},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{6, 4, 16, 17, 1},
                Ball_state_12: '{6, 4, 16, 17, 1},
                Ball_state_13: '{6, 4, 16, 17, 1},
                Ball_state_14: '{6, 4, 16, 17, 1},
                Ball_state_15: '{7, 4, 18, 24, 1},
                Ball_state_16: '{8, 4, 18, 24, 1},
                Ball_state_17: '{8, 3, 18, 24, 1}
            },         // 100 1 8
            Down_1: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{6, 3, 18, 24, 1},
                Ball_state_3: '{6, 3, 18, 24, 1},
                Ball_state_4: '{6, 4, 18, 24,1},
                Ball_state_5: '{6, 4, 18, 24, 1},
                Ball_state_6: '{6, 3, 18, 24, 1},
                Ball_state_7: '{7, 3, 18, 24, 1},
                Ball_state_8: '{7, 3, 18, 24, 1},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{7, 3, 18, 24, 1},
                Ball_state_12: '{7, 3, 18, 24, 1},
                Ball_state_13: '{6, 3, 18, 24, 1},
                Ball_state_14: '{6, 4, 18, 24, 1},
                Ball_state_15: '{6, 4, 18, 24, 1},
                Ball_state_16: '{6, 3, 18, 24, 1},
                Ball_state_17: '{7, 3, 18, 24, 1}
            },    // 200 1 9
            Down_2: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{7, 4, 18, 24, 1},
                Ball_state_3: '{6, 4, 18, 24, 1},
                Ball_state_4: '{6, 5, 18, 24, 1},
                Ball_state_5: '{6, 5, 18, 24, 1},
                Ball_state_6: '{6, 4, 18, 24, 1},
                Ball_state_7: '{7, 4, 18, 24, 1},
                Ball_state_8: '{8, 3, 18, 24, 1},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{8, 3, 18, 24, 1},
                Ball_state_12: '{7, 4, 18, 24, 1},
                Ball_state_13: '{6, 4, 18, 24, 1},
                Ball_state_14: '{6, 5, 18, 24, 1},
                Ball_state_15: '{6, 5, 18, 24, 1},
                Ball_state_16: '{6, 4, 18, 24, 1},
                Ball_state_17: '{7, 4, 18, 24, 1}
            },    // 180 1 a
            Down_3: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{8, 4, 18, 24, 1},
                Ball_state_3: '{7, 5, 18, 24, 1},
                Ball_state_4: '{6, 4, 18, 24, 1},
                Ball_state_5: '{6, 4, 18, 24, 1},
                Ball_state_6: '{6, 3, 18, 24, 1},
                Ball_state_7: '{7, 4, 18, 24, 1},
                Ball_state_8: '{7, 4, 18, 24, 1},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{7, 3, 18, 24, 1},
                Ball_state_11: '{8, 3, 18, 24, 1},
                Ball_state_12: '{7, 3, 18, 24, 1},
                Ball_state_13: '{7, 4, 18, 24, 1},
                Ball_state_14: '{6, 4, 18, 24, 1},
                Ball_state_15: '{6, 5, 18, 24, 1},
                Ball_state_16: '{6, 4, 18, 24, 1},
                Ball_state_17: '{6, 6, 18, 22, 1}
            },    // 160 1 b
            Down_4: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{8, 3, 18, 24, 1},
                Ball_state_3: '{8, 4, 18, 24, 1},
                Ball_state_4: '{7, 4, 18, 24, 1},
                Ball_state_5: '{7, 5, 18, 24, 1},
                Ball_state_6: '{6, 5, 18, 24, 1},
                Ball_state_7: '{6, 4, 16, 16, 1},
                Ball_state_8: '{8, 4, 18, 18, 1},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{7,5 , 18, 20, 1},
                Ball_state_11: '{8, 3, 18, 24, 1},
                Ball_state_12: '{7, 3, 18, 24, 1},
                Ball_state_13: '{7, 4, 18, 24, 1},
                Ball_state_14: '{6, 4, 18, 24, 1},
                Ball_state_15: '{7, 3, 18, 24, 1},
                Ball_state_16: '{6, 8, 17, 17, 1},
                Ball_state_17: '{9, 2, 18, 24, 1}
            },    // 140 1 c
            Down_5: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{8, 3, 18, 24, 1},
                Ball_state_3: '{7, 3, 18, 24, 1},
                Ball_state_4: '{7, 4, 18, 24, 1},
                Ball_state_5: '{7, 3, 18, 24, 1},
                Ball_state_6: '{6, 4, 16, 16, 1},
                Ball_state_7: '{8, 3, 18, 24, 1},
                Ball_state_8: '{7, 3, 18, 24, 1},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{7, 3, 18, 24, 1},
                Ball_state_12: '{7, 4, 18, 24, 1},
                Ball_state_13: '{6, 4, 18, 24, 1},
                Ball_state_14: '{8, 4, 16, 24, 1},
                Ball_state_15: '{6, 4, 16, 16, 1},
                Ball_state_16: '{6, 4, 18, 24, 1},
                Ball_state_17: '{9, 3, 18, 24, 1}
            },    // 120 1 d
            Down_6: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{7, 4, 18, 24, 1},
                Ball_state_3: '{8, 3, 18, 24, 1},
                Ball_state_4: '{7, 4, 18, 24, 1},
                Ball_state_5: '{6, 8, 18, 16, 1},
                Ball_state_6: '{7, 5, 16, 16, 1},
                Ball_state_7: '{6, 4, 16, 16, 1},
                Ball_state_8: '{7, 5, 16, 16, 1},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{6, 4, 16, 16, 1},
                Ball_state_12: '{6, 4, 16, 16, 1},
                Ball_state_13: '{4, 8, 30, 26, 1},
                Ball_state_14: '{6, 4, 16, 16, 1},
                Ball_state_15: '{7, 4, 18, 24, 1},
                Ball_state_16: '{8, 4, 18, 24, 1},
                Ball_state_17: '{8, 3, 18, 24, 1}
            },    // 100 1 e
            Down_7: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{8, 3, 18, 24, 1},
                Ball_state_3: '{8, 4, 18, 24, 1},
                Ball_state_4: '{7, 3, 25, 10, 1},
                Ball_state_5: '{7, 3, 18, 24, 1},
                Ball_state_6: '{7, 6, 18, 14, 1},
                Ball_state_7: '{6, 4, 20, 15, 1},
                Ball_state_8: '{6, 3, 18, 24, 1},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{4, 6, 18, 24, 1},
                Ball_state_12: '{5, 6, 18, 24, 1},
                Ball_state_13: '{6, 4, 20, 22, 1},
                Ball_state_14: '{7, 3, 18, 24, 1},
                Ball_state_15: '{8, 3, 18, 24, 1},
                Ball_state_16: '{8, 3, 18, 24, 1},
                Ball_state_17: '{7, 4, 18, 24, 1}
            },    // 80 1 f
            Down_8: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{8, 3, 18, 24, 1},
                Ball_state_3: '{7, 4, 16, 20, 1},
                Ball_state_4: '{7, 5, 18, 24, 1},
                Ball_state_5: '{4, 6, 25, 14, 1},
                Ball_state_6: '{10, 4, 12, 28, 1},
                Ball_state_7: '{8, 3, 18, 24, 1},
                Ball_state_8: '{7,5, 18, 24, 1},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{8, 3, 18, 24, 1},
                Ball_state_12: '{6, 5, 18, 24, 1},
                Ball_state_13: '{6, 5, 18, 24, 1},
                Ball_state_14: '{6, 5, 18, 24, 1},
                Ball_state_15: '{7, 5, 18, 24, 1},
                Ball_state_16: '{7, 4, 18, 24, 1},
                Ball_state_17: '{8, 4, 18, 24, 1}
            },    // 60 1 10
            Down_9: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{8, 3, 18, 24, 1},
                Ball_state_3: '{9, 2, 18, 24, 1},
                Ball_state_4: '{10, 2, 18, 24, 1},
                Ball_state_5: '{9, 3, 18, 24, 1},
                Ball_state_6: '{9, 2, 18, 24, 1},
                Ball_state_7: '{8, 2, 18, 24, 1},
                Ball_state_8: '{8, 3, 18, 24, 1},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{8, 3, 18, 24, 1},
                Ball_state_12: '{8, 3, 18, 24, 1},
                Ball_state_13: '{7, 3, 18, 24, 1},
                Ball_state_14: '{7, 4, 18, 24, 1},
                Ball_state_15: '{6, 4, 18, 24, 1},
                Ball_state_16: '{7, 4, 18, 24, 1},
                Ball_state_17: '{8, 3, 18, 24, 1}
            },    // 40 1 11
            Down_10: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{9, 3, 18, 24, 1},
                Ball_state_3: '{8, 3, 18, 24, 1},
                Ball_state_4: '{9, 4, 18, 22, 1},
                Ball_state_5: '{10, 4, 12, 20, 1},
                Ball_state_6: '{6, 5, 18, 24, 1},
                Ball_state_7: '{6, 4, 18, 24, 1},
                Ball_state_8: '{6, 3, 18, 24, 1},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{8, 3, 18, 24, 1},
                Ball_state_12: '{7, 3, 18, 24, 1},
                Ball_state_13: '{7, 4, 18, 24, 1},
                Ball_state_14: '{7, 4, 18, 24, 1},
                Ball_state_15: '{7, 4, 18, 24, 1},
                Ball_state_16: '{7, 3, 18, 24, 1},
                Ball_state_17: '{8, 3, 18, 24, 1}
            },   // 20 1 12
            Down_11: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{8, 3, 18, 24, 1},
                Ball_state_3: '{7, 3, 18, 24, 1},
                Ball_state_4: '{7, 4, 18, 24, 1},
                Ball_state_5: '{7, 4, 18, 24, 1},
                Ball_state_6: '{7, 3, 18, 24, 1},
                Ball_state_7: '{8, 3, 18, 24, 1},
                Ball_state_8: '{8, 3, 18, 24, 1},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{8, 3, 18, 24, 1},
                Ball_state_12: '{7, 3, 18, 24, 1},
                Ball_state_13: '{7, 4, 18, 24, 1},
                Ball_state_14: '{7, 4, 18, 24, 1},
                Ball_state_15: '{7, 3, 18, 24, 1},
                Ball_state_16: '{8, 3, 18, 24, 1},
                Ball_state_17: '{8, 3, 18, 24, 1}
            },   // 0 1 13
            Down_12: '{
                Ball_state_0: '{0, 0, 0, 0, 0},
                Ball_state_1: '{0, 0, 0, 0, 0},
                Ball_state_2: '{9, 2, 18, 24, 1},
                Ball_state_3: '{8, 3, 18, 24, 1},
                Ball_state_4: '{7, 3, 18, 24, 1},
                Ball_state_5: '{7, 4, 18, 24, 1},
                Ball_state_6: '{6, 4, 18, 24, 1},
                Ball_state_7: '{5, 4, 18, 24, 1},
                Ball_state_8: '{6, 4, 16, 16, 1},
                Ball_state_9: '{0, 0, 0, 0, 0},
                Ball_state_10: '{0, 0, 0, 0, 0},
                Ball_state_11: '{9, 2, 18, 24, 1},
                Ball_state_12: '{8, 3, 18, 24, 1},
                Ball_state_13: '{7, 3, 18, 24, 1},
                Ball_state_14: '{7, 4, 18, 24, 1},
                Ball_state_15: '{6, 4, 18, 24, 1},
                Ball_state_16: '{5, 4, 18, 24, 1},
                Ball_state_17: '{6, 5, 20, 22, 1}
            }    // 340 1 14
        }
    };
endpackage

import collision::collision_box;
import main_package::element_pos_size_rom;
import badminton_state_machine::*;
import playerA_move_machine::playerA_move_states_name;
import playerB_move_machine::playerB_move_states_name;
import pat_A_state_machine::*;
import pat_B_state_machine::*;
module badminton_controllor(
        input wire clk,
        input wire rst_n,
        input wire gamingA, // A是否开始游戏
        input wire gamingB, // B是否开始游戏 
        input wire write_finished, // 上一帧是否读完
        input element_pos_size_rom playerA, // A的信息
        input element_pos_size_rom playerB, // B的信息
        input collision_box playerA_pat, // A拍的碰撞箱、方向
        input wire patA_up,
        input wire patA_down,
        input collision_box playerB_pat, // B拍的碰撞箱、方向
        input wire patB_up,
        input wire patB_down,
        input collision_box net, // 网碰撞箱
        input playerA_move_states_name playerA_state, // A的状态
        input playerB_move_states_name playerB_state, // B的状态
        input restart, // ESC
        input pat_A_state_name pat_A_curr_state_name, // 拍A的状态名
        input pat_B_state_name pat_B_curr_state_name, // 拍B的状态名
        output badminton_state badminton, // 球状态
        output reg [11:0] badminton_x, // 球的位置
        output reg [11:0] badminton_y,
        output reg player1_add_score, // 是否得分
        output reg player2_add_score,
        output reg ball_finished, // 是否结束
        output reg[11:0] record_x[20:0], // 球的运动轨迹记录
        output reg[11:0] record_y[20:0], 
        output wire show_bling, // 是否粒子效果
        output badminton_state_name badminton_curr_state_name,
        output reg[7:0] check_pat_A, // 拍A状态名（击打变化后）
        output reg[7:0] check_pat_B // 拍B状态名（击打变化后）
    );
    import collision::*;
    import badminton_state_machine::*;
    import main_package::*;
    collision_box badminton_collision;
    badminton_state_name curr_state,next_state;
    // 40,670
    assign badminton_collision = '{badminton.width,badminton.height,badminton_x,badminton_y};
    parameter offset_x = 12'd50;
    parameter offset_y = 12'd50;
    parameter move_count = 0;
    reg[8:0] acceleration_x_count;
    reg[8:0] acceleration_y_count;
    
    reg playerA_start,playerB_start;
    wire gaming;
    assign gaming = (playerB_start&gamingB)|((!playerB_start)&gamingA);
    assign show_bling = (playerB_start&gamingB)|((!playerB_start)&gamingA);
    reg [11:0] velosity_x;
    reg [11:0] velosity_y;
    reg is_up;
    reg is_right;
    reg [3:0] move_record;
    reg [8:0] acceleration_record;
    reg collide_net;
    reg mid_right;
    reg mid_up;
    reg patA_up_record,patA_down_record,patB_up_record,patB_down_record;
    
    reg patA_lock,patB_lock;
    
    // 轨迹记录状态机
    always_ff@(posedge clk)begin
        if(rst_n || !gaming)begin
            for(int i = 0;i<21;i++)begin
                record_x[i] <= 12'd0;
                record_y[i] <= 12'd0;
            end
        end
        else begin
            if(write_finished)begin
                for(int i = 0;i<20;i++)begin
                    record_x[i] <= record_x[i+1];
                    record_y[i] <= record_y[i+1];
                end
                record_x[20] <= badminton_x;
                record_y[20] <= badminton_y;
            end
        end 
    end

    // 重要状态机，承担了绝大部分的判断，主要是球的轨迹、物理碰撞、记分
    always_ff@(posedge clk)begin
        if(rst_n)begin
            if((!ball_finished) || restart)begin
                playerA_start <= 1;
                playerB_start <= 0;
            end
            mid_right <= 0;
            mid_up <= 0;
            move_record <= 0;
            acceleration_record <= 0;
            velosity_x <= 0;
            velosity_y <= 0;
            is_up <= 0;
            ball_finished <= 0;
            collide_net <= 0;
            player1_add_score = 0;
            player2_add_score = 0;
            patA_lock <= 0;
            patB_lock <= 0;
            acceleration_y_count <= 16;
            acceleration_x_count <= 16;
        end
        else begin
            if(gaming)begin
                if(patA_up && !patA_lock)begin
                    patA_up_record = 1;
                    patA_down_record = 0;
                end
                else if(patA_down && !patA_lock)begin
                    patA_up_record = 0;
                    patA_down_record = 1;
                end
                else if(patB_up && !patB_lock)begin
                    patB_up_record = 1;
                    patB_down_record = 0;
                end
                else if(patB_down && !patB_lock)begin
                    patB_up_record = 0;
                    patB_down_record = 1;
                end
                
                if(is_collided(badminton_collision,playerA_pat) && !patA_lock)begin
                    //角度判断
                    //初始速度和初始角度给予
                    patA_lock = 1;
                    patB_lock = 0;
                    badminton_curr_state_name <= curr_state;
                    check_pat_A <= pat_A_curr_state_name;
                    if(patA_up_record)begin
                        is_right = 1;
                        velosity_x = vec_acc_info[0][pat_A_curr_state_name][curr_state][0];
                        velosity_y = vec_acc_info[0][pat_A_curr_state_name][curr_state][1];
                        acceleration_x_count = vec_acc_info[0][pat_A_curr_state_name][curr_state][2];
                        acceleration_y_count = vec_acc_info[0][pat_A_curr_state_name][curr_state][3];
                        is_up = vec_acc_info[0][pat_A_curr_state_name][curr_state][4];
                        if(playerA_pat.screen_y<badminton_y && badminton_y-playerA_pat.screen_y > 10)begin
                            velosity_x = 4'd10;
                            velosity_y = 4'd1;
                            is_right = 1;
                            is_up = 0;
                            acceleration_x_count = 20;
                            acceleration_y_count = 28;
                        end
                    end
                    else if(patA_down_record)begin
                        is_right = 1;
                        velosity_x = vec_acc_info[0][pat_A_curr_state_name][curr_state][0];
                        velosity_y = vec_acc_info[0][pat_A_curr_state_name][curr_state][1];
                        acceleration_x_count = vec_acc_info[0][pat_A_curr_state_name][curr_state][2];
                        acceleration_y_count = vec_acc_info[0][pat_A_curr_state_name][curr_state][3];
                        is_up = vec_acc_info[0][pat_A_curr_state_name][curr_state][4];
                    end
                end
                else if(is_collided(badminton_collision,playerB_pat) && !patB_lock)begin
                    badminton_curr_state_name <= curr_state;
                    check_pat_B <= pat_B_curr_state_name;
                    patA_lock = 0;
                    patB_lock = 1;
                    if(patB_up_record)begin
                        is_right = 0;
                        velosity_x = vec_acc_info[1][pat_B_curr_state_name][curr_state][0];
                        velosity_y = vec_acc_info[1][pat_B_curr_state_name][curr_state][1];
                        acceleration_x_count = vec_acc_info[1][pat_B_curr_state_name][curr_state][2];
                        acceleration_y_count = vec_acc_info[1][pat_B_curr_state_name][curr_state][3];
                        is_up = vec_acc_info[1][pat_B_curr_state_name][curr_state][4];
                        if(playerB_pat.screen_y<badminton_y && badminton_y-playerB_pat.screen_y > 10)begin
                            velosity_x = 4'd10;
                            velosity_y = 4'd1;
                            is_right = 0;
                            is_up = 0;
                            acceleration_x_count = 20;
                            acceleration_y_count = 28;
                        end
                    end
                    else if(patB_down_record)begin
                        is_right = 0;
                        velosity_x = vec_acc_info[1][pat_B_curr_state_name][curr_state][0];
                        velosity_y = vec_acc_info[1][pat_B_curr_state_name][curr_state][1];
                        acceleration_x_count = vec_acc_info[1][pat_B_curr_state_name][curr_state][2];
                        acceleration_y_count = vec_acc_info[1][pat_B_curr_state_name][curr_state][3];
                        is_up = vec_acc_info[1][pat_B_curr_state_name][curr_state][4];
                    end
                end
                else if(is_collided(badminton_collision,net) && !collide_net) begin
                    is_right = ~is_right;
                    collide_net = 1;
                    velosity_x = 2;
                    // 需要进行一些弹射，并出范围.
                end
                else if((badminton_x >= 650 || badminton_x <= 45) && !mid_right)begin
                    is_right = ~is_right;
                    mid_right <= 1;
                end
                else if(badminton_y >= 485 && !mid_up)begin
                    is_up = ~is_up;
                    mid_up <= 1;
                    if(velosity_x > 2)begin
                        velosity_x <= velosity_x-2;
                    end
                    else if(velosity_x>0)begin
                        velosity_x <= velosity_x-1;
                    end
                    velosity_y = 1;
                end
                //运动过程，速度衰减,角度转变
                //触网判断
                //触地判断
                //胜负判断
                if(write_finished)begin
                    curr_state <= next_state;
                    player1_add_score <= 0;
                    player2_add_score <= 0;
                    if(acceleration_record<acceleration_x_count)begin
                        acceleration_record <= acceleration_record+1;
                    end
                    else begin
                        acceleration_record <= 0;
                        if(velosity_x > 2)begin
                            if(mid_right && velosity_x > 3)begin
                                velosity_x <= velosity_x - 3;
                            end
                            else begin
                                velosity_x <= velosity_x - 1;
                            end
                        end
                        if(velosity_y > 0 && is_up && !mid_up)begin
                            velosity_y <= velosity_y - 1;
                            mid_up <= 0;
                        end
                        else begin
                            is_up <= 0;
                            mid_up <= 0;
                            velosity_y <= velosity_y + 1;
                        end
                    end
                    if(badminton_y < 485 || velosity_x > 0) begin
                        if(move_record < move_count)begin
                            move_record <= move_record+1;
                        end
                        else begin
                            move_record <= 0;
                            if(is_right)begin
                                if(!(badminton_x >=648 || badminton_x <= 47))begin
                                    mid_right <= 0;
                                end
                                if(!is_collided(badminton_collision,net))begin
                                    collide_net <= 0;
                                end
                                badminton_x <= badminton_x + velosity_x;
                            end
                            else begin
                                if(!(badminton_x >=648 || badminton_x <= 47))begin
                                    mid_right <= 0;
                                end
                                if(!is_collided(badminton_collision,net))begin
                                    collide_net <= 0;
                                end
                                badminton_x <= badminton_x - velosity_x;
                            end
                            if(is_up)begin
                                badminton_y <= badminton_y - velosity_y;
                            end
                            else begin
                                badminton_y <= badminton_y + velosity_y;
                            end
                        end
                    end
                    else begin
                        velosity_x <= 0;
                        velosity_y <= 0;
                        if(badminton_x < 355)begin
                            player2_add_score <= 1;
                            player1_add_score <= 0;
                            ball_finished <= 1;
                            playerB_start <= 1;
                            playerA_start <= 0;
                        end
                        else begin
                            player1_add_score <= 1;
                            player2_add_score <= 0;
                            ball_finished <= 1;
                            playerB_start <= 0;
                            playerA_start <= 1;
                        end
                    end
                end
            end
            else begin
                if(!playerB_start)begin
                    curr_state <= Ball_state_17;
                    badminton_x <= playerA.x + hand_offset_A[playerA_state][0]-5;
                    badminton_y <= playerA.y + hand_offset_A[playerA_state][1]-3;
                end
                else begin
                    curr_state <= Ball_state_2;
                    badminton_x <= playerB.x + hand_offset_B[playerB_state][0]-8;
                    badminton_y <= playerB.y + hand_offset_B[playerB_state][1]-3;
                end
            end
        end
    end
    
    parameter change_picture_count = 32'd5000000;
    reg [31:0] change_picture_record;
    // 球的状态切换 状态机
    always_ff@(posedge clk)begin
        if(rst_n)begin
            change_picture_record <= 0;
        end
        else begin
            if(gaming)begin
                if(change_picture_record < change_picture_count)begin
                   change_picture_record <= change_picture_record + 1;
                end
                else begin
                    change_picture_record <= 0;
                    if(is_right)begin
                        case(curr_state)
                            Ball_state_17: next_state <= Ball_state_11;
                            Ball_state_11: next_state <= Ball_state_12;
                            Ball_state_12: next_state <= Ball_state_13;
                            Ball_state_13: next_state <= Ball_state_14;
                            Ball_state_14: next_state <= Ball_state_15;
                            Ball_state_15: next_state <= Ball_state_16;
                            Ball_state_16: next_state <= Ball_state_16;
                            default: next_state <= Ball_state_17;
                        endcase
                    end
                    else begin
                        case(curr_state)
                            Ball_state_2: next_state <= Ball_state_8;
                            Ball_state_8: next_state <= Ball_state_7;
                            Ball_state_7: next_state <= Ball_state_6;
                            Ball_state_6: next_state <= Ball_state_5;
                            Ball_state_5: next_state <= Ball_state_4;
                            Ball_state_4: next_state <= Ball_state_3;
                            Ball_state_3: next_state <= Ball_state_3; 
                            default: next_state <= Ball_state_2;
                        endcase
                    end
               end
            end
        end
    end
    
    assign badminton = badminton_states[curr_state];
    
endmodule
