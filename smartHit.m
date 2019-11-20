function informationMatrix = smartHit(foreground, userBoard, informationMatrix)
    %   Direction List
    %   0 : No direction
    %   1 : up
    %   -1 : down
    %   2 : left
    %   -2  : right
    code = spriteCode();
    dir = informationMatrix(1,3);
    step = informationMatrix(2,3);
    if dir == 0
        row = randi([1 10]);
        col = randi([1 10]);
        while foreground(row, col + 11) ~= code.blank_sprite
            row = randi([1 10]);
            col = randi([1 10]);
        end
        % hit
        if (userBoard(row, col) > code.water_sprite && foreground(row, 11 + col) == code.blank_sprite)   
            possibleDir = possibleDirection(row, col, foreground);
            dirIndex = randi([1 size(possibleDir,2)]);
            dir = possibleDir(dirIndex);
            step = 1;
        end
        informationMatrix = [[row, col, dir];[row, col, step]];
    elseif dir == 2 || dir == -2
        nextRow = informationMatrix(2,1);
        if dir == 2
            nextCol = informationMatrix(2,2) - informationMatrix(2,3);
        else
            nextCol = informationMatrix(2,2) + informationMatrix(2,3);
        end
        if nextCol == 0 || nextCol == 11 ||...
                (~(userBoard(nextRow, nextCol) > code.water_sprite &&...
                foreground(nextRow, nextCol + 11) == code.blank_sprite))
            if(nextCol > 0 && nextCol < 11)
                foreground(nextRow, nextCol + 11) = code.miss_sprite;
            end
            step = 1;
            lockedRow = informationMatrix(2,1);
            lockedCol = informationMatrix(2,2);
            possibleDir = possibleDirection(lockedRow, lockedCol, foreground);
            if dir == 2 || dir == -2
                nextRow = min(max(1,nextRow), 10);
            end
            if nextCol == 11 || nextCol == 0
                nextCol = min(max(1,lockedRow + PorN(nextRow - lockedRow)), 10);
            end
            if(isContained(possibleDir, -1 * dir) &&...
                    foreground(lockedRow, lockedCol) == foreground(nextRow, nextCol + 11))
                dir = -1 * dir;
                nextCol = min(max(1, lockedCol + PorN(dir)), 10);
                step = 1;
            elseif size(possibleDir,2) > 0 && step == 1
                dirIndex = randi([1 size(possibleDir,2)]);
                dir = possibleDir(dirIndex);
            else
                dir = 0;
                nextRow = randi([1 10]);
                nextCol = randi([1 10]);
                while foreground(nextRow, nextCol) ~= code.blank_sprite
                    nextRow = randi([1 10]);
                    nextCol = randi([1 10]);
                end
            end
            informationMatrix(1,3) = dir;       
        else
            step = step + 1;
        end
        informationMatrix(2,3) = step; 
        informationMatrix(1,1) = nextRow;
        informationMatrix(1,2) = nextCol;
    elseif dir == 1 || dir == -1
        nextCol = informationMatrix(2,2);
        if dir == 1
            nextRow = informationMatrix(2,1) - informationMatrix(2,3);
        else
            nextRow = informationMatrix(2,1) + informationMatrix(2,3);
        end
        if nextRow == 0 || nextRow == 11 ||...
                (~(userBoard(nextRow, nextCol) > code.water_sprite &&...
                foreground(nextRow, nextCol + 11) == code.blank_sprite))
            if(nextRow > 0 && nextRow < 11)
                foreground(nextRow, nextCol + 11) = code.miss_sprite;
            end
            step = 1;
            lockedRow = informationMatrix(2,1);
            lockedCol = informationMatrix(2,2);
            possibleDir = possibleDirection(lockedRow, lockedCol, foreground);
            if nextRow == 0 || nextRow == 11
                nextRow = min(max(1,lockedRow + PorN(nextRow - lockedRow)), 10);
            end
            if dir == 1 || dir == -1
                nextCol = min(max(1,nextRow), 10);
            end
            if(isContained(possibleDir, -1 * dir) &&...
                    foreground(lockedRow, lockedCol) == foreground(nextRow, nextCol + 11))
                dir = -1 * dir;
                nextRow = min(max(1,lockedRow + PorN(dir)), 10);
                step = 1;
            elseif size(possibleDir,2) > 0
                dirIndex = randi([1 size(possibleDir,2)]);
                dir = possibleDir(dirIndex);
            else
                dir = 0;
                nextRow = randi([1 10]);
                nextCol = randi([1 10]);
                while foreground(nextRow, nextCol) ~= code.blank_sprite
                    nextRow = randi([1 10]);
                    nextCol = randi([1 10]);
                end
            end
            informationMatrix(1,3) = dir;
        else
            step = step + 1;
        end
        informationMatrix(2,3) = step;
        informationMatrix(1,1) = nextRow;
        informationMatrix(1,2) = nextCol;
    end
end

