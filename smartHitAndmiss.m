function foreground = smartHitAndmiss(foreground, aiBoard, userBoard)
    clc;
    fprintf('The war start!');
    informationMatrix = zeros(2,3);
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
                informationMatrix = smartHit(foreground, userBoard, informationMatrix);
                coordinate = [informationMatrix(1,1), informationMatrix(1,2)]
                foreground = smartAIFire(foreground, userBoard, coordinate);
                background = [code.water_sprite * ones(10,11), userBoard];
                drawScene(scene, background, foreground);
                if ~defeated(foreground, userBoard, 'user')
                    foreground = userFire(foreground, aiBoard, userBoard);
                    drawScene(scene, background, foreground);
                    if defeated(foreground, aiBoard, 'ai')
                        allDefeated = true;
                        result = '\nUser WIN\n';
                    end
                else
                    allDefeated = true;
                    result = '\nAI WIN\n';
                end
            else
                allDefeated = true;
                result = '\nUser WIN\n';
            end
        else
            if ~defeated(foreground, userBoard, 'user')
                foreground = userFire(foreground, aiBoard, userBoard);
                background = [code.water_sprite * ones(10,11), userBoard];
                drawScene(scene, background, foreground);
                if ~defeated(foreground, aiBoard, 'ai')
                    informationMatrix = smartHit(foreground, userBoard, informationMatrix);
                    coordinate = [informationMatrix(1,1), informationMatrix(1,2)]
                    foreground = smartAIFire(foreground, userBoard, coordinate);
                    drawScene(scene, background, foreground);  
                    if defeated(foreground, userBoard, 'user')
                        result = '\nAI WIN\n';
                        allDefeated = true;
                    end
                else
                    result = '\nUser WIN\n';
                    allDefeated = true;
                end
            else
                result = '\nAI WIN\n';
                allDefeated = true;
            end
        end
    end
    fprintf(result);
    close(figure(1));
end

