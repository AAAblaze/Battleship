function length = input_shiplength(prompt,index)
    fprintf(prompt,index);
    length = input('');
    while length < 2 || length > 5
        fprintf(prompt,index);
        length = input('');
    end  
end