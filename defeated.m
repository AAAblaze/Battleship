function isDefeated = defeated(foreground, board, side)
    isDefeated = true;
    code = spriteCode();
    for row = 1: 10
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
        
                