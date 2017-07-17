clear;
clc;
more off;

P = [];

##
## Ich gehe von einer Sortierten 
## Reihenfolge von Zeichen aus!
##
function [ bitList ] = fanoEncoding(S, P)
  DMAX = length(P);
  ## loop durch jedes Zeichen (jedes muss encoded werden!)
  cw_list = {};

  for itr = 1:DMAX
    if (P(itr) != 0)
      digits = ceil(-log2(P(itr)));
    else
      digits = 0;
    endif

    Psum = sum ([0 P](1:itr));
    s = [];
    for i = 1:digits;
      Psum = 2 * Psum;
      if (Psum >= 1)
        s = [s 1];
        Psum = Psum - 1;
      else
        s = [s 0];
      endif
    endfor
    cw_list{itr} = s;
  endfor 
  
  bitList = cw_list;
endfunction

## aufgabe 1 ##

zeichen = [ "A", "B", "C", "D", "E", "F" ];
pZufall = [ 0.5, 0.25, 0.10, 0.08, 0.05, 0.02 ];

bitList = fanoEncoding(zeichen, pZufall);
disp("Encoding fuer Aufgabe 1) "),disp(bitList);
EvonN = 0;
Eideal = 0;

for i = [1:length(pZufall)] 
  EvonN += length(bitList{1,i}) * pZufall(i);
  Eideal -= pZufall(i)*log2(pZufall(i));
endfor
disp("Zusatz Aufgabe 1)");
disp(Eideal/EvonN);

## aufgabe 2 ##
clear;

zeichen = [ "x1", "x2", "x3", "x4", "x5", "x6"];
pZufall = [0.30 0.28 0.12 0.12 0.10 0.08];
bitList = fanoEncoding(zeichen, pZufall);
EvonN = 0;
Eideal = 0;

for i = [1:length(pZufall)] 
  EvonN += length(bitList{1,i}) * pZufall(i);
  Eideal -= pZufall(i)*log2(pZufall(i));
endfor

disp("Aufgabe 2)");
disp(Eideal/EvonN);
