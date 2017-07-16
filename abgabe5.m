clc;
clear;
format long g;
more off;

a = @(x) (x .- 9) .^ 2;


function ans = dichtef(k)
  ans = 1/243 .* ((k.^3)/3.-9.*k.^2.+81.*k);
endfunction

function ans = verteilungf(k)
  ans = 1/243 .* (9.-k).^2;
endfunction

function ans = erwartungf(x)
  ans = x  .* verteilungf(x);
endfunction

function ans = varianzf(x)
  global erwartung;
  ans = (x .- erwartung).^2 .* verteilungf(x);
endfunction

subplot(2,2,1)
fplot(@dichtef, [0 9], 'b');
hold on
fplot(@verteilungf, [0 9], 'r');
hold off
title('1c) Darstellung der Verteilungs und Dichtefunktion')
axis auto
grid

## Berechnen Sie Erwartungswert und 
## Standardabweichung der Zeitdauer X. 
global erwartung;
disp("Aufgabe 1) \n")
erwartung = quad("erwartungf", 0, 9);
varianz = quad("varianzf", 0, 9);
standard_abw = sqrt(varianz);
erwartungswert_rechnung = erwartung * 80 + 30;
standard_abw_rechnung = standard_abw * 80;

printf("C                       = 1/%d \n", quad(a, 0, 9));
printf("Erwartungswert          = %d \n", erwartung);
printf("Varianz                 = %d \n", varianz);
printf("Standardabweichung      = %d \n", standard_abw);
printf("Erwartungswert Rech     = %d€ \n", erwartungswert_rechnung);
printf("Stand. Abweichung Rech  = %d€ \n", standard_abw_rechnung);



## Aufgabe 2
## Die Feuerwehr einer Stadt wird ca. aller 2 Tage zum Löschen eines Brandes eingesetzt. 
## Die Zahl der Einsätze X pro Woche wird als Poisson-verteilt angenommen. 

## alle 2 tage => 7(Tage/Woche) / 2 => 3.5 Einsätze pro Woche
## possion f(x) = P(X = x) = mu^x/x! * e^(-mu)

clear;
disp("\nAufgabe 2) \n");

x = [0:8];
mu_einsatz = 3.5;
poisson = poisspdf(x, mu_einsatz);
subplot(2,2,2)
bar(x, poisson);
title("2a) Wahrscheinlichkeitfunktion der Einsaetze");

b = 1 - poisscdf(2, mu_einsatz);
printf("b) Wahrscheinlichkeit für mehr als 2 Einsätze pro Woche: "),printf("%d %% \n",b*100);

global mu_zeit=2;
zeiten=[0:7];
c = 7;

subplot(2,2,3)
bar(zeiten, poisspdf(zeiten, mu_zeit));
title("2c) Darstellung der Verteilungsfunktion");
axis auto
grid

subplot(2,2,4)
bar(zeiten, poisscdf(zeiten, mu_zeit));
title('2c)  Darstellung der Dichtefunktion')
axis auto
grid

d=poisscdf(2, mu_zeit)*100;
e=(1-poisscdf(4, mu_zeit))*100
printf("d) Mit der Wahrscheinlichkeit von %d %% muss die Feuerwehr nach 2 Tage wieder ausrücken.\n", d);
printf("e) Und mit der Wahrscheinlichekit von %d %% findet nach mind. 5 Tagen\n   seit dem letzten Einsatz kein neuer mehr statt.\n", e);

## Aufgabe 3
## Die Längenmessung von 10 Schrauben
clear;
printf('\nAufgabe 3)\n\n');
messungen = [10 8 9 10 11 11 9 12 8 12];

n = length(messungen);
varianz = 4;
standardabw = sqrt(varianz);
mittelwert = 1/length(messungen) * sum(messungen);

gamma = 0.95;
omega = (gamma + 1) / 2;
c = stdnormal_inv(omega);
interval = ((c * standardabw) / sqrt(n));
printf('Mit einer Wahrscheinlichkeit von %d%% ist mue zwischen %.4d und %.4d \n', 
gamma*100, mittelwert - interval, mittelwert + interval);

# Aufgabe 4
# Durchschnittlich 10000 mean
# Standardabweichung 800 sigma
clear;
printf("\nAufgabe 4)\n\n");
a = normcdf(8999, 10000, 800);
printf("a) Die Wahrscheinlichkeit betraegt %d%%\n",a*100);
b = normcdf(10500, 10000, 800) - a;
printf("b) Die Wahrscheinlichkeit betraegt %d%%\n",b*100);
c = norminv(.8, 10000, 800);
printf("c) 80%% der Lampen ueberschreiten die Lebenszeit von %d Stunden nicht\n",c);
d = norminv(.1, 10000, 800);
printf("d) 90%% der Lampen erreichen eine Lebensdauer von %d Stunden\n",d);

# Aufgabe 5
# Durchschnitt 40000
# Standardabweichung 4310
clear;
printf("\n\nAufgabe 5)\n\n");
a = normcdf(37500,40000,4310);
printf("a) Die Wahrscheinlichkeit betraegt %d%%\n",a*100);
b = 1-normcdf(45000,40000,4310);
printf("b) Die Wahrscheinlichkeit betraegt %d%%\n",b*100);
c = (1-normcdf(42000,40000,4310))^4;
printf("c) Die Wahrscheinlichkeit betraegt %d%%\n",c*100);
d = 1-(1-normcdf(38000,40000,4310))^4;
printf("d) Die Wahrscheinlichkeit betraegt %d%%\n",d*100);
e = norminv(.2, 40000, 4310);
printf("d) 80%% der Reifen erreichen eine Lebensdauer von mindestens %d Kilometern\n",e);
