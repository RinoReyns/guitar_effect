function [ out ] = tremolo_effect( sygnal_wchodzacy, czestotliwosc_LFO, amplituda_LFO, rodzaj_LFO, sygnal_wychodzacy )
%TREMOLO_EFFECT - efekt gitarowy tremolo
%   Tu kr�tki opis zasady dzia�ania
%   sygnal_wchodzacy - input guitar vector
%   czestotliwosc_LFO - cz�stotliwo�� sygna�u LFO
%   amplituda_LFO - amplituda sygna�u moduluj�cego LFO
%   rodzaj_LFO - rodzaj sygna�u moduluj�cego : sinus/tr�jk/pi�okszt.
%   sygnal_wychodzacy - nazwa pliku, do kt�rego zapisany jest syg.wyj��.

% zalecane parametry to: 
% amplituda_LFO 0 to 1 (amplituda 0 to 1)
% czestotliwosc_LFO 0.05 - 5 Hz

[x,Fs,bits] = wavread(sygnal_wchodzacy);

%d�ugo�c sygna�u wej�ciowego w pr�bkach
index=1:length(x);

%%w zalezosi od wybranego rodzaju modulacji
if strcmp(rodzaj_LFO, 'sin')
    tremolo=(1+ amplituda_LFO*sin(2*pi*index*(czestotliwosc_LFO/Fs)))';
elseif strcmp(rodzaj_LFO, 'saw')
    tremolo=(1+ amplituda_LFO*sawtooth(2*pi*index*(czestotliwosc_LFO/Fs)))';
elseif strcmp(rodzaj_LFO, 'sq')
    tremolo=(1+ amplituda_LFO*square(2*pi*index*(czestotliwosc_LFO/Fs)))';
else
    tremolo=(1+ amplituda_LFO*sin(2*pi*index*(czestotliwosc_LFO/Fs)))';
end
    
%wektor wyjsciowy
y = tremolo.*x;


% zapisz wynik do pliku wyjsciowego
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

