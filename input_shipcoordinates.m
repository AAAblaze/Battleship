function [coordinate] = input_shipcoordinates(prompt, index, length, direction, user_ships)
    code = spriteCode();
    fprintf(prompt,index);
    [coordinate] = input('');
    row = coordinate(end,1);
    col = coordinate(end,2);
    direction = char(direction);
    check = false;
    while ~check
        % check the conditon that start points out of the board or part of
        % the boat is out of the board
        while (row < 1 || row > 10) ||...
                (col < 1 || col > 10) ||...
                (strcmp(direction, 'hor') && row + length - 1 > 10) ||...
                (strcmp(direction, 'ver') && col + length - 1 > 10)
            fprintf(prompt,index);    
            [coordinate] = input('');
            row = coordinate(end,1);
            col = coordinate(end,2);
        end
        % check the condition whether two ships are crossed
        if strcmp(direction, 'hor')
            % if the ship are placed horizontally, check the space of row
            while sum(user_ships(row,col:min(10,col+length-1))) ~= code.water_sprite * length
                fprintf(prompt,index);    
                [coordinate] = input('');
                row = coordinate(end,1);
                col = coordinate(end,2);
            end
        else
            % if the ship are placed vertically, check the space of column
            while sum(user_ships(row:min(10, row+length-1),col)) ~= code.water_sprite * length
                fprintf(prompt,index);    
                [coordinate] = input('');
                row = coordinate(end,1);
                col = coordinate(end,2);
            end
        end
        % at last, ship won't be out of the board and it won't cross with
        % another boat, set check(flag) to be true to end the loop
        % the boat is placed on the water
        check = true;
    end 
end