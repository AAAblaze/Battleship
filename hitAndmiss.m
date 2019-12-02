function foreground = hitAndmiss(foreground, aiBoard, userBoard)
    clc;
    fprintf('The war start!');
    % use randi to choose the order of fire
    % if order is 0, ai starts first
    % otherwise user starts first
    code = spriteCode();
    % load sound effect of winning
    winSound = audioread('win.wav');
    % create the scence
    scene = simpleGameEngine('Battleship.png',84,84);
    % create background
    background = [code.water_sprite * ones(10,11),userBoard];
    % initialize the scene which is fulfilled with sea sprites
    drawScene(scene, background, foreground);
    % initialize the defeated flag
    allDefeated = false;
    while ~allDefeated
	% random priority to fire
        order = randi([0 1]);
	% 0 means AI fire first
        if order == 0
	    % if AI is not defeated
            if ~defeated(foreground, aiBoard, 'ai')
		% use aiFire to update foreground
                foreground = aiFire(foreground, userBoard);
                background = [code.water_sprite * ones(10,11), userBoard];
		% update the scene
                drawScene(scene, background, foreground);
		% if user is not defeated(all sunk), fight back
                if ~defeated(foreground, userBoard, 'user')
                    % use userFire to update foreground
		    foreground = userFire(foreground, aiBoard, userBoard);
                    % update the scene
		    drawScene(scene, background, foreground);
		    % use defeated function to detect whether ai wins
                    if defeated(foreground, aiBoard, 'ai')
                        allDefeated = true;
                        result = '\nUser WIN\n';
                        sound(winSound);
                    end
                else
                    allDefeated = true;
                    result = '\nAI WIN\n';
                end
            else
                allDefeated = true;
                result = '\nUser WIN\n';
                sound(winSound);
            end
        else
	    % randi create 1, which is not 0, means user to fire first
	    % if user is not defeated
            if ~defeated(foreground, userBoard, 'user')
		% use userFire to update the foreground
                foreground = userFire(foreground, aiBoard, userBoard);
                background = [code.water_sprite * ones(10,11), userBoard];
		% update the scene
                drawScene(scene, background, foreground);
                % if AI is not defeated, fight back
		if ~defeated(foreground, aiBoard, 'ai')
		    % use aiFire to update foreground
                    foreground = aiFire(foreground, userBoard);
                    background(:,12:21) = userBoard;
		    % update the scence
                    drawScene(scene, background, foreground);
		    % use defeated function to detect whether user wins  
                    if defeated(foreground, userBoard, 'user')
                        result = '\nAI WIN\n';
                        allDefeated = true;
                    end
                else
                    result = '\nUser WIN\n';
                    sound(winSound);
                    allDefeated = true;
                end
            else
                result = '\nAI WIN\n';
                allDefeated = true;
            end
        end
    end
    % either side is defeated, show the result
    fprintf(result);
    close(figure(1));
end

