clear;
clc;
more off;

##
## Abgabe 8
## Jan Kulose und Marvin Piekarek
## s0557320 / s0556014
##

function [a, b] = linearReg(x,y)
  n = length(x);
  xquer = sum((1/n).*x);
  yquer = sum((1/n).*y);
  Sxy = (1/(n-1)) .* (sum(x.*y) - n.*xquer.*yquer);
  Sx2 = (1/(n-1)) .* (sum((x.-xquer).^2));
  a = Sxy./Sx2;
  b = yquer .- a .* xquer;
endfunction

function [a,b,c] = quadraticReg(x,y)
  n = length(x);
  
  A = [
    sum(x .^ 4), sum(x .^ 3), sum(x .^ 2);
    sum(x .^ 3), sum(x .^ 2), sum(x);
    sum(x .^ 2), sum(x),      n;
  ];
  
  B = [
    sum((x .^ 2) .* y);
    sum(x .* y);
    sum(y);
  ];
  
  X = A \ B;
  a = X(1);
  b = X(2);
  c = X(3);
  
endfunction

function [a, b] = expReg(x,y)
  u = x;
  v = log(y);
  
  [c, d] = linearReg(u, v);
  
  a = exp(d);
  b = c;
endfunction

### Aufgabe 1 ###
clear;

xOne = [ 10.6 14.0 18.1, 23.2, 25.0, 26.4, 30.5, 32.5, 36.6, 40.1 ];
yOne = [ 8.6, 11.5, 12.4, 15.6, 15.1, 17.7, 18.9, 18.6, 21.3, 24.3 ];
[a, b] = linearReg(xOne,yOne);
f = @(x) a.*x.+b;
xerg = [0:0.1:50];
subplot(2,3,1);
plot(xOne,yOne, "*", xerg, f(xerg));
printf("1) Funktion: %d * x + %d \n", a, b);

### Aufgabe 2 ###
clear;

xTwo = [ 1.3 2.2 2.9 3.1 4.5 5.7 7.1 8.0 8.7 8.9 9.3 9.9 ];
yTwo = [ 1.3 1.0 0.85 0.80 0.33 0 -0.4 -0.7 -0.9 -1.0 -1.1 -1.2];
[a, b] = linearReg(xTwo,yTwo);
f = @(x) a.*x .+ b;
xerg = [0:0.1:10];
subplot(2,3,2);
plot(xTwo,yTwo, "+", xerg, f(xerg));
printf("2) Funktion: %d * x + %d \n", a, b);

### Aufgabe 3 ###
clear;

xThree = [ 1 2 3 3.5 4.5 5.5 6 7 8 8.5 9.5 10 ];
yThree = [ 11 7.3 4.8 4.1 1.0 0 0.6 2 3.7 4.2 5.6 8 ];

[a,b,c] = quadraticReg(xThree, yThree);
f = @(x) a .* x .^ 2 .+ b .* x + c;
xerg = [1:0.1:10];
subplot(2,3,3);
plot(xThree,yThree, "+", xerg, f(xerg));
printf("3) Funktion: %d * x^2 + %d * x + %d \n", a, b, c);

### Aufgabe 4 ###
clear;

xFour = [ 0.04 0.32 0.51 0.73 1.03 1.42 1.60 ];
yFour = [ 2.63 1.18 1.16 1.54 2.65 5.41 7.67 ]; 

[a,b,c] = quadraticReg(xFour, yFour);
f = @(x) a .* x .^ 2 .+ b .* x + c;
xerg = [0:0.01:2];
subplot(2,3,4);
plot(xFour,yFour, "+", xerg, f(xerg));
printf("4) Funktion: %d * x^2 + %d * x + %d \n", a, b, c);

### Aufgabe 4 ###
clear;

xFive = [ 1 2 3 4 5 ];
yFive = [ 1.8395 0.6765 0.2490 0.0915 0.0335 ];
[a,b] = expReg(xFive, yFive);
f = @(x) a .* exp(b.*x);
xerg = [0:0.1:6];
subplot(2,3,5);
plot(xFive,yFive, "+", xerg, f(xerg));
printf("5) Funktion: %d * exp(%d * x) \n", a, b);
