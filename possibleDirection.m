function possibleDir = possibleDirection(row, col, foreground)
        %   Direction List
    %   0 : No direction
    %   1 : up
    %   -1 : down
    %   2 : left
    %   -2  : right
    code = spriteCode();
    possibleDir = [];
    for i = -1 : 2 : 1
        if ((col + i < 11) && (col + i > 0) && (foreground(row, col + 11 + i) == code.blank_sprite))
            possibleDir(end + 1) = i * (-2);
        end
        if ((row + i < 11) && (row + i > 0) && (foreground(row + i, col + 11) == code.blank_sprite))
            possibleDir(end + 1) = i * (-1);
        end
    end
end

