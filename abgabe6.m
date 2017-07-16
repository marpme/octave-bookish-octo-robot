clear;
clc;
more off;

global index
index = 1;

###################################
##          AUFGABE (1)          ##
###################################
function y = plotDifferential(x, y, off, name)
  global index;
  % erste ableitung der funktion
  dyx_one = diff(y) ./ diff(x);   % Differenzenquotienten bilden
  xr_one = x; 
  xr_one(length(x)) = []; % letzte Koordinate entfernen
  
  % zweite ableitung der funktion berechnen
  dyx_two = diff(dyx_one) ./ diff(xr_one);   % Differenzenquotienten bilden
  xr_two = xr_one; 
  xr_two(length(xr_one)) = []; % letzte Koordinate entfernen
  
  subplot(2,3, index); 
  plot(x,y,xr_one,dyx_one, xr_two, dyx_two); 
  xlabel('x');
  ylabel('y');
  hleg = legend([ "Ausgangsfunktion"; 
           "1. Ableitung"; 
           "2. Ableitung" ]);
  title(name);
  grid; 
  axis auto;
  index++;
 
endfunction

function y = f(x)
  y = cos(x);
endfunction

x = [-pi:0.01:pi];
y = f(x);
plotDifferential(x,y, true, "a) f(x) = cos(x) - Cosinus differentiale");

function y = g(x)
  y = x ./ ( 1 .+ x.^2 );
endfunction

x = [-10:0.01:10];
y = g(x);
plotDifferential(x,y, true, "b) g(x) = x / ( 1 + x^2 ) - differentiale");

function y = h(x)
  y = tanh(x);
endfunction

x = [-10:0.01:10];
y = h(x);

plotDifferential(x,y, true, "c) h(x) = tanh(x) - differentiale");

function y = k(x)
  y = x .* exp(x);
endfunction

x = [-10:0.01:10];
y = k(x);

plotDifferential(x,y, true, "d) g(x) = x * exp(x) - differentiale");

function y = l(x)
  y = x .* log(x);
endfunction

x = [0.1:0.01:5.1];
y = l(x);

plotDifferential(x, y, true, "e) l(x) = x * ln(x) - differentiale");


###################################
##          AUFGABE (2/3)        ##
###################################

function I = mcintgr(fun, a, b, mcloops) 
 if ( nargin != 4 | nargout> 1 ) 
   usage("mcintgr is called with 4 inputs and 1 output");
 endif

 if !exist(fun) 
   usage("mcintgr: Sure about the function name?");
 elseif ( length(feval(fun,a)) != 1 ) 
   usage("Function passed to mcintgr must be a scalar function"); 
 endif

 x = linspace(a,b);
 y = feval(fun,x); 
 if ( min(y) < 0 ) 
  I = "keine negativen Integrale...";
  return;
 endif 
 maxy = max(y);
 l = b - a;  

 counter = 0; 
 nloops = 0; 

 while ( nloops<= mcloops )
  r1 = a + l*rand; 
  r2 = maxy*rand;
  fr1 = feval(fun,r1);
  if ( r2<fr1 ) 
   counter++;
  endif
  nloops++; 
 endwhile
 
 I = counter/mcloops*maxy*l;
endfunction

function integrate(func, x, name)
  s = quad(func, x(1), x(2));
  xVec = [x(1):0.01:x(2)];
  y = feval(func, xVec);
  t = trapz(xVec, y);
  m = mcintgr(func, x(1), x(2), 100);
  printf(name, s, t, m);
endfunction

integrate("sin", [ 0 pi ], "1) sin(x) von 0 bis pi integriert ergibt: \n quad=%d \n trapz=%d \n monteCarlo=%d \n");

integrate("cos", [ 0 pi/2 ], "2) cos(x) von 0 bis pi/2 integriert ergibt: \n quad=%d \n trapz=%d \n monteCarlo=%d \n");

function y = drei(x)
  y = sqrt( 1 .+ exp(0.5 .* x.^2));
endfunction

integrate("drei", [ 1 2.6 ], "3) sqrt(1 + exp(0.5x^2)) von 1 bis 2,6 integriert ergibt: \n quad=%d \n trapz=%d \n monteCarlo=%d \n");

integrate("tan", [ -1 0 ], "4) tan(x) von -1 bis 0 integriert ergibt: \n quad=%d \n trapz=%d \n monteCarlo=%s \n");

function y = fuenf(x)
  y = ( 1 .- exp(-x)) ./ x;
endfunction

integrate("fuenf", [ 1 2 ], "5) 1-exp(-x))/x von 1 bis 2 integriert ergibt: \n quad=%d \n trapz=%d \n monteCarlo=%d \n");

function y = sechs(x)
  y = sqrt( 1 .+ 2 .* x .^ 4);
endfunction

integrate("sechs", [ 1 4 ], "6) sqrt(1+2*x^4) von 1 bis 4 integriert ergibt: \n quad=%d \n trapz=%d \n monteCarlo=%d \n");

function y = sieben(x)
  y = x.^3 ./ ( exp(x) .- 1 );
endfunction

integrate("sieben", [ 0.5 1 ], "7) x^3 / (exp(x)-1) von 0.5 bis 1 integriert ergibt: \n quad=%d \n trapz=%d \n monteCarlo=%d \n");

function y = acht(x)
  y = (exp(x)) ./ (x.^2);
endfunction

integrate("acht", [ 1 3 ], "8) exp(x)/(x^2) von 1 bis 3 integriert ergibt: \n quad=%d \n trapz=%d \n monteCarlo=%d \n");



