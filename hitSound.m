function [] = hitSound()
    hitsound = audioread('hit.wav');
    sound(hitsound);
    pause(1);
    clear sound;
end

