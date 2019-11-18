function main()
    clc;
    clear;
    close(figure(1));
    % Initialize scene
    fprintf('Welcome to the Battleship\n');
    fprintf('This game is made by Team F in ENGR 1181(6276)\n');
    fprintf('If you want to play the game, please input y, otherwise the game would quit\n');
    fprintf('Your input: ');
    decision = input('','s');
    if decision == 'y'
        fprintf('Now you have to choose the level of difficulty for this game\n');
        fprintf('The difficulty level could be EASY or HARD\n');
        fprintf('The difficutly level you want to play: ');
        level = input('','s');
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
        if level == 'EASY'
            foreground_board = smartHitAndmiss(foreground_board, aiBoard, userBoard);
        elseif level == 'HARD'
            foreground_board = hitAndmiss(foreground_board, aiBoard, userBoard);
        end
        drawScene(my_scene, background_board, foreground_board);
        fprintf("Game End");
    end
end
