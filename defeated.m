function isDefeated = defeated(foreground, board, side)
    % suppose all of parts are hit
    isDefeated = true;
    code = spriteCode();
    % use nested loop to check whether each part of ships is hit
    % if either one is not hit, stop the loop
    for row = 1: 10
        % foreground of user has different column numbers from that of AI
	if strcmp(side, 'user')
            for col = 12 : 21
                if foreground(row, col) == code.blank_sprite &&...
                        board(row, col - 11) > 2
                    isDefeated = false;
                    break;
                end
            end
            if isDefeated == false
                break;
            end
        else
            for col = 1 : 10
                if foreground(row, col) == code.blank_sprite &&...
                        board(row, col) > 2
                    isDefeated = false;
                    break
                end
            end
            if isDefeated == false
                break;
            end
        end
    end
end
        
                