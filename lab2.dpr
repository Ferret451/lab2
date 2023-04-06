Program lab2;

{$APPTYPE CONSOLE}

Uses
  System.SysUtils;

Type
  TArray = array [1..3000] of Integer;
  TAmOfIters = record
      ShellTheor: integer;
      ShellPract: integer;
      SelectTheor: integer;
      SelectPract: integer;
  end;
  TResults = record
    RandArrays: TAmOfIters;
    SortedArrays: TAmOfIters;
    ReversedArrays: TAmOfIters;
  end;

Const
  AmountsOfEl: array [1..6] of Integer = (100, 250, 500, 1000, 2000, 3000);

Var
  Elements: TArray;
  ResultsOfSorts: array [1..6] of TResults;
  i: integer;
  //Elements - user elements to sort
  //ResultsOfSorts - struct of theorical and practical amounts of iterations
  //i - iterator for cycles

//Proc for making array
Procedure MakeArray(var ArrToMake: TArray; const AmountOfEl: integer; const Request: string);
Var
  i: integer;
  //i - iterator for cycles

Begin

  //Arr with random numbers
  if Request = 'Rand' then
    for i := 1 to AmountOfEl do
    begin
      Randomize;
      ArrToMake[i] := Random(100) + 1;
    end
  else
    //Arr with sorted numbers
    if  Request = 'Sorted' then
      for i := 1 to AmountOfEl do
      begin
        ArrToMake[i] := i;
      end
    else
      //Arr with sorted and reversed numbers
      if  Request = 'Reversed' then
        for i := AmountOfEl downto 1 do
        begin
          ArrToMake[i] := i;
        end;
End;

//Proc to swap value of variables
Procedure Swap(var firstEl, secondEl: integer);
Var
  Buf: integer;
  //Buf - variable to swap to elements
Begin
  Buf := firstEl;
  firstEl := secondEl;
  secondEl := Buf;
End;

//Proc for ShellSort
Procedure ShellSort(var ArrToSort: TArray; const AmountOfEl: integer; var RealAmOfIters: integer);
Var
  i, j, AmOfStep, CurrStep: integer;
  //i, j - iterators
  //AmOfStep - amount if steps for sorting
  //CurrStep - step for current itteration

Begin
  //Determinating amount of steps
  AmOfStep := round(ln(AmountOfEl)/ln(3) - 1);

  //Finding max step
  CurrStep := 1;
  for i := 1 to AmOfStep do
    CurrStep := CurrStep * 3 + 1;

  //Sorting array
  while CurrStep >= 1 do
  begin

    //Going trough array
    i := 1;
    while i + CurrStep <= AmountOfEl do
    begin


      //Going back to beggining and swapping while needed
      if ArrToSort[i] > ArrToSort[i + CurrStep] then
      begin
        //j is for saving value of i
        j := i;

        while (ArrToSort[j] > ArrToSort[j + CurrStep]) and (j >= 1) do
        begin
          Swap(ArrToSort[j], ArrToSort[j + CurrStep]);
          inc(RealAmOfIters);

          j := j - CurrStep;
        end;
      end;

      inc(i);
    end;

    //Changing step
    CurrStep := CurrStep div 3;
  end;
End;

Begin

  //Going trough all amounts of elements
  for i := 1 to length(AmountsOfEl) do
  begin
    //Making array with rand elements
    MakeArray(Elements, AmountsOfEl[i], 'Rand');

    //Sorting array and getting therical and practical amount of itarations
    ResultsOfSorts[i].RandArrays.ShellTheor := round(exp(ln(AmountsOfEl[i]) * 1.25));
    ShellSort(Elements, AmountsOfEl[i], ResultsOfSorts[i].RandArrays.ShellPract);
  end;

  //Outputting results in table form
  writeln(' _________________________________________________________________________________');
  writeln('| Amount of elements | Array type |       Shell Sort      |     Selection sort    |');
  writeln('|                    |            |_______________________|_______________________|');
  writeln('|                    |            | Theorical | Practical | Theorical | Practical |');
  for i := 1 to length(AmountsOfEl) do
  begin
    //Part with random
    writeln('|____________________|____________|___________|___________|___________|___________|');
    writeln('|', AmountsOfEl[i]:14, '      |  Random    |', ResultsOfSorts[i].RandArrays.ShellTheor:8, '   |', ResultsOfSorts[i].RandArrays.ShellPract:8, '   |', ResultsOfSorts[i].RandArrays.SelectTheor:8, '   |', ResultsOfSorts[i].RandArrays.SelectPract:8, '   |');

    //Part with sorted
    writeln('|____________________|____________|___________|___________|___________|___________|');
    writeln('|                    |  Sorted    |', ResultsOfSorts[i].SortedArrays.ShellTheor:8, '   |', ResultsOfSorts[i].SortedArrays.ShellPract:8, '   |', ResultsOfSorts[i].SortedArrays.SelectTheor:8, '   |', ResultsOfSorts[i].SortedArrays.SelectPract:8, '   |');

    //Part with reverse
    writeln('|____________________|____________|___________|___________|___________|___________|');
    writeln('|                    |  Reversed  |', ResultsOfSorts[i].ReversedArrays.ShellTheor:8, '   |', ResultsOfSorts[i].ReversedArrays.ShellPract:8, '   |', ResultsOfSorts[i].ReversedArrays.SelectTheor:8, '   |', ResultsOfSorts[i].ReversedArrays.SelectPract:8, '   |');
  end;
  writeln('|____________________|____________|___________|___________|___________|___________|');


  readln;
End.
