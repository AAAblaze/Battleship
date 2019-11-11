clear;
clc;
close(figure(1));
scene = simpleGameEngine('Battleship.png',84,84);
code = spriteCode();
sea = ones(10) * code.water_sprite;
drawScene(scene, sea);
[row,col] = getMouseInput(scene);
coordinate = [row,col];

