function [foreground] = aiFire(foreground, userBoard)
    code = spriteCode();
    clc;
    fprintf('AI turn to fire');
    % make a randi coordinate to hit
    row = randi([1 10]);
    col = randi([1 10]);
    % if it was hit, remade a coordinate until it hasn't been hit
    while foreground(row, col) ~= code.blank_sprite
        row = randi([1 10]);
        col = randi([1 10]);
    end
    % hit
    if (userBoard(row, col) > code.water_sprite && foreground(row, 11 + col) == code.blank_sprite)...
            || foreground(row, 11 + col) == code.hit_sprite
        % update the foreground
	foreground(row, 11 + col) = code.hit_sprite;
        % play sound
	hitSound();
    % miss
    else
        foreground(row, 11 + col) = code.miss_sprite;
    end    
end

