Program lab2;

{$APPTYPE CONSOLE}

Uses
  System.SysUtils;

Type
  TArray = array [1..3000] of Integer;
  TAmOfIters = record
      ShellTheor: integer;
      ShellPract: integer;
      SelectionTheor: integer;
      SelectionPract: integer;
  end;
  TResults = record
    RandArrays: TAmOfIters;
    SortedArrays: TAmOfIters;
    ReversedArrays: TAmOfIters;
  end;

Const
  AmountsOfEl: array [1..6] of Integer = (100, 250, 500, 1000, 2000, 3000);
  //AmountsOfEl - possible amounts of elements

Var
  RandElements, SortElements, RevElements: TArray;
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
          ArrToMake[AmountOfEl - i + 1] := i;
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
Procedure ShellSort(ArrToSort: TArray; const AmountOfEl: integer; var RealAmOfIters: integer);
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

Procedure SelectionSort(ArrToSort: TArray; const AmountOfEl: integer; var RealAmOfIters: integer);
Var
  i, j, currMin: integer;
  //i, j - iterators
  //currMin - max for current iteration

Begin
  //Starting from first element
  i := 1;

  //Sorting array
  while i < AmountOfEl do
  begin
    //Assigning starting value for min
    currMin := ArrToSort[i];

    //Finding current min
    for j := i + 1 to AmountOfEl do
      if ArrToSort[j] < currMin then
        currMin := ArrToSort[j];

    //Swapping with current first element if less value was found
    if currMin <> ArrToSort[i] then
    begin
      Swap(currMin, ArrToSort[i]);
      inc(RealAmOfIters);
    end;

    inc(i);
  end;
End;

Begin

  //Making arrays with random, sorted and reversed elements
  MakeArray(RandElements, 2000, 'Rand');
  MakeArray(SortElements, 2000, 'Sorted');
  MakeArray(RevElements, 2000, 'Reversed');

  //Going trough all amounts of elements
  for i := 1 to length(AmountsOfEl) do
  begin

    //RANDOM PART
    //Sorting array and getting theorical and practical amount of itarations
    //Shell sort
    ResultsOfSorts[i].RandArrays.ShellTheor := round(exp(ln(AmountsOfEl[i]) * 1.2));
    ShellSort(RandElements, AmountsOfEl[i], ResultsOfSorts[i].RandArrays.ShellPract);

    //Selection sort
    ResultsOfSorts[i].RandArrays.SelectionTheor := AmountsOfEl[i] * AmountsOfEl[i];
    SelectionSort(RandElements, AmountsOfEl[i], ResultsOfSorts[i].RandArrays.SelectionPract);


    //SORTED PART
    //Sorting array and getting theorical and practical amount of itarations
    //Shell sort
    ResultsOfSorts[i].SortedArrays.ShellTheor := round(exp(ln(AmountsOfEl[i]) * 1.2));
    ShellSort(SortElements, AmountsOfEl[i], ResultsOfSorts[i].SortedArrays.ShellPract);

    //Selection sort
    ResultsOfSorts[i].SortedArrays.SelectionTheor := AmountsOfEl[i] * AmountsOfEl[i];
    SelectionSort(SortElements, AmountsOfEl[i], ResultsOfSorts[i].SortedArrays.SelectionPract);


    //REVERSED PART
    //Sorting array and getting theorical and practical amount of itarations
    //Shell sort
    ResultsOfSorts[i].ReversedArrays.ShellTheor := round(exp(ln(AmountsOfEl[i]) * 1.2));
    ShellSort(RevElements, AmountsOfEl[i], ResultsOfSorts[i].ReversedArrays.ShellPract);

    //Selection sort
    ResultsOfSorts[i].ReversedArrays.SelectionTheor := AmountsOfEl[i] * AmountsOfEl[i];
    SelectionSort(RevElements, AmountsOfEl[i], ResultsOfSorts[i].ReversedArrays.SelectionPract);
  end;

  //Outputting results in table form
  writeln(' _________________________________________________________________________________');
  writeln('|                    |            |       Shell Sort      |     Selection sort    |');
  writeln('| Amount of elements | Array type |_______________________|_______________________|');
  writeln('|                    |            | Theorical | Practical | Theorical | Practical |');
  for i := 1 to length(AmountsOfEl) do
  begin
    //Part with random
    writeln('|____________________|____________|___________|___________|___________|___________|');
    writeln('|', AmountsOfEl[i]:14, '      |  Random    |', ResultsOfSorts[i].RandArrays.ShellTheor:8, '   |', ResultsOfSorts[i].RandArrays.ShellPract:8, '   |', ResultsOfSorts[i].RandArrays.SelectionTheor:8, '   |', ResultsOfSorts[i].RandArrays.SelectionPract:8, '   |');

    //Part with sorted
    writeln('|____________________|____________|___________|___________|___________|___________|');
    writeln('|                    |  Sorted    |', ResultsOfSorts[i].SortedArrays.ShellTheor:8, '   |', ResultsOfSorts[i].SortedArrays.ShellPract:8, '   |', ResultsOfSorts[i].SortedArrays.SelectionTheor:8, '   |', ResultsOfSorts[i].SortedArrays.SelectionPract:8, '   |');

    //Part with reverse
    writeln('|____________________|____________|___________|___________|___________|___________|');
    writeln('|                    |  Reversed  |', ResultsOfSorts[i].ReversedArrays.ShellTheor:8, '   |', ResultsOfSorts[i].ReversedArrays.ShellPract:8, '   |', ResultsOfSorts[i].ReversedArrays.SelectionTheor:8, '   |', ResultsOfSorts[i].ReversedArrays.SelectionPract:8, '   |');
  end;
  writeln('|____________________|____________|___________|___________|___________|___________|');


  readln;
End.
