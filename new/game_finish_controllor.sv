`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/30 20:35:34
// Design Name: 
// Module Name: game_finish_controllor
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
module game_finish_controllor(
        input wire clk,
        input wire rst_n,
        input wire player1_win,
        input wire player2_win,
        output reg finished,
        output element_pos_size_rom settlement_page
    );
    import main_package::*;
    always_ff@(posedge clk or posedge rst_n)begin
        if(rst_n)begin
            settlement_page='{
                12'd0,
                12'd0,
                12'd0,
                12'd0,
                12'd0,
                12'd0
            };
            finished=0;
        end
        else begin
            if(player1_win)begin
              finished<=1;
              settlement_page<='{
                 12'd240,
                 12'd190,
                 sprite_size[PlayerA_win][0],
                 sprite_size[PlayerA_win][1],
                 pos_in_rom[PlayerA_win][0],
                 pos_in_rom[PlayerA_win][1]
              };
            end
            else if(player2_win)begin
              finished<=1;
              settlement_page<='{
                 12'd240,
                 12'd190,
                 sprite_size[PlayerB_win][0],
                 sprite_size[PlayerB_win][1],
                 pos_in_rom[PlayerB_win][0],
                 pos_in_rom[PlayerB_win][1]
              };
            end
        end 
    end
    
    
endmodule
