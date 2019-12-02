function [] = hitSound()
    % load the sound and play it, pause it after 2 seconds
    hitsound = audioread('hit.wav');
    sound(hitsound);
    pause(2);
    clear sound;
end

