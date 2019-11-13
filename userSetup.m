function [ user_ships ] = userSetup()
    code = spriteCode();
    % the "board" of ships is initially empty: 10 by 10 of two
    user_ships = code.water_sprite * ones(10,10);

    ship_numbers = 5;

    % length of the ships, ship 1 is the carrier and has length 5, 
    % ship 2 is the battleship, ship 3 is the submarine, ship 4 is the cruiser,
    % and ship 5 is the PT boat
    ship_length = [];
    ship_direction = [];
    ship_coordinates = [];
    scene = simpleGameEngine('Battleship.png',84,84);
    drawScene(scene, user_ships);
    for ship_id = 1 : ship_numbers
        correctPlaced = false;
        while ~correctPlaced
            [row_begin,col_begin] = getMouseInput(scene);
            [row_end,col_end] = getMouseInput(scene);
            % not place in row or in column or choose same place twice
            while((row_begin - row_end ~= 0) && (col_begin - col_end ~= 0)) ||...
                    ((row_begin - row_end) == 0 && (col_begin - col_end) == 0)
                [row_begin,col_begin] = getMouseInput(scene);
                [row_end,col_end] = getMouseInput(scene);
            end
            %same row or column
            if(row_begin == row_end && col_begin > col_end)
                col_tmp = col_end;
                col_end = col_begin;
                col_begin = col_tmp;
            elseif(col_begin == col_end && row_begin > row_end)
                row_tmp = row_end;
                row_end = row_begin;
                row_begin = row_tmp;
            end
            % check whether fit the requirement, no duplicate, right length
            existLength = 0;
            twoThrees = 0;
            % place boats in a row
            if(row_begin == row_end && (col_end - col_begin) < 5 && (col_end - col_begin) > 0)
                % check whether crashed
                isCrashed = false;
                for currCol = col_begin : col_end
                    if user_ships(row_begin, currCol) > 2
                        isCrashed = true;
                        break;
                    end
                end
                if ~isCrashed
                    % not Two three options
                    if(col_end - col_begin ~= 2)
                        if(size(ship_length,2) ~= 0)
                            for index = 1 : size(ship_length,2)
                                if(ship_length(index) == (col_end - col_begin + 1))
                                    existLength = existLength + 1;
                                end
                            end
                        end
                        if existLength == 0 || size(ship_length,2) == 0
                            ship_length(ship_id) = col_end - col_begin + 1;
                            correctPlaced = true;
                        end
                    %Two three options    
                    else
                        if(size(ship_length,2) < 2)
                            ship_length(ship_id) = 3;
                        else
                            for index = 1 : size(ship_length,2)
                                if(ship_length(index) == (col_end - col_begin + 1))
                                    twoThrees = twoThrees + 1;
                                end
                            end
                            if twoThrees < 2
                                ship_length(ship_id) = 3;
                                correctPlaced = true;
                            end
                        end
                    end                 
                    if correctPlaced
                        ship_direction(ship_id,:) = 'hor';
                    end
                end
            % place boats in col
            elseif(col_begin == col_end && (row_end - row_begin) < 5 && (row_end - row_begin) > 0)
                isCrashed = false;
                for currRow = row_begin : row_end
                    if user_ships(currRow, col_begin) > 2
                        isCrashed = true;
                        break
                    end
                end
                if ~isCrashed
                    % not Two three options
                    if(row_end - row_begin ~= 2)
                        if(size(ship_length,2) ~= 0)
                            for index = 1 : size(ship_length,2)
                                if(ship_length(index) == (row_end - row_begin + 1))
                                    existLength = existLength + 1;
                                end
                            end
                        end
                        if existLength == 0 || size(ship_length,2) == 0
                            ship_length(ship_id) = row_end - row_begin + 1;
                            correctPlaced = true;
                        end
                    %Two three options    
                    else
                        if(size(ship_length,2) < 2)
                            ship_length(ship_id) = 3;
                        else
                            for index = 1 : size(ship_length,2)
                                if(ship_length(index) == (row_end - row_begin + 1))
                                    twoThrees = twoThrees + 1;
                                end
                            end
                            if twoThrees < 2
                                ship_length(ship_id) = 3;
                                correctPlaced = true;
                            end
                        end
                    end                 
                    if correctPlaced
                        ship_direction(ship_id,:) = 'ver';
                    end
                end
            end
            if correctPlaced
                ship_coordinates(ship_id,:) = [row_begin, col_begin];
            end
        end
        user_ships =...
            place_ship(ship_coordinates(ship_id,1), ship_coordinates(ship_id,2), ship_length(ship_id), ship_direction(ship_id,:), user_ships);
        close(figure(1));
        drawScene(scene,user_ships);
    end
    close(figure(1));
end
