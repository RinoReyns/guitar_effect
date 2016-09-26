function [ out ] = distortion_effect(sygnal_wchodzacy,gain,tone_up, volume, sygnal_wychodzacy)
%   DISTORTION_EFFECT - efekt gitarowy distortion
%   Tu krótki opis zasady dzia³ania
%   sygnal_wchodzacy - input guitar vector
%   gain - wzmocnienie
%   tone_up - 
%   volume -
%   sygnal_wychodzacy - nazwa pliku, do którego zapisany jest syg.wyjœæ.

[x,Fs,bits] = wavread(sygnal_wchodzacy);

% Deklaracja waroœci parametrów efektu
index=1:length(x);

y = zeros(length(x),1);

% dolny limit obciecia
tonedown=tone_up-2*tone_up;


for i = 1:length(x),
% przyda³by siê jeszcze limiter - obcinanie czêstotliwoœci powy¿ej jakiœ
% wy¿szych, ¿eby nie siarzy³o

y(i)=gain*x(i);
y(i)=y(i)*volume;

% limiter taki te¿ generuje simulink
if (y(i) >=tone_up)
    y(i)=tone_up; 
else if (y(i)<=tonedown)
        y(i)=tonedown;
    end
end
        
end


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

