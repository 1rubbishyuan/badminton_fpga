`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/21 15:23:24
// Design Name: 
// Module Name: all_painter
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

// 碰撞箱包

package collision;
    typedef struct packed{
        reg[11:0] width; // 高度
        reg[11:0] height; // 宽度
        reg[11:0] screen_x; // 屏幕上的位置
        reg[11:0] screen_y; 
    } collision_box;

    function is_collided(  // 检测两个碰撞箱是否碰撞的函数
        collision_box collision_box_1,
        collision_box collision_box_2
    );
    return (
        collision_box_1.screen_x + collision_box_1.width > collision_box_2.screen_x && 
        collision_box_1.screen_x < collision_box_2.screen_x + collision_box_2.width &&
        collision_box_1.screen_y + collision_box_1.height > collision_box_2.screen_y &&
        collision_box_1.screen_y < collision_box_2.screen_y + collision_box_2.height
    );
    endfunction
endpackage