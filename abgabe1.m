clc;
clear;

abweichungen = 5e-6;

% Aufgabe 3 A

A = [ 2, 3, -1; 
      2, 1, -1; 
     -4, 2,  1];
     
b = [ 0; 2; -9];

printf("Aufgabe A \n")
berechneXAbweichung(A, b, abweichungen)

% Aufgabe 3 B

A = [ 1,  1,  0,  3;
      2,  1, -1,  1;
      3, -1, -1,  2;
     -1,  2,  3, -1];
     
b = [ 4; 1; -3; 4 ];

printf("Aufgabe B \n")
berechneXAbweichung(A, b, abweichungen)

% Aufgabe 3 C

A = [ 0,  3, -5,  1;
     -1, -3,  0, -1;
     -2,  1,  2,  2;
     -3,  4,  2,  2];
     
b = [ 0; -5;  2; 8 ];

printf("Aufgabe C \n")
berechneXAbweichung(A,b, abweichungen)

% Aufgabe 3 D

A = [ 5, -3,  0,  2;
      2,  6, -3,  0;
     -1,  2,  4, -1;
     -2, -3,  2,  7];
     
b = [ 13; 16; -11; 10 ];

printf("Aufgabe D \n")
berechneXAbweichung(A, b, abweichungen)
