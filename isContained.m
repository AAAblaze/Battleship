function result = isContained(toCheck, criterion)
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

