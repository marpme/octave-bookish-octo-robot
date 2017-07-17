clear;
clc;
more off;

function [ Child1, Child2, Child1_Code, Child2_Code, current_children_count ] = fanoEncoding(P, Code, Current_No_of_Children)
  len = length(P);
  
  % wenn nur noch zwei items da sind sie immer in 0 und 1 zu teilen!
  if (len <= 2)
    Child1 = P(1);
    Child2 = P(2);
    if (Code == 2)
        Child1_Code = 0;
        Child2_Code = 1;
    else 
        Child1_Code = [Code 0];
        Child2_Code = [Code 1];
    end
  endif
  
  
  ## loop durch jedes Zeichen (jedes muss encoded werden!)
  old_sum_diff = 1000; % wähle eine Hohe Zahl um mit der den Differenz vergleich zu beginnen
  Child1 = [];
  Child2 = [];
  
  for i = [1:len-1]
    new_sum_diff = abs(sum(P(1:i)) - sum(P(i+1:len)));
    if (new_sum_diff < old_sum_diff)
        Child1 = P(1:i);
        Child2 = P(j:no_of_cols);
        if (Code == 2)
            Child1_Code = 0;
            Child2_Code = 1;
        else
            Child1_Code = [Code 0];
            Child2_Code = [Code 1];
        end
    end
    old_sum_diff = new_sum_diff;
  endfor
  
  # erhöhe die Children count da wir 2 neu code werde angehangen haben
  current_children_count = Current_No_of_Children + 2;
endfunction

##
## Ich gehe von einer Sortierten 
## Reihenfolge von Zeichen aus!
##
function Dict = ShannonFano_Dict( P )
  Temp_P = P;
  
  Total_No_of_Children = length(Temp_P);
  Current_No_of_Children = 0;
  
  j = 0;
  k = 0;
  
  Probability_Matrix = Temp_P;
  
  CodeMatrix = {};
  Dict = {};
  
  RootNode_Code = 2; % start knoten für algorithm
  [Child_1, Child_2, Code_1, Code_2, Current_No_of_Children] = GetChildren(Probability_Matrix, RootNode_Code, Current_No_of_Children);
  
  max_iter = (2 * Total_No_of_Children) - 2;
  for i = 1:max_iter
      if (i <= Current_No_of_Children)
       # referenzierung von Child_1, Child_2 geht leider nur so ... :( 
       eval(sprintf('if (size(Child_%i,2) > 1), j = Current_No_of_Children + 1; k = Current_No_of_Children + 2;end',i));
       eval(sprintf('if (size(Child_%i,2) > 1),[Child_%i,Child_%i,Code_%i,Code_%i,Current_No_of_Children] = GetChildren(Child_%i,Code_%i,Current_No_of_Children);end',i,j,k,j,k,i,i));
       eval(sprintf('if (size(Child_%i,2) == 1),SymbolMatrix(size(CodeMatrix,1) + 1,1) = Child_%i; CodeMatrix{size(CodeMatrix,1) + 1,1} = Code_%i;end',i,i,i));
      end 
  end
  
  Dict = CodeMatrix;
endfunction

## Aufgabe 1 ##

zeichen = [ "A", "B", "C", "D", "E", "F"];
pZufall = [0.5, 0.25, 0.10, 0.08, 0.05, 0.02 ];

bitList = ShannonFano_Dict(pZufall);
disp("Encoding fuer Aufgabe 1) ");
disp(bitList);
EvonN = 0;
Eideal = 0;

for i = [1:length(pZufall)] 
  EvonN += length(bitList{i,1}) * pZufall(i);
  Eideal -= pZufall(i)*log2(pZufall(i));
endfor
disp("Zusatz Aufgabe 1)");
disp(Eideal/EvonN);



## Aufgabe 2 ##
clear;

zeichen = [ "x1", "x2", "x3", "x4", "x5", "x6"];
pZufall = [0.30 0.28 0.12 0.12 0.10 0.08];
bitList = ShannonFano_Dict(zeichen, pZufall);
EvonN = 0;
Eideal = 0;

for i = [1:length(pZufall)] 
  EvonN += length(bitList{i,1}) * pZufall(i);
  Eideal -= pZufall(i)*log2(pZufall(i));
endfor

disp("Aufgabe 2) \n Schlechte Kodierung, nicht nahe an der 1!");
disp(Eideal/EvonN);

## Aufgabe 3 ##
clear;

