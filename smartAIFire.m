function [foreground] = smartAIFire(foreground, userBoard, coordinate)
    code = spriteCode();
    % get the coordinate and separate it to row and column variabless
    row = coordinate(1,1);
    col = coordinate(1,2);
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

