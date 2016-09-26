function [ out ] = delay_effect( sygnal_wchodzacy, opoznienie, gain, sygnal_wychodzacy )
%DELAY_EFFECT - efekt gitarowy - delay
%   Tu krótki opis zasady dzia³ania
%   sygnal_wejsciowy - sygnal wchodzacy
%   opoznienie - opoznienie w sekundach
%   gain - wzmocnienie 

[x,Fs,bits] = wavread(sygnal_wchodzacy);

%d³ugoœc sygna³u wejœciowego w próbkach
index=1:length(x);

%wektor wyjœciowy ca³y wype³niony zerami o d³ugoœci sygna³u wejœciowego
y=zeros(length(x),1); 

%rzutowanie wartoœci w senkudach na opóŸnienie w próbkach
delay_w_probkach=round(opoznienie*Fs);
% wype³nianie sygna³u wejœciowego w iloœci 'delay_w_probkach' próbkami z
% sygna³u wejœciowego bez opóŸnienia
y(1:delay_w_probkach)=x(1:delay_w_probkach);

% prosta pêtla: zaczyna siê od elemntu 'delay_w_probkach', bo dopiero od 
%'delay_w_probkach'+1 jest dodawane opóŸnienie
for n=(delay_w_probkach+1):length(x);
y(n)=x(n)+gain*x(n-delay_w_probkach);
end;

wavwrite(y,Fs,sygnal_wychodzacy);

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

