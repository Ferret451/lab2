Unit SortAnalyze;

Interface

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

Procedure ShellSort(AArrToSort: TArray; const AAmountOfEl: integer; var ARealAmOfIters: integer);
Procedure SelectionSort(ArrToSort: TArray; const AAmountOfEl: integer; var ARealAmOfIters: integer);
Function ShellTheorCalc(const AAmOfElements: Integer): Integer;
Function SelectionTheorCalc(const AAmOfElements: Integer): Integer;

Implementation

//Proc to swap value of variables
Procedure Swap(var AFirstEl, ASecondEl: integer);
Var
  Buf: integer;
  //Buf - variable to swap to elements
Begin
  Buf := AFirstEl;
  AFirstEl := ASecondEl;
  ASecondEl := Buf;
End;

//Proc for ShellSort
Procedure ShellSort(AArrToSort: TArray; const AAmountOfEl: integer; var ARealAmOfIters: integer);
Var
  i, j, AmOfSteps, CurrStep: integer;
  //i, j - iterators
  //AmOfStep - amount of steps for sorting
  //CurrStep - step for current itteration

Begin
  //Determinating amount of steps
  AmOfSteps := round(ln(AAmountOfEl)/ln(3) - 1);

  //Finding max step
  CurrStep := 1;
  for i := 1 to AmOfSteps do
    CurrStep := CurrStep * 3 + 1;

  //Sorting array
  while CurrStep >= 1 do
  begin

    //Going trough array
    i := 1;
    while i + CurrStep <= AAmountOfEl do
    begin
      inc(ARealAmOfIters);

      //Going back to beggining and swapping while needed
      if AArrToSort[i] > AArrToSort[i + CurrStep] then
      begin
        //j is for saving value of i
        j := i;

        repeat
          Swap(AArrToSort[j], AArrToSort[j + CurrStep]);
          j := j - CurrStep;

          inc(ARealAmOfIters);
        until (AArrToSort[j] <= AArrToSort[j + CurrStep]) or (j < 1);
      end;

      inc(i);
    end;

    //Changing step
    CurrStep := CurrStep div 3;
  end;
End;

//Proc for selection sort
Procedure SelectionSort(ArrToSort: TArray; const AAmountOfEl: integer; var ARealAmOfIters: integer);
Var
  i, j, �urrMin: integer;
  //i, j - iterators
  //currMin - max for current iteration

Begin
  //Starting from first element
  i := 1;

  //Sorting array
  while i < AAmountOfEl do
  begin
    //Assigning starting value for min
    �urrMin := ArrToSort[i];

    //Finding current min
    for j := i + 1 to AAmountOfEl do
    begin
      inc(ARealAmOfIters);

      if ArrToSort[j] < �urrMin then
        �urrMin := ArrToSort[j];
    end;

    //Swapping with current first element if less value was found
    inc(ARealAmOfIters);

    if �urrMin <> ArrToSort[i] then
      Swap(�urrMin, ArrToSort[i]);

    inc(i);
  end;
End;

Function ShellTheorCalc(const AAmOfElements: Integer): Integer;
begin
  Result := AAmOfElements * Round(ln(AAmOfElements) / ln(2));
end;

Function SelectionTheorCalc(const AAmOfElements: Integer): Integer;
begin
  Result := round((sqr(AAmOfElements) - AAmOfElements) / 2);
end;

end.
