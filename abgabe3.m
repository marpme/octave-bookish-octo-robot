clc;
clear;

zp = [ 4 0 0 0 0 -4 ];

n1 = [ 1 -2 ];
n2 = [ 1  2 ];

# Nennerpolynom wird berechnet durch die multiplikation der Linearfaktoren
np = conv(n1, n2);
disp ("Das Nennerpolynom ist:"), disp (np);

# Berechnung der Nullstellen des Nennerpolynoms
nullstellen = roots(np);
disp ("Die Nullstellen des Zaehlerpolynoms:"), disp (nullstellen);

# Berechnung und Darstellung der ganz rationalen Funktion inkl. rest
[ grf, rest ] = deconv(zp, np);
disp("ganz rationale funktionen mit rest:"),
disp(
  strcat("(", 
     polyout(grf, "x") , ")", "+", 
     "( ", polyout(polyreduce(rest), "x") , ")", "/",
     "( ", polyout(polyreduce(np), "x"), 
  ")")
)

# Ganz Rational gebrochene Funktion
[ r, xP, g ] = residue(zp, np)
x = length(xP);

for i = [1:x]
  if xP(i) < 0
    printf(strcat("(", polyout(r(i)), "/x+", polyout(-1.*xP(i)), ")"))
  else
    printf(strcat("(", polyout(r(i)), "/x-", polyout(xP(i)), ")"))
  endif
  
  if i ~= x
    printf("+")
  endif
endfor 
printf("\n");