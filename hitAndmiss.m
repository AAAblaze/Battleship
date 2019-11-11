function foreground = hitAndmiss(foreground, aiBoard, userBoard)
    % use randi to choose the order of fire
    % if order is 0, ai starts first
    % otherwise user starts first
    code = spriteCode();
    scene = simpleGameEngine('Battleship.png',84,84);
    background = [code.water_sprite * ones(10,11),userBoard];
    drawScene(scene, background, foreground);
    allDefeated = false;
    while ~allDefeated
        order = randi([0 1]);
        if order == 0
            if ~defeated(foreground, aiBoard, 'ai')
                foreground = aiFire(foreground, userBoard);
                background = [code.water_sprite * ones(10,11), userBoard];
                drawScene(scene, background, foreground);
                if ~defeated(foreground, userBoard, 'user')
                    foreground = userFire(foreground, aiBoard);
                    drawScene(scene, background, foreground);
                    if defeated(foreground, aiBoard, 'ai')
                        allDefeated = true;
                        result = 'User WIN\n';
                    end
                else
                    allDefeated = true;
                    result = 'AI WIN\n';
                end
            else
                allDefeated = true;
                result = 'User WIN\n';
            end
        else
            if ~defeated(foreground, userBoard, 'user')
                foreground = userFire(foreground, aiBoard);
                background = [code.water_sprite * ones(10,11), userBoard];
                drawScene(scene, background, foreground);
                if ~defeated(foreground, aiBoard, 'ai')
                    foreground = aiFire(foreground, userBoard);
                    background(:,12:21) = userBoard;
                    drawScene(scene, background, foreground);  
                    if defeated(foreground, userBoard, 'user')
                        result = 'AI WIN\n';
                        allDefeated = true;
                    end
                else
                    result = 'User WIN\n';
                    allDefeated = true;
                end
            else
                result = 'AI WIN\n';
                allDefeated = true;
            end
        end
    end
    fprintf(result);
    close(figure(1));
end

