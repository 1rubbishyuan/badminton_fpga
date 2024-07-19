`timescale 1ns / 1ps

// ��ģ��

// ����
package main_package;
    // Ԫ��ö����
    typedef enum {
        PlayerA,
        PlayerA_move1,
        PlayerA_move2,
        PlayerA_move3,
        PlayerA_move4,
        PlayerB,
        PlayerB_move1,
        PlayerB_move2,
        PlayerB_move3,
        PlayerB_move4,
        Zero,
        One,
        Two,
        Three,
        Four,
        Five,
        Six,
        Seven,
        Eight,
        Nine,
        Net,
        Ball_0,
        Ball_2,
        Ball_4,
        Ball_6,
        Ball_8,
        Ball_10,
        Ball_12,
        Ball_14,
        Ball_16,
        Ball_18,
        Ball_20,
        Ball_22,
        Ball_24,
        Ball_26,
        Ball_28,
        Ball_30,
        Ball_32,
        Ball_34,
        Pat_0,
        Pat_2,
        Pat_4,
        Pat_6,
        Pat_8,
        Pat_10,
        Pat_12,
        Pat_14,
        Pat_16,
        Pat_18,
        Pat_20,
        Pat_22,
        Pat_24,
        Pat_26,
        Pat_28,
        Pat_30,
        Pat_32,
        Pat_34,
        PlayerA_win,
        PlayerB_win
    } sprites;
    
    // ��ͼ������Ϣ
    typedef struct packed{
        reg [11:0] x;   // ��Ļλ��
        reg [11:0] y;
        reg [11:0] width; // ��С
        reg [11:0] height; 
        reg [11:0] rom_x; // ROM�е�λ��
        reg [11:0] rom_y;
    } element_pos_size_rom;
    
    parameter Sprite_types = 59 ;
    parameter Rend_number = 11;
    parameter int enum_to_index[Sprite_types]='{
        PlayerA:0,
        PlayerA_move1:1,
        PlayerA_move2:2,
        PlayerA_move3:3,
        PlayerA_move4:4,
        PlayerB:5,
        PlayerB_move1:6,
        PlayerB_move2:7,
        PlayerB_move3:8,
        PlayerB_move4:9,
        Zero:10,
        One:11,
        Two:12,
        Three:13,
        Four:14,
        Five:15,
        Six:16,
        Seven:17,
        Eight:18,
        Nine:19,
        Net:20,
        Ball_0:21,
        Ball_2:22,
        Ball_4:23,
        Ball_6:24,
        Ball_8:25,
        Ball_10:26,
        Ball_12:27,
        Ball_14:28,
        Ball_16:29,
        Ball_18:30,
        Ball_20:31,
        Ball_22:32,
        Ball_24:33,
        Ball_26:34,
        Ball_28:35,
        Ball_30:36,
        Ball_32:37,
        Ball_34:38,
        Pat_0:39,
        Pat_2:40,
        Pat_4:41,
        Pat_6:42,
        Pat_8:43,
        Pat_10:44,
        Pat_12:45,
        Pat_14:46,
        Pat_16:47,
        Pat_18:48,
        Pat_20:49,
        Pat_22:50,
        Pat_24:51,
        Pat_26:52,
        Pat_28:53,
        Pat_30:54,
        Pat_32:55,
        Pat_34:56,
        PlayerA_win:57,
        PlayerB_win:58
    };

    // ROM��λ�ò�ѯ��
    parameter int pos_in_rom[Sprite_types][2] = '{
        PlayerA:'{5,50},
        PlayerA_move1:'{70,50},
        PlayerA_move2:'{130,50},
        PlayerA_move3:'{190,50},
        PlayerA_move4:'{255,50},
        PlayerB:'{5,160},
        PlayerB_move1:'{72,160},
        PlayerB_move2:'{137,160},
        PlayerB_move3:'{202,160},
        PlayerB_move4:'{267,160},
        Zero:'{0,5},
        One:'{20,5},
        Two:'{40,5},
        Three:'{60,5},
        Four:'{80,5},
        Five:'{100,5},
        Six:'{120,5},
        Seven:'{140,5},
        Eight:'{160,5},
        Nine:'{180,5},
        Net:'{335,70},
        Ball_0:'{5,290},
        Ball_2:'{35,291},
        Ball_4:'{65,290},
        Ball_6:'{95,290},
        Ball_8:'{125,290},
        Ball_10:'{155,290},
        Ball_12:'{185,290},
        Ball_14:'{215,290},
        Ball_16:'{245,290},
        Ball_18:'{5,320},
        Ball_20:'{35,320},
        Ball_22:'{65,320},
        Ball_24:'{95,320},
        Ball_26:'{125,320},
        Ball_28:'{155,320},
        Ball_30:'{185,320},
        Ball_32:'{215,320},
        Ball_34:'{245,320},
        Pat_0:'{5,350},
        Pat_2:'{24,350},
        Pat_4:'{60,350},
        Pat_6:'{120,345},
        Pat_8:'{120,400},
        Pat_10:'{210,345},
        Pat_12:'{210,375},
        Pat_14:'{300,290},
        Pat_16:'{5,445},
        Pat_18:'{45,440},
        Pat_20:'{65,445},
        Pat_22:'{105,430},
        Pat_24:'{295,380},
        Pat_26:'{105,505},
        Pat_28:'{205,429},
        Pat_30:'{210,460},
        Pat_32:'{300,440},
        Pat_34:'{360,430},
        PlayerA_win:'{202,540},
        PlayerB_win:'{8,540}
    };
    
    // ��ͼ�ߴ��
    parameter int sprite_size[Sprite_types][2]='{
        PlayerA:'{52,100},
        PlayerA_move1:'{58,100},
        PlayerA_move2:'{52,100},
        PlayerA_move3:'{52,100},
        PlayerA_move4:'{56,100},
        PlayerB:'{54,120},
        PlayerB_move1:'{52,120},
        PlayerB_move2:'{52,120},
        PlayerB_move3:'{52,120},
        PlayerB_move4:'{52,120},
        Zero:'{17,27},
        One:'{4,27},
        Two:'{17,27},
        Three:'{17,27},
        Four:'{17,27},
        Five:'{17,27},
        Six:'{17,27},
        Seven:'{18,27},
        Eight:'{17,27},
        Nine:'{17,27},
        Net:'{33,165},
        Ball_0:'{20,22},
        Ball_2:'{20,19},
        Ball_4:'{20,20},
        Ball_6:'{20,22},
        Ball_8:'{20,20},
        Ball_10:'{20,20},
        Ball_12:'{20,19},
        Ball_14:'{20,22},
        Ball_16:'{20,20},
        Ball_18:'{20,20},
        Ball_20:'{20,20},
        Ball_22:'{20,20},
        Ball_24:'{22,20},
        Ball_26:'{22,20},
        Ball_28:'{20,20},
        Ball_30:'{24,20},
        Ball_32:'{20,20},
        Ball_34:'{20,20},
        Pat_0:'{16,91},
        Pat_2:'{37,86},
        Pat_4:'{61,71},
        Pat_6:'{79,49},
        Pat_8:'{90,24},
        Pat_10:'{90,25},
        Pat_12:'{80,50},
        Pat_14:'{61,71},
        Pat_16:'{37,85},
        Pat_18:'{16,91},
        Pat_20:'{38,86},
        Pat_22:'{61,72},
        Pat_24:'{80,49},
        Pat_26:'{89,23},
        Pat_28:'{90,25},
        Pat_30:'{80,50},
        Pat_32:'{60,72},
        Pat_34:'{36,86},
        PlayerA_win:'{200,135},
        PlayerB_win:'{200,135}
    };

    parameter playersNum = 10;
    parameter patsNum = 18;
    parameter armbias_index_bias = enum_to_index[Pat_0];

    // ��ͬ���״̬����״̬֮�䣬ͼƬ��ƫ����
    parameter int armbias[playersNum][patsNum][2] = '{
        PlayerA: '{
            Pat_0 - armbias_index_bias:'{13, -46},
            Pat_2 - armbias_index_bias:'{21, -38},
            Pat_4 - armbias_index_bias:'{22, -25},
            Pat_6 - armbias_index_bias:'{21, -4},
            Pat_8 - armbias_index_bias:'{19, 21},
            Pat_10 - armbias_index_bias:'{19, 35},
            Pat_12 - armbias_index_bias:'{19, 36},
            Pat_14 - armbias_index_bias:'{18, 36},
            Pat_16 - armbias_index_bias:'{19, 35},
            Pat_18 - armbias_index_bias:'{16, 34},
            Pat_20 - armbias_index_bias:'{-8, 35},
            Pat_22 - armbias_index_bias:'{-33, 34},
            Pat_24 - armbias_index_bias:'{-51, 35},
            Pat_26 - armbias_index_bias:'{-59, 35},
            Pat_28 - armbias_index_bias:'{-58, 19},
            Pat_30 - armbias_index_bias:'{-49, -7},
            Pat_32 - armbias_index_bias:'{-29, -28},
            Pat_34 - armbias_index_bias:'{-17, -42}
        },
        PlayerA_move1:'{
            Pat_0 - armbias_index_bias:'{20, -46},
            Pat_2 - armbias_index_bias:'{28, -38},
            Pat_4 - armbias_index_bias:'{29, -25},
            Pat_6 - armbias_index_bias:'{28, -4},
            Pat_8 - armbias_index_bias:'{26, 21},
            Pat_10 - armbias_index_bias:'{26, 35},
            Pat_12 - armbias_index_bias:'{26, 36},
            Pat_14 - armbias_index_bias:'{25, 36},
            Pat_16 - armbias_index_bias:'{26, 35},
            Pat_18 - armbias_index_bias:'{23, 34},
            Pat_20 - armbias_index_bias:'{-1, 35},
            Pat_22 - armbias_index_bias:'{-26, 34},
            Pat_24 - armbias_index_bias:'{-44, 35},
            Pat_26 - armbias_index_bias:'{-52, 35},
            Pat_28 - armbias_index_bias:'{-51, 19},
            Pat_30 - armbias_index_bias:'{-42, -7},
            Pat_32 - armbias_index_bias:'{-22, -28},
            Pat_34 - armbias_index_bias:'{-10, -42}
        },
        PlayerA_move2:'{
            Pat_0 - armbias_index_bias:'{13, -46},
            Pat_2 - armbias_index_bias:'{9, -38},
            Pat_4 - armbias_index_bias:'{22, -25},
            Pat_6 - armbias_index_bias:'{21, -4},
            Pat_8 - armbias_index_bias:'{19, 21},
            Pat_10 - armbias_index_bias:'{19, 35},
            Pat_12 - armbias_index_bias:'{19, 36},
            Pat_14 - armbias_index_bias:'{18, 36},
            Pat_16 - armbias_index_bias:'{19, 35},
            Pat_18 - armbias_index_bias:'{16, 34},
            Pat_20 - armbias_index_bias:'{-8, 35},
            Pat_22 - armbias_index_bias:'{-33, 34},
            Pat_24 - armbias_index_bias:'{-51, 35},
            Pat_26 - armbias_index_bias:'{-59, 35},
            Pat_28 - armbias_index_bias:'{-58, 19},
            Pat_30 - armbias_index_bias:'{-49, -7},
            Pat_32 - armbias_index_bias:'{-29, -28},
            Pat_34 - armbias_index_bias:'{-17, -42}
        },
        PlayerA_move3:'{
            Pat_0 - armbias_index_bias:'{14, -46},
            Pat_2 - armbias_index_bias:'{22, -38},
            Pat_4 - armbias_index_bias:'{23, -25},
            Pat_6 - armbias_index_bias:'{22, -4},
            Pat_8 - armbias_index_bias:'{20, 21},
            Pat_10 - armbias_index_bias:'{20, 35},
            Pat_12 - armbias_index_bias:'{20, 36},
            Pat_14 - armbias_index_bias:'{19, 36},
            Pat_16 - armbias_index_bias:'{20, 35},
            Pat_18 - armbias_index_bias:'{17, 34},
            Pat_20 - armbias_index_bias:'{-1, 35},
            Pat_22 - armbias_index_bias:'{-32, 34},
            Pat_24 - armbias_index_bias:'{-50, 35},
            Pat_26 - armbias_index_bias:'{-58, 35},
            Pat_28 - armbias_index_bias:'{-57, 19},
            Pat_30 - armbias_index_bias:'{-48, -7},
            Pat_32 - armbias_index_bias:'{-28, -28},
            Pat_34 - armbias_index_bias:'{-16, -42}
        },
        PlayerA_move4:'{
            Pat_0 - armbias_index_bias:'{20, -46},
            Pat_2 - armbias_index_bias:'{28, -38},
            Pat_4 - armbias_index_bias:'{29, -25},
            Pat_6 - armbias_index_bias:'{28, -4},
            Pat_8 - armbias_index_bias:'{26, 21},
            Pat_10 - armbias_index_bias:'{26, 35},
            Pat_12 - armbias_index_bias:'{26, 36},
            Pat_14 - armbias_index_bias:'{25, 36},
            Pat_16 - armbias_index_bias:'{26, 35},
            Pat_18 - armbias_index_bias:'{23, 34},
            Pat_20 - armbias_index_bias:'{-1, 35},
            Pat_22 - armbias_index_bias:'{-26, 34},
            Pat_24 - armbias_index_bias:'{-44, 35},
            Pat_26 - armbias_index_bias:'{-52, 35},
            Pat_28 - armbias_index_bias:'{-51, 19},
            Pat_30 - armbias_index_bias:'{-42, -7},
            Pat_32 - armbias_index_bias:'{-22, -28},
            Pat_34 - armbias_index_bias:'{-10, -42}
        },
        PlayerB:'{            
            Pat_0 - armbias_index_bias:'{16, -52},
            Pat_2 - armbias_index_bias:'{24, -44},
            Pat_4 - armbias_index_bias:'{25, -31},
            Pat_6 - armbias_index_bias:'{24, -10},
            Pat_8 - armbias_index_bias:'{22, 15},
            Pat_10 - armbias_index_bias:'{22, 29},
            Pat_12 - armbias_index_bias:'{22, 30},
            Pat_14 - armbias_index_bias:'{21, 30},
            Pat_16 - armbias_index_bias:'{22, 27},
            Pat_18 - armbias_index_bias:'{29, 28},
            Pat_20 - armbias_index_bias:'{-5, 29},
            Pat_22 - armbias_index_bias:'{-30, 28},
            Pat_24 - armbias_index_bias:'{-48, 29},
            Pat_26 - armbias_index_bias:'{-56, 29},
            Pat_28 - armbias_index_bias:'{-55, 13},
            Pat_30 - armbias_index_bias:'{-46, -13},
            Pat_32 - armbias_index_bias:'{-26, -34},
            Pat_34 - armbias_index_bias:'{-16, -48}
        },
        PlayerB_move1:'{            
            Pat_0 - armbias_index_bias:'{10, -52},
            Pat_2 - armbias_index_bias:'{18, -44},
            Pat_4 - armbias_index_bias:'{19, -31},
            Pat_6 - armbias_index_bias:'{18, -10},
            Pat_8 - armbias_index_bias:'{16, 15},
            Pat_10 - armbias_index_bias:'{16, 29},
            Pat_12 - armbias_index_bias:'{16, 30},
            Pat_14 - armbias_index_bias:'{15, 30},
            Pat_16 - armbias_index_bias:'{16, 27},
            Pat_18 - armbias_index_bias:'{13, 28},
            Pat_20 - armbias_index_bias:'{-11, 29},
            Pat_22 - armbias_index_bias:'{-36, 28},
            Pat_24 - armbias_index_bias:'{-54, 29},
            Pat_26 - armbias_index_bias:'{-62, 29},
            Pat_28 - armbias_index_bias:'{-61, 13},
            Pat_30 - armbias_index_bias:'{-52, -13},
            Pat_32 - armbias_index_bias:'{-32, -34},
            Pat_34 - armbias_index_bias:'{-20, -48}
        },
        PlayerB_move2:'{            
            Pat_0 - armbias_index_bias:'{10, -54},
            Pat_2 - armbias_index_bias:'{18, -46},
            Pat_4 - armbias_index_bias:'{19, -33},
            Pat_6 - armbias_index_bias:'{18, -12},
            Pat_8 - armbias_index_bias:'{16, 13},
            Pat_10 - armbias_index_bias:'{16, 27},
            Pat_12 - armbias_index_bias:'{16, 28},
            Pat_14 - armbias_index_bias:'{15, 28},
            Pat_16 - armbias_index_bias:'{16, 27},
            Pat_18 - armbias_index_bias:'{13, 26},
            Pat_20 - armbias_index_bias:'{-11, 27},
            Pat_22 - armbias_index_bias:'{-36, 26},
            Pat_24 - armbias_index_bias:'{-54, 27},
            Pat_26 - armbias_index_bias:'{-62, 27},
            Pat_28 - armbias_index_bias:'{-61, 11},
            Pat_30 - armbias_index_bias:'{-52, -15},
            Pat_32 - armbias_index_bias:'{-32, -36},
            Pat_34 - armbias_index_bias:'{-20, -50}
        },
        PlayerB_move3:'{            
            Pat_0 - armbias_index_bias:'{9, -54},
            Pat_2 - armbias_index_bias:'{17, -46},
            Pat_4 - armbias_index_bias:'{18, -33},
            Pat_6 - armbias_index_bias:'{17, -12},
            Pat_8 - armbias_index_bias:'{15, 13},
            Pat_10 - armbias_index_bias:'{15, 27},
            Pat_12 - armbias_index_bias:'{15, 28},
            Pat_14 - armbias_index_bias:'{14, 28},
            Pat_16 - armbias_index_bias:'{15, 27},
            Pat_18 - armbias_index_bias:'{12, 26},
            Pat_20 - armbias_index_bias:'{-12, 27},
            Pat_22 - armbias_index_bias:'{-37, 26},
            Pat_24 - armbias_index_bias:'{-55, 27},
            Pat_26 - armbias_index_bias:'{-63, 27},
            Pat_28 - armbias_index_bias:'{-62, 11},
            Pat_30 - armbias_index_bias:'{-53, -15},
            Pat_32 - armbias_index_bias:'{-33, -36},
            Pat_34 - armbias_index_bias:'{-21, -50}
        },
        PlayerB_move4:'{            
            Pat_0 - armbias_index_bias:'{10, -54},
            Pat_2 - armbias_index_bias:'{18, -46},
            Pat_4 - armbias_index_bias:'{19, -33},
            Pat_6 - armbias_index_bias:'{18, -12},
            Pat_8 - armbias_index_bias:'{16, 13},
            Pat_10 - armbias_index_bias:'{16, 27},
            Pat_12 - armbias_index_bias:'{16, 28},
            Pat_14 - armbias_index_bias:'{15, 28},
            Pat_16 - armbias_index_bias:'{16, 27},
            Pat_18 - armbias_index_bias:'{13, 26},
            Pat_20 - armbias_index_bias:'{-11, 27},
            Pat_22 - armbias_index_bias:'{-36, 26},
            Pat_24 - armbias_index_bias:'{-54, 27},
            Pat_26 - armbias_index_bias:'{-62, 27},
            Pat_28 - armbias_index_bias:'{-61, 11},
            Pat_30 - armbias_index_bias:'{-52, -15},
            Pat_32 - armbias_index_bias:'{-32, -36},
            Pat_34 - armbias_index_bias:'{-20, -50}
        }
    };

    parameter ball_collision_boxes_num = 18;
    parameter pat_collision_boxes_num = 18;
    parameter collision_boxes_size_index_bias = enum_to_index[Ball_0];

    // ��������ײ���С
    parameter int collision_boxes_sizes[pat_collision_boxes_num + ball_collision_boxes_num][2] = '{
        Ball_0 - collision_boxes_size_index_bias:'{20,22},
        Ball_2 - collision_boxes_size_index_bias:'{20,19},
        Ball_4 - collision_boxes_size_index_bias:'{20,20},
        Ball_6 - collision_boxes_size_index_bias:'{20,22},
        Ball_8 - collision_boxes_size_index_bias:'{20,20},
        Ball_10 - collision_boxes_size_index_bias:'{20,20},
        Ball_12 - collision_boxes_size_index_bias:'{20,19},
        Ball_14 - collision_boxes_size_index_bias:'{20,22},
        Ball_16 - collision_boxes_size_index_bias:'{20,20},
        Ball_18 - collision_boxes_size_index_bias:'{20,20},
        Ball_20 - collision_boxes_size_index_bias:'{20,20},
        Ball_22 - collision_boxes_size_index_bias:'{20,20},
        Ball_24 - collision_boxes_size_index_bias:'{22,20},
        Ball_26 - collision_boxes_size_index_bias:'{22,20},
        Ball_28 - collision_boxes_size_index_bias:'{20,20},
        Ball_30 - collision_boxes_size_index_bias:'{24,20},
        Ball_32 - collision_boxes_size_index_bias:'{20,20},
        Ball_34 - collision_boxes_size_index_bias:'{20,20},
        Pat_0 - collision_boxes_size_index_bias:'{13,42},
        Pat_2 - collision_boxes_size_index_bias:'{22,40},
        Pat_4 - collision_boxes_size_index_bias:'{34,34},
        Pat_6 - collision_boxes_size_index_bias:'{38,23},
        Pat_8 - collision_boxes_size_index_bias:'{43,15},
        Pat_10 - collision_boxes_size_index_bias:'{43,17},
        Pat_12 - collision_boxes_size_index_bias:'{37,27},
        Pat_14 - collision_boxes_size_index_bias:'{29,38},
        Pat_16 - collision_boxes_size_index_bias:'{18,43},
        Pat_18 - collision_boxes_size_index_bias:'{11,42},
        Pat_20 - collision_boxes_size_index_bias:'{21,39},
        Pat_22 - collision_boxes_size_index_bias:'{29,31},
        Pat_24 - collision_boxes_size_index_bias:'{38,23},
        Pat_26 - collision_boxes_size_index_bias:'{41,13},
        Pat_28 - collision_boxes_size_index_bias:'{42,15},
        Pat_30 - collision_boxes_size_index_bias:'{36,27},
        Pat_32 - collision_boxes_size_index_bias:'{27,37},
        Pat_34 - collision_boxes_size_index_bias:'{18,42}
    };

    parameter collision_boxes_bias_index_bias = enum_to_index[Pat_0];

    // ������ײ��������ͼƬ֮���ƫ����
    parameter int collision_boxes_bias[pat_collision_boxes_num][2] = '{
        Pat_0 - collision_boxes_bias_index_bias:'{1,2},
        Pat_2 - collision_boxes_bias_index_bias:'{14,2},
        Pat_4 - collision_boxes_bias_index_bias:'{26,0},
        Pat_6 - collision_boxes_bias_index_bias:'{39,2},
        Pat_8 - collision_boxes_bias_index_bias:'{45,1},
        Pat_10 - collision_boxes_bias_index_bias:'{45,7},
        Pat_12 - collision_boxes_bias_index_bias:'{41,21},
        Pat_14 - collision_boxes_bias_index_bias:'{31,32},
        Pat_16 - collision_boxes_bias_index_bias:'{17,41},
        Pat_18 - collision_boxes_bias_index_bias:'{3,37},
        Pat_20 - collision_boxes_bias_index_bias:'{2,45},
        Pat_22 - collision_boxes_bias_index_bias:'{4,39},
        Pat_24 - collision_boxes_bias_index_bias:'{3,25},
        Pat_26 - collision_boxes_bias_index_bias:'{2,8},
        Pat_28 - collision_boxes_bias_index_bias:'{0,2},
        Pat_30 - collision_boxes_bias_index_bias:'{2,2},
        Pat_32 - collision_boxes_bias_index_bias:'{2,2},
        Pat_34 - collision_boxes_bias_index_bias:'{1,2}
    };
    
    
endpackage
module mod_top(
    // ʱ��
    input  wire clk_100m,           // 100M ����ʱ��

    // ����
    input  wire btn_clk,            // ���΢������
    input  wire btn_rst,            // �Ҳ�΢������
    input  wire [3:0]  btn_push,    // �ĸ���ť����
    input  wire [15:0] dip_sw,      // 16 λ���뿪��

    // 32 λ LED ��
    output wire [7:0] led_bit,      // 8 λ LED �ź�
    output wire [3:0] led_com,      // LED ɨ���ź�

    // �����
    output wire [7:0] dpy_digit,   // ��λ����ܱʶ��ź�
    output wire [7:0] dpy_segment, // ��λ�����λɨ���ź�

    // ������һЩ��ע�͵�������ӿ�
    // ��Ҫʹ�ã���Ҫ����ȥ�� io.xdc �ж�Ӧ�е�ע��

    // PS/2 ����
    input  wire        ps2_keyboard_clk,     // PS/2 ����ʱ��
    input  wire        ps2_keyboard_data,    // PS/2 ��������

    // PS/2 ���
    inout  wire       ps2_mouse_clk,     // PS/2 ���ʱ��
    inout  wire       ps2_mouse_data,    // PS/2 �������
    
    // ���߽����ź�
    input  wire       wireless_tx,
    
    // SD ����SPI ģʽ��
    // output wire        sd_sclk,     // SPI ʱ��
    // output wire        sd_mosi,     // �������
    // input  wire        sd_miso,     // ��������
    // output wire        sd_cs,       // SPI Ƭѡ������Ч
    // input  wire        sd_cd,       // �������⣬0 ��ʾ�п�����
    // input  wire        sd_wp,       // д������⣬0 ��ʾд����״̬

    // RGMII ��̫���ӿ�
    // output wire        rgmii_clk125,
    // input  wire        rgmii_rx_clk,
    // input  wire        rgmii_rx_ctl,
    // input  wire [3: 0] rgmii_rx_data,
    // output wire        rgmii_tx_clk,
    // output wire        rgmii_tx_ctl,
    // output wire [3: 0] rgmii_tx_data,

    // 4MB SRAM �ڴ�
    inout  wire [31:0] base_ram_data,   // SRAM ����
    output wire [19:0] base_ram_addr,   // SRAM ��ַ
    output wire [3: 0] base_ram_be_n,   // SRAM �ֽ�ʹ�ܣ�����Ч�������ʹ���ֽ�ʹ�ܣ��뱣��Ϊ0
    output wire        base_ram_ce_n,   // SRAM Ƭѡ������Ч
    output wire        base_ram_oe_n,   // SRAM ��ʹ�ܣ�����Ч
    output wire        base_ram_we_n,   // SRAM дʹ�ܣ�����Ч

    // HDMI ͼ�����
    output wire [2:0] hdmi_tmds_n,    // HDMI TMDS �����ź�
    output wire [2:0] hdmi_tmds_p,    // HDMI TMDS �����ź�
    output wire       hdmi_tmds_c_n,  // HDMI TMDS ʱ���ź�
    output wire       hdmi_tmds_c_p   // HDMI TMDS ʱ���ź�

);
    import main_package::element_pos_size_rom;
    import main_package::Rend_number;
    
    wire clk_in = clk_100m;

    // PLL ��Ƶ��ʾ�������������ͬƵ�ʵ�ʱ��
    wire clk_hdmi;
    wire clk_locked;
    ip_pll u_ip_pll(
        .clk_in1  (clk_in    ),  // ���� 100MHz
        .reset    (btn_rst   ),  // ��λ ����Ч
        .clk_out1 (clk_hdmi  ),  // 50MHz ����ʱ��
        .locked   (clk_locked)   // �߱�ʾ 50MHz ʱ���Ѿ��ȶ����
    );    
    
    // ����ģ��PLL
    wire clk_uart;;
    wire clk_uart_locked;
    uart_pll u_uart_pll(
        .clk_in1  (clk_in    ),  
        .reset    (btn_rst   ),  
        .clk_out1 (clk_uart  ),  
        .locked   (clk_uart_locked)   
    );

    wire reset_ps2;
    wire reset_uart;
    
    reg [3:0][5:0] input_signal;
    reg [31:0] dpy_input_signal;
    wire [7:0] scancode;   
    reg [31:0] number;

    // �߶������ģ��
    wire scancode_valid;
    ps2_keyboard u_ps2_keyboard (
        .clock     (clk_in           ),
        .reset     (btn_rst          ),
        .ps2_clock (ps2_keyboard_clk ),
        .ps2_data  (ps2_keyboard_data),
        .scancode  (scancode         ),
        .valid     (scancode_valid   )
    );
    
    wire [2:0] btn_click; // ���ļ��Ƿ񱻰���
    wire [11:0] mouse_x;
    wire [11:0] mouse_y;

    // ��̬��
    wire ps2_mouse_clk_i;
    wire ps2_mouse_clk_o;
    wire ps2_mouse_clk_t;
    assign ps2_mouse_clk = ps2_mouse_clk_t ? 1'bz : ps2_mouse_clk_o;
    assign ps2_mouse_clk_i = ps2_mouse_clk;

    wire ps2_mouse_data_i;
    wire ps2_mouse_data_o;
    wire ps2_mouse_data_t;
    assign ps2_mouse_data = ps2_mouse_data_t ? 1'bz : ps2_mouse_data_o;
    assign ps2_mouse_data_i = ps2_mouse_data;

    // ������̬�ŵ������ԣ��������Ҫ����ģ����ֱ�Ӵ���
    // PS/2 IP ������ʱ���� 50MHz����������� VGA/HDMI ������ʱ��
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

    // ���벿��
    wire [7:0] raw;
    wire [15:0] angle;
    wire signed [15:0] angular_v;
    
    // ���̸�λ�˲�
    reset_filter resetter_ps2 (
        .clk(clk_uart),
        .rst_in(btn_rst),
        .rst_out(reset_ps2)
    );

    // ���߸�λ�˲�
    reset_filter resetter_uart (
        .clk(clk_uart),
        .rst_in(btn_rst),
        .rst_out(reset_uart)
    );

    // ����������ģ��
    sensor_reader sensor_reader_inst (
      .clk(clk_uart),
      .rst(reset_uart),
      .rxd(wireless_tx),
      .angular_v(angular_v)
    );
    
    // ���봦��
    ps2_decoder u_ps2_decoder (
        .clk(clk_in),
        .rst(btn_rst),
        
        .mouse_click(btn_click),
        
        .scancode_valid(scancode_valid),
        .in_number(number),
        .scancode(scancode),
        .out_number(number),
        .angular_v(angular_v),
        .api(input_signal)
    );
    
    // �����debug����
    wire wireless_up, wireless_down;
    
    assign wireless_up = angular_v > 8192;
    assign wireless_down = angular_v < -8192;
    
    wire[31:0] dpy_scan;
    reg [7:0] check_badminton;
    reg [7:0] check_pat_A;
    reg [7:0] check_pat_B;
    assign dpy_scan = {check_badminton, check_pat_A, check_pat_B, 8'h0};
    dpy_scan  u_dpy_scan (
        .clk     (clk_in      ),
        .number  (dpy_scan      ),
        .dp      (8'b0        ),

        .digit   (dpy_digit   ),
        .segment (dpy_segment )
    );

    // debug LED ����
    wire [31:0] leds;
    assign leds[15:0] = number[15:0];
    assign leds[21:16] = {input_signal[3]};
    assign leds[28] = wireless_up;
    assign leds[29] = wireless_down;
    assign leds[30] = angular_v > 8192;
    assign leds[31] = angular_v < -8192;
    led_scan u_led_scan (
        .clk     (clk_in      ),
        .leds    (leds        ),

        .led_bit (led_bit     ),
        .led_com (led_com     )
    );

    // ͼ�������ʾ���ֱ��� 800x600@72Hz������ʱ��Ϊ 50MHz����ʾ����ɫ����
    wire [11:0] hdata;  // ��ǰ������
    wire [11:0] vdata;  // ��ǰ������
    wire [7:0] video_red; // ��ɫ����
    wire [7:0] video_green; // ��ɫ����
    wire [7:0] video_blue; // ��ɫ����
    wire video_clk; // ����ʱ��
    wire video_hsync;
    wire video_vsync;

    assign video_red = vdata < 200 ? hdata[8:1] : 8'b0;
    assign video_green = vdata >= 200 && vdata < 400 ? hdata[8:1] : 8'b0;
    assign video_blue = vdata >= 400 ? hdata[8:1] : 8'b0;
 
    assign video_clk = clk_hdmi;
    reg [11:0] pixel_data;
    
    video #(12, 800, 856, 976, 1040, 600, 637, 643, 666, 1, 1) u_video800x600at72 (
        .clk(video_clk), 
        .hdata(hdata), //������
        .vdata(vdata), //������
        .hsync(video_hsync),
        .vsync(video_vsync)
    );

    wire clk_33;
    wire clk_33_locked;
    pll_33(
        .clk_in1(clk_in),
        .reset(btn_rst),
        .clk_out1(clk_33),
        .locked(clk_33_locked)
    );
    
    reg [11:0] pos_x;
    reg [11:0] pos_y;
    wire [11:0] write_x,write_y;
    wire finished;
    element_pos_size_rom elements_all[Rend_number];
    reg[11:0] record_x[20:0];
    reg[11:0] record_y[20:0];
    wire show_bling;
    wire to_black;

    // ���߼�ģ��
    main_logic main(
        .clk_33(clk_33),
        .rst_n(btn_rst),
        .write_finished(finished),
        .input_signal(input_signal),
        .elements_all(elements_all),
        .record_x(record_x),
        .record_y(record_y),
        .show_bling(show_bling),
        .to_black(to_black),
        .check_badminton(check_badminton),
        .check_pat_A(check_pat_A),
        .check_pat_B(check_pat_B)
    );
    
    // ��ͼģ��
    all_painter top_painter(
        .clk(clk_33),
        .rst_n(btn_rst),
        .elements_all(elements_all),
        .record_x(record_x),
        .record_y(record_y),
        .show_bling(show_bling),
        .pixel_data(pixel_data),
        .write_x(write_x),
        .write_y(write_y),
        .finished(finished)
    );

    // RAM����ģ��
    wire ram_valid;
    reg [11:0] mid_output_pixel;
    reg [11:0] output_pixel;
    reg output_valid;

    ram_controllor ram(
        .clk_rd(video_clk),
        .clk_wr(clk_33),
        .rst_n(btn_rst),
        .input_pixel(pixel_data),
        .write_x(write_x),
        .write_y(write_y),
        .read_x(hdata),
        .read_y(vdata),
        .write_finished(finished),
        .output_pixel(mid_output_pixel),
        .output_valid(output_valid)
    );
    
    // SRAM��ȡģ��
    wire [23:0] sram_pixel_data;
    sram_reader sram_r(
        .clk(video_clk),
        .rst_n(btn_rst),
        .read_x(hdata),
        .read_y(vdata),
        .base_ram_data(base_ram_data),
        .base_ram_addr(base_ram_addr),
        .base_ram_be_n(base_ram_be_n),
        .base_ram_ce_n(base_ram_ce_n),
        .base_ram_oe_n(base_ram_oe_n),
        .base_ram_we_n(base_ram_we_n),
        .pixel_data(sram_pixel_data)
    );
    reg sram_enable;
    always_ff@(posedge video_clk) begin
        if(btn_rst)begin
            sram_enable<=0;
        end
        else begin
            if(input_signal[0][0])begin
                sram_enable<=1;
            end
            else begin
                if(sram_enable!=1)begin
                    sram_enable<=0;
                end
            end
        end
    end
    
    assign ram_valid = (hdata>=40&&hdata<=760&&vdata>=30&&vdata<=570);
    always_comb begin
        if(ram_valid) output_pixel=mid_output_pixel;
        else output_pixel=12'd000;
    end

    // ��ɫӳ��
    wire [23:0] output_pixel_888;
    
    rgb444_to_rgb888 convert(
        .rgb444(output_pixel),
        .to_black(to_black),
        .hdata(hdata),
        .vdata(vdata),
        .rgb888(output_pixel_888)
    );
    wire video_de;
    assign video_de = ((hdata < 800) & (vdata < 600));
    wire [23:0] final_pixel;
    assign final_pixel = sram_enable?output_pixel_888:sram_pixel_data;
    
    // �� RGB ת��Ϊ HDMI TMDS �źŲ����
    ip_rgb2dvi u_ip_rgb2dvi (
        .PixelClk   (video_clk),
        .vid_pVDE   (video_de),
        .vid_pHSync (video_hsync),
        .vid_pVSync (video_vsync),
        .vid_pData  (final_pixel),
        .aRst       (~clk_locked),

        .TMDS_Clk_p  (hdmi_tmds_c_p),
        .TMDS_Clk_n  (hdmi_tmds_c_n),
        .TMDS_Data_p (hdmi_tmds_p),
        .TMDS_Data_n (hdmi_tmds_n)
    );

endmodule

