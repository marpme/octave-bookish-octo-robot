x = 0; 

function y = a (x)
   y = x.*expm1(x);
endfunction

function y = b (x)
   y = sin(x) + 2.*x.^(0.5);
endfunction

%interval = [9,9]
%[ x ] = fzero(@a,2);

t = -100:0.1:100;
plotyy(@a, @b, [-10, 10, -10, 10]) 
grid;
axis ("auto");