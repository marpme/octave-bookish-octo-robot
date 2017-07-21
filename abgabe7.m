clc;
clear;
more off;
pkg load communications;

disp('');
disp('Aufgabe 1');
disp('');

function y = EntropyDerZeichen(p,n)
  y = p.*n;
endfunction

function y = EntropyZurBasis2(p)
  y = p.*log2(p);
endfunction

PX = [0.5 0.25 0.1 0.08 0.05 0.02];
hd = shannonfanodict(1:length(PX), PX);

for i = 1:length(PX)
  Xn(i) = length(hd{1,i}); 
end

EvonN = sum(EntropyDerZeichen(PX, Xn)) % = 2.0900, danke octave!
EntropyOptimum = -sum(EntropyZurBasis2(PX)) % = 1.9527 optimales Ergebnis
RealeEffektivitaet = EntropyOptimum/EvonN   % = 0.93429 also sehr nahe an der 1

disp('');
disp('Aufgabe 2')
disp('');
clear;

PX = [0.3 0.28 0.12 0.12 0.1 0.08];
hd = shannonfanodict(1:length(PX), PX);

for i = 1:length(PX)
  Xn(i) = length(hd{1,i}); 
end

EvonN = sum(entropy(PX, Xn)) % = 2.8400
EntropyOptimum = -sum(entropy2(PX)) % = 2.3933 optimales Ergebnis
RealeEffektivitaet = EntropyOptimum/EvonN % = 0.84266 
% - weit weg druch schlechte kodierung von octave.

disp('')
disp('Aufgabe 3')
disp('')
clear;

PvonX = [0.1 0.2 0.3 0.4];

UebertragungsMat = [ 0.5 0.0  0.5 ; 
                     0.2 0.4  0.4 ; 
                     0.5 0.25 0.25; 
                     0.0 0.5  0.5];
VXY = PvonX(:) .* UebertragungsMat(:,:); 
    
disp('a)')
PY = sum(VXY)

disp('b)')
VXY
printf(
  "Verteilungsmatrix Summe müsste demnach 1 sein: sum(sum(VXY)) = %d \n", 
  sum(sum(VXY))
);

disp('c)')
QzS = VXY(:,:)./PY(:)';
Q = QzS'/10

disp('d)')
X = -sum(entropy2(PvonX))
for i = 1:length(Q(:,1))
  % 0^0 = 1 und daher, dass log2(1)==0 
  % können wir annehmen, dass log2(Q.^Q) = Q.*log2(Q) ist.
  XY(i) = - sum(log2(Q(i,:) .^ Q(i,:)));
end
XY = sum(XY.*PvonX(1:3))
IvonXY = X - XY


disp('')
disp('Aufgabe 4')
disp('')
clear;

PvonX = [0.30 0.28 0.12 0.12 0.10 0.08];

UebertragungsMat = [ 0.60 0.35 0.03 0.02 0 0; 
        0.10 0.45 0.20 0.15 0.10 0;
        0.10 0.15 0.50 0.15 0.05 0.05; 
        0 0.05 0.15 0.60 0.15 0.05;
        0 0 0.07 0.18 0.55 0.20; 
        0 0 0.08 0.12 0.25 0.55];

VXY = PvonX(:) .* UebertragungsMat(:,:);

disp('a)')
PY = sum(VXY)

disp('b)')
VXY
printf(
  "Verteilungsmatrix Summe müsste demnach 1 sein: sum(sum(VXY)) = %d \n", 
  sum(sum(VXY))
);

disp('c)')
QzS = VXY(:,:)./PY(:)';
Q = QzS'/10


disp('d)')
X = -sum(entropy2(PvonX))
for i = 1:length(Q(:,1))
  % 0^0 = 1 und daher, dass log2(1)==0 
  % können wir annehmen, dass log2(Q.^Q) = Q.*log2(Q) ist.
  XY(i) = - sum(log2(Q(i,:) .^ Q(i,:)));
end
XY = sum(XY(:).*PvonX(:))
IvonXY = X - XY

disp('')
disp('Aufgabe 5')
disp('')
disp('a) Linear: Einfache Fehler Erkennung')
clear;

# Unsere definierte Prüfmatrix
H = [0, 0, 0, 1, 1, 1, 1;
     0, 1, 1, 0, 0, 1, 1;
     1, 0, 1, 0, 1, 0, 1];
     
# Unsere Informationsmatrix
G = [1, 1, 1, 0, 0, 0, 0;
     1, 0, 0, 1, 1, 0, 0;
     0, 1, 0, 1, 0, 1, 0;
     1, 1, 0, 1, 0, 0, 1];

a = [1 0 1 1] % Zeichen
c = mod (a * G,  2) % Kodiertes Zeiche
w = c; w(3) = 0 % Änderung um ein Fehler hinzuzufügen
p = bin2dec(sprintf("%d",(mod(H * w', 2)')));

if p~=0
  printf("An der %d. Stelle von W ist ein Fehler aufgetreten!\n\n", p);
else
  printf("Kein Fehler ist aufgetreten!\n\n");
endif


disp('b) Linear: Zweifache Fehler Erkennung')
clear;   
   
H = [0, 0, 0, 0, 1, 1, 1, 1;
     0, 0, 1, 1, 0, 0, 1, 1;
     0, 1, 0, 1, 0, 1, 0, 1;
     1, 1, 1, 1, 1, 1, 1, 1];
     
G = [1, 1, 1, 1, 0, 0, 0, 0;
     1, 1, 0, 0, 1, 1, 0, 0;
     1, 0, 1,0, 1, 0, 1, 0;
     1, 1, 1, 1, 1, 1, 1, 1];
    
a = [1 0 1 1];
c = mod (a * G,  2) % Kodiertes Zeiche
w = c; w(4) = 1; % Änderung um ein Fehler hinzuzufügen
fehler = mod(H * w', 2)'
p = bin2dec(sprintf("%d",fehler(1:3)));

% Fehler Erkennung und korrektur für einfachen möglich
% Zweifacher Fehler kann erkannt werden, aber nicht korrigiert werden
if (p ~= 0 && fehler(4) == 1)
  printf("(Einfacher Fehler) An der %d. Stelle von W ist ein Fehler aufgetreten!\n\n", p+1);
elseif (p ~= 0 && fehler(4) == 0)
 printf("Es ist ein zweifacher Fehler aufgetreten!\n\n", p+1);
else
  printf("Kein Fehler ist aufgetreten!\n\n");
endif


disp('c) Zyklisch Einfach Fehler Erkennung')
disp('')
clear;

# gegeben 
a  = [1 0 0 1]; % Zeichen zu encoden
m = 4; 
n = 7;
k = n-m;

pz = [1 0 1 1];  % x^3+x+1 - keine Nullstellen 0 oder 1
mz = [1 0 0 1];  % x^3+1 - gehört zu a
zk = [1 0 0 0];  % z^3 

mz = conv(zk, mz);
[px, rz] = deconv(mz, pz);
cz = mz - rz;
cz(3) = 1; %Fehler erstellen!

% sollte kein Rest ergeben, wenn doch 
% dann Fehler enthalten!
[ignore, FehlerRest] = deconv(cz, pz);
FehlerRest

for i = 1:length(FehlerRest)
  if(FehlerRest(i) ~= 0)
    printf("Fehler in der Kodierung erkannt!\n", i);
    break;
  endif
end
