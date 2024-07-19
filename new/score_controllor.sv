`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/25 22:13:41
// Design Name: 
// Module Name: score_controllor
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
import main_package::element_pos_size_rom;

module score_controllor(
        input wire clk,
        input wire rst_n,
        input wire player1_add_score,
        input wire player2_add_score,
        output element_pos_size_rom score[4],
        output reg player1_win,
        output reg player2_win
    );
    import main_package::*;
    reg[3:0] player1_score;
    reg[3:0] player2_score;
    parameter win_score =7;
    parameter final_score = 15;
    reg fight;
    reg mid;
    always_ff@(posedge clk or posedge rst_n)begin
        if(rst_n)begin
            player1_win=0;
            player2_win=0;
            player1_score=0;
            player2_score=0;
            fight=0;
            mid=0;
        end
        else begin
            if(player1_win||player2_win)begin
                fight<=0;
            end
            else begin
                if(player1_add_score&&!mid)begin
                    player1_score<=player1_score+1;
                    mid<=1;
                end
                if(player2_add_score&&!mid)begin
                    player2_score<=player2_score+1;
                    mid<=1;
                end
                if(!player1_add_score&&!player2_add_score)begin
                    mid<=0;
                end
                if(player1_score>=final_score||player2_score>=final_score)begin
                    if(player1_score>=final_score)begin
                        player1_win<=1;
                    end
                    else begin
                        player2_win<=1;
                    end
                end 
                else begin
                    if(!fight)begin
                        if(player1_score>=win_score)begin
                           if(player2_score>=win_score-1)begin
                                fight<=1;
                           end
                           else begin
                                player1_win<=1;
                           end
                        end
                        if(player2_score>=win_score)begin
                           if(player1_score>=win_score-1)begin
                                fight<=1;
                           end
                           else begin
                                player2_win<=1;
                           end
                        end
                    end
                    else begin
                        if(player1_score>player2_score)begin
                            if(player1_score-player2_score>=2)begin
                                player1_win<=1;
                            end
                        end
                        else begin
                            if(player2_score-player1_score>=2)begin
                                player2_win<=1;
                            end
                        end
                    end
                end
            end
        end
    end
    
    parameter offset = enum_to_index[Zero];
    reg [3:0] high_a,low_a,high_b,low_b;
    always_comb begin
        if(player1_score<10) begin
            high_a = 0;
            low_a = player1_score;
        end
        else begin
            high_a = 1;
            low_a = player1_score-10;
        end
        if(player2_score<10) begin
            high_b = 0 ;
            low_b = player2_score;
        end
        else begin
            high_b = 1;
            low_b = player2_score-10;
        end 
        score[0]='{
            12'd310,
            12'd25,
            sprite_size[high_a+offset][0],
            sprite_size[high_a+offset][1],
            pos_in_rom[high_a+offset][0],
            pos_in_rom[high_a+offset][1]
        };
        score[1]='{
            12'd330,
            12'd25,
            sprite_size[low_a+offset][0],
            sprite_size[low_a+offset][1],
            pos_in_rom[low_a+offset][0],
            pos_in_rom[low_a+offset][1]
        };
        score[2]='{
            12'd380,
            12'd25,
            sprite_size[high_b+offset][0],
            sprite_size[high_b+offset][1],
            pos_in_rom[high_b+offset][0],
            pos_in_rom[high_b+offset][1]
        };
        score[3]='{
            12'd400,
            12'd25,
            sprite_size[low_b+offset][0],
            sprite_size[low_b+offset][1],
            pos_in_rom[low_b+offset][0],
            pos_in_rom[low_b+offset][1]
        };
    end
    
endmodule
