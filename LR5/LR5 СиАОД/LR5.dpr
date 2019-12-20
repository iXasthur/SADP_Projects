program LR5;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Windows;

type
  StackElPT=^TStack;

  TStack = record
    Elem: Char;
    Next: StackElPT;
  end;

var
  Rang, i: Integer;
  input, str: string;

Procedure AddStack(var st: StackElPT; const value: Char);
var
  x: StackElPT;
begin
  new(x);
  x^.Elem:=value;
  x^.next:=st;
  st:=x;
end;

function GetStack(var st: StackElPT): Char;
begin
  if st <> nil then
  begin
    GetStack := st^.Elem;
    st := st^.next;
  end
  else
    GetStack := #0;
end;

function StackPriority(c: Char): Integer;
begin
  case c of
    '+', '-': Result := 2;
    '*', '/': Result := 4;
    '^': Result := 5;
    'a'..'z','A'..'Z': Result := 8;
    '(': Result := 0;
  else
      Result := 10;
  end;
end;

function InputPriority(c: Char): Integer;
begin
  case c of
    '+', '-': Result := 1;
    '*', '/': Result := 3;
    '^': Result := 6;
    'a'..'z','A'..'Z': Result := 7;
    '(': Result := 9;
    ')': Result := 0;
  else
    Result := 10;
  end;
end;


function CharRang(c: Char): Integer;
begin
  if CharInSet(c, ['a'..'z', 'A'..'Z']) then
    Result := 1
  else
  if CharInSet(c, [')', '(']) then
    Result := 0
  else
    Result := -1;
end;

function StackWrite(st: StackElPT): string;
var
  str, s: string;
  i: Integer;
begin
  if St = nil then
    s:='-|'
  else
  begin
    str:='';
    s:='';
    while St<>nil do
    begin
      str:=str+St^.Elem;
      St:=St^.Next;
    end;
    for i:=1 to Length(str) do
    begin
      s:=s+str[Length(str)-i+1];
    end;
  end;
  for i := 1 to 10 - Length(s) do
    s := s+' ';
  Result := S;
end;

function Notation(input: string): string;
var
  st: StackElPT;
  output: string;
  i: Integer;
  t: Char;
begin
  st := nil;
  output := '';
  i := 1;
  while i <= Length(input) do
  begin
    if Input[i] <> ' ' then
    begin
      if (st = nil) or (InputPriority(Input[i]) > StackPriority(st^.Elem)) then
      begin
        if Input[i] <> ')' then
          AddStack(st,input[i]);
        Writeln(Input[i], ' | ', StackWrite(st), ' | ', output);
        inc(i);
      end
      else
      begin
        t := GetStack(st);
        if t <> '(' then
          output := output + t
        else
        if Input[i] = ')' then
          inc(i);
      end
    end
    else
      inc(i);
  end;
  while not (st = nil) do
  begin
    t := GetStack(st);
    if t <> '(' then
      output := output + t;
  end;
  Writeln(Input[i], ' | ', StackWrite(st), ' | ', output);
  Result := output;
end;

begin
  Write('Введите выражение: ');
  Readln(input);
  input := Trim(input);
  str := Notation(input);
  Writeln;
  Write('Обратная польская запись: ');
  Writeln(str);
  Write('Ранг выражения: ');
  Rang := 0;
  for I := 1 to Length(str) do
    Rang := Rang + CharRang(str[i]);
  Writeln(Rang);
  Readln;
end.
