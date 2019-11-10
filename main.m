clc;
clear;

% Initialize scene
my_scene = simpleGameEngine('Battleship.png',84,84);
code = spriteCode();
% Set up variables to name the various sprites
% Lookup the code in spriteCode.m
% The method to visit the code is: spriteCode._______(sprite name)
% For example, water_sprite = spriteCode.water_sprite;
% Then, you have the code of water_sprite, which is 2
code = spriteCode();
fprintf("Game Start\n")
aiBoard = aiSetup();
aiBoard
userBoard = userSetup();
background_board = [code.water_sprite*ones(10,11),userBoard];
foreground_board = code.blank_sprite * ones(10,21);
result = hitAndmiss(foreground_board, aiBoard, userBoard);
fprintf(result);
fprintf("Game End");
