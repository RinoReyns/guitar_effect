function [ out ] = distortion_effect(sygnal_wchodzacy,gain,tone_up, volume, sygnal_wychodzacy)
%   DISTORTION_EFFECT - efekt gitarowy distortion
%   Tu kr�tki opis zasady dzia�ania
%   sygnal_wchodzacy - input guitar vector
%   gain - wzmocnienie
%   tone_up - 
%   volume -
%   sygnal_wychodzacy - nazwa pliku, do kt�rego zapisany jest syg.wyj��.

[x,Fs,bits] = wavread(sygnal_wchodzacy);

% Deklaracja waro�ci parametr�w efektu
index=1:length(x);

y = zeros(length(x),1);

% dolny limit obciecia
tonedown=tone_up-2*tone_up;


for i = 1:length(x),
% przyda�by si� jeszcze limiter - obcinanie cz�stotliwo�ci powy�ej jaki�
% wy�szych, �eby nie siarzy�o

y(i)=gain*x(i);
y(i)=y(i)*volume;

% limiter taki te� generuje simulink
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

