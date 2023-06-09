Program lab2;

{$APPTYPE CONSOLE}

Uses
  System.SysUtils,
  SortAnalyze in 'SortAnalyze.pas';

Type
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
Procedure MakeArray(var AArrToMake: TArray; const AAmountOfEl: integer; const ARequest: string);
Var
  i: integer;
  //i - iterator for cycles

Begin

  //Arr with random numbers
  if ARequest = 'Rand' then
  begin
    Randomize;
    for i := 1 to AAmountOfEl do
    begin
      AArrToMake[i] := Random(100) + 1;
    end;
  end
  else
    //Arr with sorted numbers
    if ARequest = 'Sorted' then
      for i := 1 to AAmountOfEl do
      begin
        AArrToMake[i] := i;
      end
    else
      //Arr with sorted and reversed numbers
      if  ARequest = 'Reversed' then
        for i := AAmountOfEl downto 1 do
        begin
          AArrToMake[AAmountOfEl - i + 1] := i;
        end;
End;

Begin
  //Making arrays with random, sorted and reversed elements
  MakeArray(RandElements, 3000, 'Rand');
  MakeArray(SortElements, 3000, 'Sorted');
  MakeArray(RevElements, 3000, 'Reversed');

  //Going trough all amounts of elements
  for i := 1 to length(AmountsOfEl) do
  begin
    //Getting theorical amount of itarations
    ResultsOfSorts[i].RandArrays.ShellTheor := ShellTheorCalc(AmountsOfEl[i]);
    ResultsOfSorts[i].RandArrays.SelectionTheor := SelectionTheorCalc(AmountsOfEl[i]);
    ResultsOfSorts[i].SortedArrays.ShellTheor := ShellTheorCalc(AmountsOfEl[i]);
    ResultsOfSorts[i].SortedArrays.SelectionTheor := SelectionTheorCalc(AmountsOfEl[i]);
    ResultsOfSorts[i].ReversedArrays.ShellTheor := ShellTheorCalc(AmountsOfEl[i]);
    ResultsOfSorts[i].ReversedArrays.SelectionTheor := SelectionTheorCalc(AmountsOfEl[i]);

    //RANDOM PART
    //Getting practical amount of itarations
    //Shell sort
    ShellPactCalc(RandElements, AmountsOfEl[i], ResultsOfSorts[i].RandArrays.ShellPract);

    //Selection sort
    SelectionPractCalc(RandElements, AmountsOfEl[i], ResultsOfSorts[i].RandArrays.SelectionPract);

    //SORTED PART
    //Getting practical amount of itarations
    //Shell sort
    ShellPactCalc(SortElements, AmountsOfEl[i], ResultsOfSorts[i].SortedArrays.ShellPract);

    //Selection sort
    SelectionPractCalc(SortElements, AmountsOfEl[i], ResultsOfSorts[i].SortedArrays.SelectionPract);

    //REVERSED PART
    //Getting practical amount of itarations
    //Shell sort
    ShellPactCalc(RevElements, AmountsOfEl[i], ResultsOfSorts[i].ReversedArrays.ShellPract);

    //Selection sort
    SelectionPractCalc(RevElements, AmountsOfEl[i], ResultsOfSorts[i].ReversedArrays.SelectionPract);
  end;

  //Outputting results in table form
  writeln(' _________________________________________________________________________________');
  writeln('|                    |            |       Shell Sort      |     Selection sort    |');
  writeln('| Amount of elements | Array type |_______________________|_______________________|');
  writeln('|                    |            | Practical | Theorical | Practical | Theorical |');
  for i := 1 to length(AmountsOfEl) do
  begin
    //Part with random
    writeln('|____________________|____________|___________|___________|___________|___________|');
    writeln('|', AmountsOfEl[i]:14, '      |  Random    |', ResultsOfSorts[i].RandArrays.ShellPract:8, '   |', ResultsOfSorts[i].RandArrays.ShellTheor:8, '   |', ResultsOfSorts[i].RandArrays.SelectionPract:8, '   |', ResultsOfSorts[i].RandArrays.SelectionTheor:8, '   |');

    //Part with sorted
    writeln('|____________________|____________|___________|___________|___________|___________|');
    writeln('|                    |  Sorted    |', ResultsOfSorts[i].SortedArrays.ShellPract:8, '   |', ResultsOfSorts[i].SortedArrays.ShellTheor:8, '   |', ResultsOfSorts[i].SortedArrays.SelectionPract:8, '   |', ResultsOfSorts[i].SortedArrays.SelectionTheor:8, '   |');

    //Part with reverse
    writeln('|____________________|____________|___________|___________|___________|___________|');
    writeln('|                    |  Reversed  |', ResultsOfSorts[i].ReversedArrays.ShellPract:8, '   |', ResultsOfSorts[i].ReversedArrays.ShellTheor:8, '   |', ResultsOfSorts[i].ReversedArrays.SelectionPract:8, '   |', ResultsOfSorts[i].ReversedArrays.SelectionTheor:8, '   |');
  end;
  writeln('|____________________|____________|___________|___________|___________|___________|');


  readln;
End.
