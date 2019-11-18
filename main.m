function main()
    clc;
    clear;
    close(figure(1));
    % Initialize scene
    my_scene = simpleGameEngine('Battleship.png',84,84);
    % Set up variables to name the various sprites
    % Lookup the code in spriteCode.m
    % The method to visit the code is: spriteCode._______(sprite name)
    % For example, water_sprite = spriteCode.water_sprite;
    % Then, you have the code of water_sprite, which is 2
    code = spriteCode();
    fprintf("Game Start\n")
    aiBoard = aiSetup();
    userBoard = userSetup();
    background_board = [aiBoard,code.water_sprite * ones(10,1), userBoard];
    foreground_board = code.blank_sprite * ones(10,21);
    foreground_board = smartHitAndmiss(foreground_board, aiBoard, userBoard);
    drawScene(my_scene, background_board, foreground_board);
    fprintf("Game End");
end
