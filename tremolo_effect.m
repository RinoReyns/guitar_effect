function [ out ] = tremolo_effect( sygnal_wchodzacy, czestotliwosc_LFO, amplituda_LFO, rodzaj_LFO, sygnal_wychodzacy )
%TREMOLO_EFFECT - efekt gitarowy tremolo
%   Tu krótki opis zasady dzia³ania
%   sygnal_wchodzacy - input guitar vector
%   czestotliwosc_LFO - czêstotliwoœæ sygna³u LFO
%   amplituda_LFO - amplituda sygna³u moduluj¹cego LFO
%   rodzaj_LFO - rodzaj sygna³u moduluj¹cego : sinus/trójk/pi³okszt.
%   sygnal_wychodzacy - nazwa pliku, do którego zapisany jest syg.wyjœæ.

% zalecane parametry to: 
% amplituda_LFO 0 to 1 (amplituda 0 to 1)
% czestotliwosc_LFO 0.05 - 5 Hz

[x,Fs,bits] = wavread(sygnal_wchodzacy);

%d³ugoœc sygna³u wejœciowego w próbkach
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

