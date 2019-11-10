function [foreground] = userFire(foreground, aiBoard)
    code = spriteCode();
    coordinate = input('please input the coordinate you want to hit([x,y] each is from 1 to 10): ');
    row = coordinate(1,1);
    col = coordinate(1,2);
    % hit
    if (aiBoard(row, col) > code.water_sprite && foreground(row, col) == code.blank_sprite)...
            || foreground(row, col) == code.hit_sprite
        foreground(row, col) = code.hit_sprite;
    % miss
    else
        foreground(row, col) = code.miss_sprite;
    end      
end

