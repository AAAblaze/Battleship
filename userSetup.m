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
    for ship_id = 1 : ship_numbers
        ship_direction(ship_id,:) =...
            input_direction('\nInput the direction(vertical/horizontal) of the placement of %i ship:(input ver/hor) ', ship_id);
        ship_length(ship_id) =...
            input_shiplength('\nInput the length of %i ship:(From 2 to 5) ',ship_id);              
        ship_coordinates(ship_id,:) =...
            input_shipcoordinates('\nInput the coordinate([x,y], each is from 1 to 10) of the placement of %i ship: ', ship_id, ship_length(ship_id), ship_direction(ship_id,:), user_ships);
        user_ships =...
            place_ship(ship_coordinates(ship_id,1), ship_coordinates(ship_id,2), ship_length(ship_id), ship_direction(ship_id,:), user_ships);
        drawScene(scene,user_ships);
    end
    close(figure(1));
end
