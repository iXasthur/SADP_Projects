program SADP_L2;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

const
  count = 10;

type
  listPointer = ^member;
  specialListPointer = ^specialMember;
  member = Record
    number: String;
    previous: listPointer;
    next: listPointer;
  End;
  specialMember = Record
    number: String;
    next: specialListPointer;
  End;

procedure createList(var x:listPointer);
var
  numberLength,i,s: Integer;
  buff, listElement: listPointer;
begin
  new(x);
  x.previous := nil;
  x.next := nil;
  x.number := '+';
  if random(2) = 0 then
  begin
    numberLength := 7;
  end else
      begin
        numberLength := 3;
      end;
  for i := 1 to numberLength do
  begin
    x.number := x.number + IntToStr(random(10));
  end;

  listElement := x;
  for s := 2 to count do
  begin
    buff := listElement;
    new(listElement.next);
    listElement := listElement.next;
    listElement.previous := buff;
    listElement.next := nil;
    listElement.number := '+';
    if random(2) = 0 then
    begin
      numberLength := 7;
    end else
        begin
          numberLength := 3;
        end;
    for i := 1 to numberLength do
    begin
      listElement.number := listElement.number + IntToStr(random(10));
    end;
  end;

end;

procedure createSpecialList(var x: specialListPointer; var y: listPointer);
var
  listElement: listPointer;
  specialElement: specialListPointer;
  arr: Array of String;
  numCount,i: Integer;
  sorted: Boolean;
  buff: String;
begin
  listElement := y;
  specialElement := x;
  setLength(arr, count);
  numCount := 0;

  repeat
    if (length(listElement.number) = 8) then
    begin
      arr[numCount] := listElement.number;

      numCount := numCount + 1;
    end;

    listElement := listElement.next;
  until listElement = nil;

  setLength(arr,numCount);

//  writeln;
//  writeln;
  for i := 0 to numCount-1 do
  begin
    writeln(arr[i]);
  end;

  sorted := false;
  while not(sorted) do
  begin
    sorted := true;

    for i := 0 to numCount-2 do
    begin
      if arr[i]>arr[i+1] then
      begin
         buff := arr[i];
         arr[i] := arr[i+1];
         arr[i+1] := buff;
         sorted := false;
      end;
    end;
  end;

  new(specialElement);
  x:= specialElement;
  specialElement.next := nil;
  specialElement.number := arr[0];
  for i := 1 to numCount-1 do
  begin
    new(specialElement.next);
    specialElement := specialElement.next;
    specialElement.next := nil;
    specialElement.number := arr[i];
  end;

end;

var
  listHead, listElement: listPointer;
  specialHead, specialElement: specialListPointer;
begin
  randomize;
  createList(listHead);

  listElement := listHead;
  repeat
    writeln(listElement.number);
    listElement := listElement.next;
  until listElement = nil;

  writeln;
  writeln;

  listElement := listHead;
  repeat
    listElement := listElement.next;
  until listElement.next = nil;
  repeat
    writeln(listElement.number);
    listElement := listElement.previous;
  until listElement = nil;


  writeln;
  writeln;

  createSpecialList(specialHead, listHead);

  writeln;
  writeln;
  specialElement := specialHead;
  if specialElement <> nil then
  begin
    repeat
      writeln(specialElement.number);
      specialElement := specialElement.next;
    until specialElement = nil;
  end;


  readln;
end.
