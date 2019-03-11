function [VYSTUP, SOUCET] = aproximace(VSTUP)
%=======================================================
% Aproximace segmentovanych v zavislosti na uhlu azimutu 
% lateralizacnich funkci polynomem 5. stupne
%
% Vstupy:
% VSTUP- segmentovana lateralizacni funkce
%
% Vystupy:
% VYSTUP - pomer skutecnych hodnot k aproximovanym
% SOUCET - soucet ctvercu odchylek vuci kazde funkce


VYSTUP = 0;
SOUCET = 0;
X = zeros(length(VSTUP(:,1)),6); %definice matice pro prevod vstupnich hodnot
%na polynomialni tvar
APR = zeros(length(VSTUP(:,1)),length(VSTUP));%definice matice pro ulozeni 
%vysledku aproximace

% prevod vstupnich hodnot na polynomialni tvar
for i = 1:length(VSTUP)
y = VSTUP(:,i);
for j=1:length(VSTUP(:,1))
    X(j,:) = [1 j j^2 j^3 j^4 j^5];
end

a = X\y; % urceni konstant polynomu

y1 = X*a; % vysledek aproximace
APR(:,i) = y1;

% soucet ctvercu odchylek
S=sum((y-y1).^2);
SOUCET = SOUCET+S;

% urceni uspesnosti aproximace
Y = (y./y1)*100; 
usp = sum(Y)/length(VSTUP(:,1));
VYSTUP = VYSTUP+usp;
end

% prumerovani
SOUCET = SOUCET/length(VSTUP)
VYSTUP = VYSTUP/length(VSTUP)

% graficke zobrazeni vysledku
%subplot(2,1,1);
%plot(VSTUP);
%subplot(2,1,2);
%plot(APR);
