function [ user_ships ] = userSetup()
    code = spriteCode();
    % the "board" of ships is initially empty: 10 by 10 of two
    user_ships = code.water_sprite * ones(10,10);
    
    ship_numbers = 5;
    fprintf('You are going to place your ships in your sea.\n');
    fprintf('The length of ships are 5, 4, 3, 3, 2.\n');
    % length of the ships, ship 1 is the carrier and has length 5, 
    % ship 2 is the battleship, ship 3 is the submarine, ship 4 is the cruiser,
    % and ship 5 is the PT boat
    ship_length = [];
    ship_direction = [];
    ship_coordinates = [];
    close(figure(1));
    scene = simpleGameEngine('Battleship.png',84,84);
    drawScene(scene, user_ships);
    for ship_id = 1 : ship_numbers
        clc;
        correctPlaced = false;
        while ~correctPlaced
            fprintf('Please click the sprite to choose the start point to place the ship.\n'); 
            [row_begin,col_begin] = getMouseInput(scene);
            fprintf('Please click the sprite to choose the end point to place the ship.\n');
            [row_end,col_end] = getMouseInput(scene);
            % not place in row or in column or choose same place twice
            while((row_begin - row_end ~= 0) && (col_begin - col_end ~= 0)) ||...
                    ((row_begin - row_end) == 0 && (col_begin - col_end) == 0)
                clc;
                fprintf('You could not place the ship crossing sprites or click same place twice.\n');
                fprintf('Please click the sprite to choose the start point to place the ship.\n'); 
                [row_begin,col_begin] = getMouseInput(scene);
                fprintf('Please click the sprite to choose the end point to place the ship.\n');
                [row_end,col_end] = getMouseInput(scene);
            end
            clc;
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
                        fprintf('You could not put ship in cross.\n'); 
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
                        else
                            improperLength = col_end - col_begin + 1;
                            fprintf('You could not put %i sprites ship again.\n', improperLength); 
                        end
                    %Two three options    
                    else
                        if(size(ship_length,2) < 2)
                            ship_length(ship_id) = 3;
                            correctPlaced = true;
                        else
                            for index = 1 : size(ship_length,2)
                                if(ship_length(index) == (col_end - col_begin + 1))
                                    twoThrees = twoThrees + 1;
                                end
                            end
                            if twoThrees < 2
                                ship_length(ship_id) = 3;
                                correctPlaced = true;
                            else
                                improperLength = col_end - col_begin + 1;
                                fprintf('You could not put %i sprites ship more than twice.\n', improperLength); 
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
                        else
                            improperLength = row_end - row_begin + 1;
                            fprintf('You could not put %i sprites ship again.\n', improperLength); 
                        end
                    %Two three options    
                    else
                        if(size(ship_length,2) < 2)
                            ship_length(ship_id) = 3;
                            correctPlaced = true;
                        else
                            for index = 1 : size(ship_length,2)
                                if(ship_length(index) == (row_end - row_begin + 1))
                                    twoThrees = twoThrees + 1;
                                end
                            end
                            if twoThrees < 2
                                ship_length(ship_id) = 3;
                                correctPlaced = true;
                            else
                                improperLength = row_end - row_begin + 1;
                                fprintf('You could not put %i sprites ship more than twice.\n', improperLength); 
                            end
                        end
                    end                 
                    if correctPlaced
                        ship_direction(ship_id,:) = 'ver';
                    end
                end
            else
                fprintf('The length of ship is not proper.\n');
            end
            if correctPlaced
                ship_coordinates(ship_id,:) = [row_begin, col_begin];
            end
        end
        user_ships =...
            place_ship(ship_coordinates(ship_id,1), ship_coordinates(ship_id,2), ship_length(ship_id), ship_direction(ship_id,:), user_ships);
        close(figure(1));
        fprintf('The %i ship has been successfully placed.', ship_id);
        drawScene(scene,user_ships);
    end
    close(figure(1));
end
