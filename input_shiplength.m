function length = input_shiplength(prompt,index)
    % input the length and output the prompt
    % if it is not required format, repeat input
    fprintf(prompt,index);
    length = input('');
    while length < 2 || length > 5
        fprintf(prompt,index);
        length = input('');
    end  
end