clear;clc;more off;global indexindex = 1;#####################################          AUFGABE (1)          #####################################function y = plotDifferential(x, y, off, name)  global index;   dyx = diff(y) ./ diff(x);   % Differenzenquotienten bilden  xr = x;   xr(length(x)) = []; % letzte Koordinate entfernen    if(off == true)    subplot(2,3, index);     hold on  endif    plot(xr,dyx);     if(off == false)     hold off    title(name);    grid;     axis auto;    index++;  else    plotDifferential(xr, dyx, false, name);  endif  endfunctionfunction y = f(x)  y = cos(x);endfunctionx = [-pi:0.01:pi];y = f(x);plotDifferential(x,y, true, "a) f(x) = cos(x) - Cosinus differentiale");function y = g(x)  y = x ./ ( 1 .+ x.^2 );endfunctionx = [-10:0.01:10];y = g(x);plotDifferential(x,y, true, "b) g(x) = x / ( 1 + x^2 ) - differentiale");function y = h(x)  y = tanh(x);endfunctionx = [-10:0.01:10];y = h(x);plotDifferential(x,y, true, "c) h(x) = tanh(x) - differentiale");function y = k(x)  y = x .* exp(x);endfunctionx = [-10:0.01:10];y = k(x);plotDifferential(x,y, true, "d) g(x) = x * exp(x) - differentiale");function y = l(x)  y = x .* log(x);endfunctionx = [0.1:0.01:5.1];y = l(x);plotDifferential(x, y, true, "e) l(x) = x * ln(x) - differentiale");#####################################          AUFGABE (2)          #####################################function integrate(func, x, name)  flaeche = quad(func, x(1), x(2));  printf(name, flaeche);endfunctionintegrate("sin", [ 0 pi ], "1) sin(x) von 0 bis pi integriert ergibt: %d \n");integrate("cos", [ 0 pi/2 ], "2) cos(x) von 0 bis pi/2 integriert ergibt: %d \n");function y = drei(x)  y = sqrt( 1 .+ exp(0.5 .* x.^2));endfunctionintegrate("drei", [ 1 2.6 ], "3) sqrt(1 + exp(0.5x^2)) von 1 bis 2,6 integriert ergibt: %d \n");integrate("tan", [ -1 0 ], "4) tan(x) von -1 bis 0 integriert ergibt: %d \n");function y = fuenf(x)  y = ( 1 .- exp(-x)) ./ x;endfunctionintegrate("fuenf", [ 1 2 ], "5) 1-exp(-x))/x von 1 bis 2 integriert ergibt: %d \n");function y = sechs(x)  y = sqrt( 1 .+ 2 .* x .^ 4);endfunctionintegrate("sechs", [ 1 4 ], "6) sqrt(1+2*x^4) von 1 bis 4 integriert ergibt: %d \n");function y = sieben(x)  y = x.^3 ./ ( exp(x) .- 1 );endfunctionintegrate("sieben", [ 0.5 1 ], "7) x^3 / (e^x-1) von 0.5 bis 1 integriert ergibt: %d \n");function y = acht(x)  y = (exp(x)) ./ (x.^2);endfunctionintegrate("acht", [ 1 3 ], "8) e^x/x^2 von 1 bis 3 integriert ergibt: %d \n");