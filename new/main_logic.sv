`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/20 15:58:29
// Design Name: 
// Module Name: main_logic
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

// 主逻辑模块

import main_package::Rend_number;
import main_package::element_pos_size_rom;
import badminton_state_machine::badminton_state_name;
import pat_A_state_machine::pat_A_state_name;
import pat_B_state_machine::pat_B_state_name;
module main_logic(
        input wire clk_33,
        input wire rst_n,
        input wire write_finished, 
        input wire [3:0][5:0] input_signal, // 输入模块信号
        output element_pos_size_rom elements_all[Rend_number],
        output reg[11:0] record_x[20:0],
        output reg[11:0] record_y[20:0],
        output wire show_bling,
        output wire to_black,
        output reg [7:0] check_badminton,
        output reg [7:0] check_pat_A,
        output reg [7:0] check_pat_B
    );
    import main_package::*;

    reg [11:0] playerA_x;
    reg [11:0] playerA_y;
    reg [11:0] playerB_x;
    reg [11:0] playerB_y;

    wire gamingA,gamingB,gaming;
    assign gaming = gamingA | gamingB;

    wire game_finished;
    assign to_black = game_finished;

    wire logic_rst;
    wire ball_finished;
    
    assign logic_rst = rst_n | ball_finished | game_finished | input_signal[0][0];
    wire restart;
    assign restart = rst_n|input_signal[0][0];
    
    element_pos_size_rom playerA,playerB;
    import collision::*;
    collision_box net;
    assign net = '{
        sprite_size[Net][0],
        sprite_size[Net][1],
        12'd344,
        12'd380
    };
    import badminton_state_machine::*;

    reg player1_win,player2_win,player1_add_score,player2_add_score;
    reg[11:0] badminton_x,badminton_y;
    badminton_state badminton_curr_state;

    import pat_B_state_machine::pat_B_state;
    pat_B_state pat_B_curr_state;

    import pat_A_state_machine::pat_A_state;
    pat_A_state pat_A_curr_state; 

    // 玩家A控制模块
    import playerA_move_machine::playerA_move_state;
    import playerA_move_machine::playerA_move_states_name;
    playerA_move_states_name playerA_curr_state_name;
    playerA_move_state playerA_curr_move_state;
    collision_box pat_A_collision;

    playerA_move_controllor pA(
        .clk(clk_33),
        .rst_n(logic_rst),
        .move_left(input_signal[1][2]),
        .move_right(input_signal[1][3]),
        .jump(input_signal[1][1]),
        .gaming(gaming),
        .write_finished(write_finished),
        .player_x(playerA_x),
        .player_y(playerA_y),
        .curr_state(playerA_curr_state_name),
        .playerA_curr_state(playerA_curr_move_state)
    );
    assign playerA='{
        playerA_x,
        playerA_y,
        playerA_curr_move_state.width,
        playerA_curr_move_state.height,
        playerA_curr_move_state.rom_pos_x,
        playerA_curr_move_state.rom_pos_y
    };
    
    // 玩家B控制模块
    import playerB_move_machine::playerB_move_state;
    import playerB_move_machine::playerB_move_states_name;
    playerB_move_states_name playerB_curr_state_name;
    playerB_move_state playerB_curr_move_state;
    collision_box pat_B_collision;

    playerB_move_controllor pB(
        .clk(clk_33),
        .rst_n(logic_rst),
        .move_left(input_signal[2][2]|input_signal[3][2]),
        .move_right(input_signal[2][3]|input_signal[3][3]),
        .jump(input_signal[2][1]|input_signal[3][1]),
        .gaming(gaming),
        .write_finished(write_finished),
        .player_x(playerB_x),
        .player_y(playerB_y),
        .curr_state(playerB_curr_state_name),
        .playerB_curr_state(playerB_curr_move_state)
    );
    assign playerB = '{
        playerB_x,
        playerB_y,
        playerB_curr_move_state.width,
        playerB_curr_move_state.height,
        playerB_curr_move_state.rom_pos_x,
        playerB_curr_move_state.rom_pos_y
    };
    
    reg [31:0] sim_count;

    // 确定持球人
    reg holding_A, holding_B;
    wire up_swing_A, down_swing_A, up_swing_B, down_swing_B;
    reg change1,change2;
    always_ff@(posedge clk_33) begin
        if(restart)begin
            change1<=0;
            change2<=0;
            holding_A<=1;
            holding_B<=0;
        end
        else begin
            if(player1_add_score)begin
                change1<=1;
                change2<=0;
            end
            else if(player2_add_score)begin
                change1<=0;
                change2<=1;
            end
            else begin
                change1<=0;
                change2<=0;
            end
            if(holding_A==0&&holding_B==0)begin
                holding_A<=1;
                holding_B<=0;
            end
            if(change2)begin
               holding_B<=1;
               holding_A<=0; 
            end
            else if(change1) begin
               holding_B<=0;
               holding_A<=1;
            end
        end
    end
    
    assign up_swing_A = input_signal[1][4];
    assign down_swing_A = input_signal[1][5];
    assign up_swing_B = input_signal[2][4] | input_signal[3][4];
    assign down_swing_B = input_signal[2][5] | input_signal[3][5];

    // 拍A控制模块
    import pat_A_state_machine::pat_A_state_name;
    pat_A_state_name pat_A_curr_state_name;
    reg [11:0] pat_A_x,pat_A_y,pat_B_x,pat_B_y;

    badminton_pat_controllor_A badminton_pat_control_A(
        .clk(clk_33),
        .rst_n(logic_rst),
        .up_swing(up_swing_A),
        .down_swing(down_swing_A),
        .holding(holding_A),
        .playerA_curr_state(playerA_curr_state_name),
        .player_A_x(playerA_x),
        .player_A_y(playerA_y),
        .write_finished(write_finished),
        .gaming_A(gamingA),
        .pat_A_x(pat_A_x),
        .pat_A_y(pat_A_y),
        .pat_A_collision(pat_A_collision),
        .pat_A_curr_state(pat_A_curr_state),
        .pat_A_curr_state_name(pat_A_curr_state_name)
    );

    // 拍B控制模块
    import pat_B_state_machine::pat_B_state_name;
    pat_B_state_name pat_B_curr_state_name;
    
    badminton_pat_controllor_B badminton_pat_control_B(
        .clk(clk_33),
        .rst_n(logic_rst),
        .up_swing(up_swing_B),
        .down_swing(down_swing_B),
        .holding(holding_B),
        .playerB_curr_state(playerB_curr_state_name),
        .player_B_x(playerB_x),
        .player_B_y(playerB_y),
        .write_finished(write_finished),
        .gaming_B(gamingB),
        .pat_B_x(pat_B_x),
        .pat_B_y(pat_B_y),
        .pat_B_collision(pat_B_collision),
        .pat_B_curr_state(pat_B_curr_state),
        .pat_B_curr_state_name(pat_B_curr_state_name)
    );

    // 球的控制模块
    badminton_state_name badminton_curr_state_name;
    assign check_badminton = badminton_curr_state_name;
    
    badminton_controllor badminton(
        .clk(clk_33),
        .rst_n(logic_rst),
        .gamingA(gamingA),
        .gamingB(gamingB),
        .write_finished(write_finished),
        .playerA(playerA),
        .playerB(playerB),
        .playerA_pat(pat_A_collision),
        .patA_up(up_swing_A),
        .patA_down(down_swing_A),
        .playerB_pat(pat_B_collision),
        .patB_up(up_swing_B),
        .patB_down(down_swing_B),
        .net(net),
        .playerA_state(playerA_curr_state_name),
        .playerB_state(playerB_curr_state_name),
        .restart(restart),
        .pat_A_curr_state_name(pat_A_curr_state_name),
        .pat_B_curr_state_name(pat_B_curr_state_name),
        .badminton(badminton_curr_state),
        .badminton_x(badminton_x),
        .badminton_y(badminton_y),
        .player1_add_score(player1_add_score),
        .player2_add_score(player2_add_score),
        .ball_finished(ball_finished),
        .record_x(record_x),
        .record_y(record_y),
        .show_bling(show_bling),
        .badminton_curr_state_name(badminton_curr_state_name),
        .check_pat_A(check_pat_A),
        .check_pat_B(check_pat_B)
    );

    // 分数控制模块
    element_pos_size_rom score[4];
    score_controllor score_control(
        .clk(clk_33),
        .rst_n(restart),
        .player1_add_score(player1_add_score),
        .player2_add_score(player2_add_score),
        .score(score),
        .player1_win(player1_win),
        .player2_win(player2_win)
    );
    
    // 游戏结束控制模块
    element_pos_size_rom settlement_page;
    game_finish_controllor game_finished_control(
        .clk(clk_33),
        .rst_n(restart),
        .player1_win(player1_win),
        .player2_win(player2_win),
        .finished(game_finished),
        .settlement_page(settlement_page)
    );
    
    // 绘图元素确定
    always_ff@(posedge clk_33)begin
         for (int i = 0; i < Rend_number; i++) begin
            elements_all[i] <= '{0, 0, 0, 0, 0, 0};
         end

        if(!rst_n)begin
            elements_all[0]<=playerA; // 玩家A
            elements_all[1]<=playerB; // 玩家B
            for(int i = 2; i < 6; i++)begin
                elements_all[i] <= score[i-2]; // 得分
            end
            
            elements_all[6]<='{  // 球网
                12'd344,
                12'd380,
                sprite_size[Net][0],
                sprite_size[Net][1],
                pos_in_rom[Net][0],
                pos_in_rom[Net][1]
            };
            
            elements_all[7]<='{ // 球
                badminton_x,
                badminton_y,
                badminton_curr_state.width,
                badminton_curr_state.height,
                badminton_curr_state.rom_x,
                badminton_curr_state.rom_y
            };
            
            elements_all[8]<='{ // 球拍A
                pat_A_x,
                pat_A_y,
                pat_A_curr_state.width,
                pat_A_curr_state.height,
                pat_A_curr_state.rom_pos_x,
                pat_A_curr_state.rom_pos_y
            };
            elements_all[9]<='{ // 球拍B
                pat_B_x,
                pat_B_y,
                pat_B_curr_state.width,
                pat_B_curr_state.height,
                pat_B_curr_state.rom_pos_x,
                pat_B_curr_state.rom_pos_y
            };    
            elements_all[10] <= settlement_page; // 胜利结算动画
        end
    end
    
endmodule
