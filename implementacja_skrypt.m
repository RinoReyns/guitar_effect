% WM, £P
% Wstêpna implementacja efektów gitarowych
% ETI PG 2016

clear;
clc;

sygnal_wchodzacy='Test_Signal.wav'
% 1 - Delay
delay_effect(sygnal_wchodzacy, 0.07, 1.5, 'delay_effect_out.wav' )



% 2 - Flanger
flanger_effect(sygnal_wchodzacy, 0.003, 0.7, 0.5, 'flanger_effect_out.wav')



% 3 - Tremolo
tremolo_effect(sygnal_wchodzacy, 5 , 0.8, 'sin', 'tremolo_effect_out.wav')


% 4 - Distroition
distortion_effect(sygnal_wchodzacy,50,5, 1, 'distroition_effect_out.wav')


% 5 - Chorus


% 6 - Reverb




