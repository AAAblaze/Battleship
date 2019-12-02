function result = isContained(toCheck, criterion)
    % this function is to check whether toCheck is in criterion
    % return true or false
    result = false;
    for i = 1 : size(toCheck,2)
        if result == true
            break;
        else
            if toCheck(i) == criterion
                result = true;
            end
        end
    end
end

