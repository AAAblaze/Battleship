function [foreground] = userFire(foreground, aiBoard, userBoard)
    code = spriteCode();
    close(figure(1));
    clc;
    fprintf('Your turn to fire');
    scene = simpleGameEngine('Battleship.png',84,84);
    background = [code.water_sprite * ones(10,11), userBoard];
    drawScene(scene,background, foreground);
    [row,col] = getMouseInput(scene);
    while(row > 10 || col > 10)
        [row,col] = getMouseInput(scene);
    end
    % hit
    if (aiBoard(row, col) > code.water_sprite && foreground(row, col) == code.blank_sprite)...
            || foreground(row, col) == code.hit_sprite
        foreground(row, col) = code.hit_sprite;
        hitSound();
    % miss
    else
        foreground(row, col) = code.miss_sprite;
    end
    close(figure(1));
end

