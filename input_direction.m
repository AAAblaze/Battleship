function [direction] = input_direction(prompt, index)
    fprintf(prompt,index);
    direction = lower(input('','s'));
    while ~strcmp(direction,'ver') && ~strcmp(direction,'hor')
        fprintf(prompt,index);
        direction = lower(input('','s'));
    end
end