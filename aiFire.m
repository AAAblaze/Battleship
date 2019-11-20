function [foreground] = aiFire(foreground, userBoard)
    code = spriteCode();
    clc;
    fprintf('AI turn to fire');
    row = randi([1 10]);
    col = randi([1 10]);
    while foreground(row, col) ~= code.blank_sprite
        row = randi([1 10]);
        col = randi([1 10]);
    end
    % hit
    if (userBoard(row, col) > code.water_sprite && foreground(row, 11 + col) == code.blank_sprite)...
            || foreground(row, 11 + col) == code.hit_sprite
        foreground(row, 11 + col) = code.hit_sprite;
        hitSound();
    % miss
    else
        foreground(row, 11 + col) = code.miss_sprite;
    end    
end

