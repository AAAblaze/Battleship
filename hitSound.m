function [] = hitSound()
    hitsound = audioread('hit.wav');
    sound(hitsound);
    pause(2);
    clear sound;
end

