function [foreground] = aiFire(foreground, userBoard)
    code = spriteCode();
    row = randi([1 10]);
    col = randi([1 10]);
    % hit
    if (userBoard(row, col) > code.water_sprite && foreground(row, 11 + col) == code.blank_sprite)...
            || foreground(row, 11 + col) == code.hit_sprite
        foreground(row, 11 + col) = code.hit_sprite;
    % miss
    else
        foreground(row, 11 + col) = code.miss_sprite;
    end    
end

