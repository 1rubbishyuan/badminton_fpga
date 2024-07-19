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

package collision_box;
    typedef struct packed{
        reg[11:0] width;
        reg[11:0] height;
        reg[11:0] screen_x;
        reg[11:0] screen_y;
    } collision_box;

    function is_collided(
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