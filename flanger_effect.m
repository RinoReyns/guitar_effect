function [ output_args ] = flanger_effect( sygnal_wchodzacy, opoznienie, amp, czestotliwosc_LFO, sygnal_wychodzacy )
%FLANGER_EFFECT - efekt gitarowy flanger
%   TUTAJ Krótki opis dzia³ania
%   sygnal_wejsciowy - sygnal wchodzacy
%   opoznienie - opoznienie w sekundach
%   amp - iloœæ opoznionego sygnalu dodawano do sygnau wejsciowego (0 - 1)

[x,Fs,bits] = wavread(sygnal_wchodzacy);

% Deklaracja waroœci parametrów efektu
index=1:length(x);

% Tworzenie sinusa potrzebnego do oscylacji delay'a
% LFO(Low Frequency Oscillator)
sin_LFO = (sin(2*pi*index*(czestotliwosc_LFO/Fs)));

%Operacja odbywa siê na próbkach wiêc ci¹g³y czas opóŸnienia 
%(parametr "delay") jest zamieniany na postaœ dyskretn¹

delay_w_probkach=round(opoznienie*Fs);

% Pusy wektor wyjœciowy
y = zeros(length(x),1);

% Sygna³ jest opóŸniony o 'delay_w_probkach' próbek, wiêc gdy sygna³ idzie
%(zgodznie ze schematem flanger'a) pierwsze 'delay_w_probkach' próbek jest
%bez modulacji, dopiero po tej liczbie nastêpujê dodanie sygna³u
%zmodulowanego (kana³ dry+wat)
% przepisuje do 'y' próbki z 'x' w iloœci od 1 do delay_w_probkach
y(1:delay_w_probkach)=x(1:delay_w_probkach);


for i = (delay_w_probkach+1):length(x),

    %zgodnie z teori¹
    sin_temp=abs(sin_LFO(i));    
    
    % generate delay from 1-max_samp_delay and ensure whole number
    % funkcja ceil zaokr¹gla w górê
    delay_temp=ceil(sin_temp*delay_w_probkach);
    
    % dodawanie opóŸnionych próbek do synag³u podstawowego- daje efekt
    % modulacji sinusoidalny 
    y(i) = (amp*x(i)) + amp*(x(i-delay_temp));
end

wavwrite(y,Fs,bits,sygnal_wychodzacy);

%wykresy
figure
subplot(3,1,1)
plot(index,x)
title('Sygna³ wejœciowy');
xlabel('Numer próbki'); ylabel('Wartoœæ próbki'); % jednostka na y???? amplituda? 
subplot(3,1,2)
plot(index,y,'r')
title('Sygna³ wyjœciowy');
xlabel('Numer próbki'); ylabel('Wartoœæ próbki');
subplot(3,1,3)
plot(index,y,'r',index,x)
title('Sygna³ wyjœciowy na³o¿ony na sygna³ wejœciowy');
xlabel('Numer próbki'); ylabel('Wartoœæ próbki');

end

