function [ output_args ] = flanger_effect( sygnal_wchodzacy, opoznienie, amp, czestotliwosc_LFO, sygnal_wychodzacy )
%FLANGER_EFFECT - efekt gitarowy flanger
%   TUTAJ Kr�tki opis dzia�ania
%   sygnal_wejsciowy - sygnal wchodzacy
%   opoznienie - opoznienie w sekundach
%   amp - ilo�� opoznionego sygnalu dodawano do sygnau wejsciowego (0 - 1)

[x,Fs,bits] = wavread(sygnal_wchodzacy);

% Deklaracja waro�ci parametr�w efektu
index=1:length(x);

% Tworzenie sinusa potrzebnego do oscylacji delay'a
% LFO(Low Frequency Oscillator)
sin_LFO = (sin(2*pi*index*(czestotliwosc_LFO/Fs)));

%Operacja odbywa si� na pr�bkach wi�c ci�g�y czas op�nienia 
%(parametr "delay") jest zamieniany na posta� dyskretn�

delay_w_probkach=round(opoznienie*Fs);

% Pusy wektor wyj�ciowy
y = zeros(length(x),1);

% Sygna� jest op�niony o 'delay_w_probkach' pr�bek, wi�c gdy sygna� idzie
%(zgodznie ze schematem flanger'a) pierwsze 'delay_w_probkach' pr�bek jest
%bez modulacji, dopiero po tej liczbie nast�puj� dodanie sygna�u
%zmodulowanego (kana� dry+wat)
% przepisuje do 'y' pr�bki z 'x' w ilo�ci od 1 do delay_w_probkach
y(1:delay_w_probkach)=x(1:delay_w_probkach);


for i = (delay_w_probkach+1):length(x),

    %zgodnie z teori�
    sin_temp=abs(sin_LFO(i));    
    
    % generate delay from 1-max_samp_delay and ensure whole number
    % funkcja ceil zaokr�gla w g�r�
    delay_temp=ceil(sin_temp*delay_w_probkach);
    
    % dodawanie op�nionych pr�bek do synag�u podstawowego- daje efekt
    % modulacji sinusoidalny 
    y(i) = (amp*x(i)) + amp*(x(i-delay_temp));
end

wavwrite(y,Fs,bits,sygnal_wychodzacy);

%wykresy
figure
subplot(3,1,1)
plot(index,x)
title('Sygna� wej�ciowy');
xlabel('Numer pr�bki'); ylabel('Warto�� pr�bki'); % jednostka na y???? amplituda? 
subplot(3,1,2)
plot(index,y,'r')
title('Sygna� wyj�ciowy');
xlabel('Numer pr�bki'); ylabel('Warto�� pr�bki');
subplot(3,1,3)
plot(index,y,'r',index,x)
title('Sygna� wyj�ciowy na�o�ony na sygna� wej�ciowy');
xlabel('Numer pr�bki'); ylabel('Warto�� pr�bki');

end

