function number = PorN(number)
    % return whether a number is positive
    if number > 0
        number = 1;
    elseif number < 0
        number = -1;
    else
        number = 0;
    end
end

