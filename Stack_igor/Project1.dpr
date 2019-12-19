program Project1;

{$APPTYPE CONSOLE}

{$R *.res}

uses
SysUtils, Windows;

type
TStack=^TRec;

TRec=record
sym:char;
next:TStack;
end;

procedure push(var st:TStack;symbol:Char);
var
x:TStack;
begin
new(x);
x^.sym:=symbol;
x^.next:=st;
st:=x;
end;
function pop(var st:TStack):Char;
begin
if st<>nil then
begin
pop:=st^.sym;
st:=st^.next;
end;
end;

function getStackPriority (symbol:char):integer;
begin
case symbol of
'+','-' : Result := 2;
'*','/' : Result := 4;
'^' : Result := 5;
'a'..'z','A'..'Z' : Result := 8;
'(' : Result := 0;
end;
end;

function getInputPriority (symbol:char):integer;
begin
case symbol of
'+','-' : Result := 1;
'*','/' : Result := 3;
'^' : Result := 6;
'a'..'z','A'..'Z' : Result := 7;
'(' : Result := 9;
')' : Result := 0;
end;
end;

function getRang(c:char):integer;
begin
if c in ['a'..'z','A'..'Z'] then
Result:=1
else
Result:=-1;
end;

var
st:TStack;
s,result:string;
rang,i:Integer;
symbol:char;
begin
SetConsoleCP(1251);
SetConsoleOutputCP(1251);

st:=nil;
Rang:=0;
result:='';

Write('Введите выражение в инфиксной форме: ');
Readln(s);

i:=1;
while i<=Length(s) do
if (st=nil) or (getInputPriority(s[i]) > getStackPriority(st^.sym)) then
begin
if s[i]<>')' then
push(st,s[i]);
i:=i+1;
end
else
begin
symbol:=pop(st);
if symbol<>'(' then
result:=result+symbol;
end;


while not (st = nil) do
begin
symbol:=pop(st);
if symbol<>'('then
result:=result+symbol;
end;

Write('Постфиксная форма: ');
Writeln(result);

for i:=1 to Length(result)do
rang:=rang+getRang(result[i]);
Write('Ранг выражения: ');
Writeln(rang);
Readln;
end.
