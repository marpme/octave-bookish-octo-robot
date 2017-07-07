clc;
clear;
format long g;
more off;

## Bearbeiter:
## Marvin Piekarek (s0556014)
## Jan Kulose (s0557320)

## Aufgabe 1
## 20 Geräte, 5 kaputt
## X = anzahl kaputter geräte
## Warscheinlichkeit für 1, ..., 5 kaputte Geräte

# Hypergemoetrische Funktion zur berechnung von Aufgabe (A)
function ans = hypergemo(K, N, n)
  for i = [0:n]
    ans(i+1) = (nchoosek(K, i) .* nchoosek(N-K, n-i)) ./ (nchoosek(N, n));
  endfor
endfunction

prozente = hypergemo(5, 20, 5) .* 100;
printf("Aufgabe 1) \nWahrscheinlichkeit fuer x kaputte Geraete beim ziehen von 5 Geraeten:\n");
for k = [0:length(prozente) - 1]
  printf("darunter %d kaputte(s) Geraet: %.3d %% Wahrscheinlichkeit\n",k, prozente(k+1));
endfor

printf("\n ==> siehe ebenfalls Figure 1\n");
figure 1
bar([0:length(prozente)-1], prozente);
title ("Wahrscheinlichkeit fuer x kaputte Geraete beim ziehen von 5 Geraeten");
xlabel ("Anzahl der Kaputten Geraete");
ylabel ("Wahrscheinlichkeit");

## Bildung des Kartesischen Produkts durch die Verkettung der Matrize
function result = cartesianProduct(sets)
    c = cell(1, numel(sets));
    [c{:}] = ndgrid( sets{:} );
    result = cell2mat( cellfun(@(v)v(:), c, 'UniformOutput',false) );
endfunction

## Berechnung der Moeglichkeiten per Paarkombinationen
function ans = anzahlMoeglichkeiten(nWuerfel)
  augenzahlen = [nWuerfel : (nWuerfel * 6)];
  a = {};
  for i = [1 : nWuerfel]
    a(i) = [1:6];
  endfor 
  
  product = cartesianProduct(a);
  
  ## loop durch alle möglichen Augenzahlen
  ## für zwei wuerfel von 2 bis 12
  ## und gehe durch alle Kobinationen durch und teste 
  ## die summe == der Kombi-Augenzahl
  ans = [];
  for v = [1:length(augenzahlen)];
    count = 0;
    for y = [1:length(product)];
      if sum(product(y, 1:nWuerfel)) == augenzahlen(v)
        count = count + 1;
      endif
    endfor
    ans(v, 1) = augenzahlen(v);
    ans(v, 2) = count;
  endfor
endfunction

## Berechnet die kennzahlen für die Wuerfel aufgabe
function [erwartungswert, varianz, stndabweichung, wahrscheinlichkeit] = getInfo(mat)
  max_sum = mat(length(mat));
  max_moeglichkeiten = 6^(max_sum/6);

  z = mat(:, 1);
  fz_vector = mat(:, 2);
  fz_vector = fz_vector/max_moeglichkeiten;
  erwartungswert = sum(z.*fz_vector);
  varianz = 0;
  
  for i = [1:length(mat(:, 1))]
    varianz += fz_vector(i) * (mat(i,1) - erwartungswert).^2;
  endfor
  stndabweichung = sqrt(varianz);
  wahrscheinlichkeit = fz_vector;
endfunction

## Xi = Anazhl der Augenzahlen (i)
## Yn = X1 + X2 + ... + Xn
## Zn = ( Yn – µn ) / σn
## mit 1 bis 6 Wuerfel ...

for i = [1:6]
  printf("\n\nWuerfeln mit %d wiederholungen: \n", i);
  wuerfelBalken = anzahlMoeglichkeiten(i);
  [erwartungswert, varianz, standartabweichung, wahrscheinlichkeit] = getInfo(wuerfelBalken);
  normierte_ZG = (wuerfelBalken(:,1) .- erwartungswert) ./ standartabweichung;
  
  disp("Erwartungswert"), disp(erwartungswert);
  disp("Varianz"), disp(varianz);
  disp("Standartabweichung"), disp(standartabweichung);
  figure 2
  subplot (2, 3 , i)
  bar(normierte_ZG, wahrscheinlichkeit);
  
  title (sprintf(" n = %d",i));
  xlabel ("Normierte Zufallsgroesse");
  ylabel ("Wahrscheinlichkeit");
endfor

# Aufgabe 3, Binomialverteilung

p = 0.02;
# 250
n = 250;
E = p*n;
var = n*p*(1-p);
sa = sqrt(var);
printf("\nAufgabe 3) \nAnzahl: %d, Erwartungswert: %d, Standardabweichung: %d\n",n,E,sa);
# 500
n = 500;
E = p*n;
var = n*p*(1-p);
sa = sqrt(var);
printf("Anzahl: %d, Erwartungswert: %d, Standardabweichung: %d\n",n,E,sa);
# 1000
n = 1000;
E = p*n;
var = n*p*(1-p);
sa = sqrt(var);
printf("Anzahl: %d, Erwartungswert: %d, Standardabweichung: %d\n",n,E,sa);
# 2000
n = 2000;
E = p*n;
var = n*p*(1-p);
sa = sqrt(var);
printf("Anzahl: %d, Erwartungswert: %d, Standardabweichung: %d\n",n,E,sa);

# Aufgabe 4
# Normalverteilung zur Binomialverteilung
function ans = binom(n, k, p)
  ans = nchoosek(n,k) * (p^k) * (1-p)^(n-k);
endfunction

p = 1/3;            # Wahrscheinlichkeit fuer Treffer
n = 5;              # Anzahl Versuche
k = [0 1 2 3 4 5];  # Anzahl Treffer
p = [binom(5, 0, 1/3) binom(5, 1, 1/3) binom(5, 2, 1/3) binom(5, 3, 1/3) binom(5, 4, 1/3) binom(5, 5, 1/3)];

printf("\nAufgabe 4) \n    siehe Figure 3\n");
figure 3
bar(k,p);
title ("Wahrscheinlichkeit fuer k Treffer bei 5 Versuchen gesamt");
xlabel ("Treffer");
ylabel ("Wahrscheinlichkeit");