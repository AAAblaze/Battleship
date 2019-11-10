function board = place_ship(row, col, length, direction, board)
    code = spriteCode();
    direction = char(direction);
    if strcmp(direction, 'hor') == true
        for currCol = col : col + length - 1
            if currCol == col
                board(row, currCol) = code.left_ship_sprite;
            elseif currCol == col + length - 1
                board(row, currCol) = code.right_ship_sprite;
            else
                board(row, currCol) = code.horiz_ship_sprite;
            end
        end
    elseif strcmp(direction, 'ver') == true
        for currRow = row : row + length - 1
            if currRow == row
                board(currRow,col) = code.top_ship_sprite;
            elseif currRow == row + length - 1
                board(currRow,col) = code.bot_ship_sprite;
            else
                board(currRow, col) = code.vert_ship_sprite;
            end
        end
    end
end

