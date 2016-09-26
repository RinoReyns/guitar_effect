function [ out ] = delay_effect( sygnal_wchodzacy, opoznienie, gain, sygnal_wychodzacy )
%DELAY_EFFECT - efekt gitarowy - delay
%   Tu kr�tki opis zasady dzia�ania
%   sygnal_wejsciowy - sygnal wchodzacy
%   opoznienie - opoznienie w sekundach
%   gain - wzmocnienie 

[x,Fs,bits] = wavread(sygnal_wchodzacy);

%d�ugo�c sygna�u wej�ciowego w pr�bkach
index=1:length(x);

%wektor wyj�ciowy ca�y wype�niony zerami o d�ugo�ci sygna�u wej�ciowego
y=zeros(length(x),1); 

%rzutowanie warto�ci w senkudach na op�nienie w pr�bkach
delay_w_probkach=round(opoznienie*Fs);
% wype�nianie sygna�u wej�ciowego w ilo�ci 'delay_w_probkach' pr�bkami z
% sygna�u wej�ciowego bez op�nienia
y(1:delay_w_probkach)=x(1:delay_w_probkach);

% prosta p�tla: zaczyna si� od elemntu 'delay_w_probkach', bo dopiero od 
%'delay_w_probkach'+1 jest dodawane op�nienie
for n=(delay_w_probkach+1):length(x);
y(n)=x(n)+gain*x(n-delay_w_probkach);
end;

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

