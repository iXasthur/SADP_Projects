program SADP_L1;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

const
  k = 3;
  nMax = 64;

type
  p = ^member;
  member = Record
    number: Integer;
    next: p;
  End;


procedure create(var x: p; n:Integer);
var
  i: integer;
  first: p;
begin
  new(x);
  first := x;
  x.number := 1;

  for i := 2 to n do
  begin
    new(x.next);
    x := x.next;
    x.next := nil;
    x.number := i;
  end;

  x.next := first;
  x := x.next;
end;

procedure clearCircle(var x:p);
var
  i,offset: Integer;
  circleElement: p;
  removedOne: Boolean;
begin
  circleElement := x;
  removedOne := false;
  offset := 2;
  repeat
    for i := 1 to k-offset do
    begin
      circleElement := circleElement.next;
    end;
    write(circleElement.next.number,' ');
    circleElement.next := circleElement.next.next;
    removedOne := true;
    offset := 1;
  until circleElement.next = circleElement;

  write(' // ',circleElement.number);
end;

var
  i: Integer;
  circleHead,circleElement: p;
begin
  for i := 1 to nMax do
  begin
    writeln;
    writeln('N:',i);
    create(circleHead, i);
    clearCircle(circleHead);
  end;
  readln;
end.
