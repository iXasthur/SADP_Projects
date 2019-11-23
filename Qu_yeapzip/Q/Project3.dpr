program Project3;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

const
  PROCS_NUMBER = 6;
  PROC1_STATES = 8;
  PROC2_STATES = 10;
  PROC3_STATES = 9;
  PROC4_STATES = 9;
  PROC5_STATES = 10;
  PROC6_STATES = 10;
  MAX_STATES = 10;

type
  TStates = array [1..MAX_STATES] of Integer;
  TProcPtr = ^TProc;
  TProc = record
    States: TStates;
    CurState: Integer;
    CurJob: Integer;
    Priority: Integer;
    WasUsed: Boolean;
    IsActive: Boolean;
    NextProc: TProcPtr;
  end;
  TAllStates = array [1..PROCS_NUMBER] of TStates;

var
  AllStates: TAllStates = ((8, 11, 5, 4,  1, 9, 11, 8,  0, 0),
                           (2,  3, 2, 1,  3, 4,  5, 1,  2, 1),
                           (6,  3, 8, 2,  1, 4,  6, 8,  7, 0),
                           (5,  4, 3, 4,  2, 1,  5, 4,  3, 0),
                           (8,  6, 8, 2,  3, 2,  1, 3, 12, 7),
                           (7,  6, 5, 7, 11, 3,  7, 8,  6, 4));
  HeadProc, CurProc: TProcPtr;
  AllTime, LoseTime: Integer;
  Koef: Real;

function StatesSum(): Integer;
var
  Sum, I, J: Integer;
begin
  Sum:= 0;
  I:= 1;
  J:= 1;
  for I:= 1 to 6 do begin
    for J:= 1 to 10 do begin
      Sum:= Sum + AllStates[I][J];
    end;
  end;
  Result:= Sum;
end;


procedure InitQueue();
var
  I: Integer;
begin
  New(CurProc);
  HeadProc:= CurProc;
  for I:= 1 to PROCS_NUMBER do begin
    New(CurProc^.NextProc);
    CurProc:= CurProc^.NextProc;
    CurProc^.States:= AllStates[I];
    CurProc^.CurState:= 1;
    CurProc^.CurJob:= 1;
    if (I = 1) or (I = 2) or (I = 3) then CurProc^.Priority:= 1
    else if (I = 4) then CurProc^.Priority:= 2
    else CurProc^.Priority:= 3;
    CurProc^.WasUsed:= False;
    CurProc^.IsActive:= False;
  end;
  CurProc^.NextProc:= nil;
end;

procedure PrintProcs(HeadProc: TProcPtr);
var
  I, J: Integer;
  NextLine: String;
begin
  HeadProc:= HeadProc^.NextProc;
  for I:= 1 to 6 do begin
    NextLine:= '';
    NextLine:= NextLine + HeadProc^.CurJob.ToString + '   ' + HeadProc^.Priority.ToString;
    Writeln(NextLine);
    HeadProc:= HeadProc^.NextProc;
  end;
end;

procedure SortProcs(HeadProc: TProcPtr);
var
  I, J: Integer;
  CurProc, HProc: TProcPtr;
  BufProc: TProc;
begin
  for I:= 1 to 6 do begin
    HProc:= HeadProc^.NextProc;
    while HProc^.NextProc <> nil do begin
      if HProc^.Priority < HProc^.NextProc^.Priority then begin
        BufProc:= HProc^;
        HProc^.States:= HProc^.NextProc^.States;
        HProc^.CurState:= HProc^.NextProc^.CurState;
        HProc^.CurJob:= HProc^.NextProc^.CurJob;
        HProc^.Priority:= HProc^.NextProc^.Priority;
        HProc^.WasUsed:= HProc^.NextProc^.WasUsed;
        HProc^.IsActive:= HProc^.NextProc^.IsActive;

        HProc^.NextProc^.States:= BufProc.States;
        HProc^.NextProc^.CurState:= BufProc.CurState;
        HProc^.NextProc^.CurJob:= BufProc.CurJob;
        HProc^.NextProc^.Priority:= BufProc.Priority;
        HProc^.NextProc^.WasUsed:= BufProc.WasUsed;
        HProc^.NextProc^.IsActive:= BufProc.IsActive;
      end;
      HProc:= HProc^.NextProc;
    end;
  end;
end;

procedure RemoveItem(HeadProc: TProcPtr; RemProc: TProcPtr);
var
  HProc, CurProc, LastProc: TProcPtr;
  Flag: Boolean;
begin
  Flag:= False;
  LastProc:= HeadProc;
  HProc:= HeadProc^.NextProc;
  while not Flag do begin
    if HProc = RemProc then begin
      LastProc^.NextProc:= HProc^.NextProc;
      Flag:= True;
    end;
    LastProc:= HProc;
    HProc:= HProc^.NextProc;
  end;
end;

procedure AddItem(HeadProc: TProcPtr; AddProc: TProc);
var
  HProc: TProcPtr;
begin
  HProc:= HeadProc^.NextProc;
  while HProc^.NextProc <> nil do begin
    HProc:= HProc^.NextProc;
  end;
  New(HProc^.NextProc);
  HProc:= HProc^.NextProc;
  HProc^:= AddProc;
  HProc^.NextProc:= nil;
end;

procedure GetK(HeadProc: TProcPtr; T, W: Integer);
var
  HProc: TProcPtr;
  I, J: Integer;
  Flag: Boolean;
begin
  Flag:= True;
  HProc:= HeadProc^.NextProc;
  while ((HProc^.Priority = 3) or (HProc^.Priority = 2) or (HProc^.Priority = 1)) and Flag do begin
    if HProc^.States[HProc^.CurJob] = 0 then begin
      if HProc^.CurJob < 10 then begin
        Inc(HProc^.CurJob);
        continue;
      end
      else begin
        if HProc^.NextProc <> nil then begin
          HProc:= HProc^.NextProc;
        end
        else begin
          Flag:= False;
          continue;
        end;
      end;
    end;
    if HProc^.States[HProc^.CurJob] - T > 0 then begin
      HProc^.States[HProc^.CurJob]:= HProc^.States[HProc^.CurJob] - T;
    end
    else if HProc^.States[HProc^.CurJob] - T = 0 then begin
      HProc^.States[HProc^.CurJob]:= HProc^.States[HProc^.CurJob] - T;
      if HProc^.CurJob < 10 then begin
        Inc(HProc^.CurJob);
      end
      else begin
        if HProc^.NextProc <> nil then begin
          HProc:= HProc^.NextProc;
        end
        else begin
          Flag:= False;
        end;
      end;
    end
    else begin
      LoseTime:= LoseTime + 1;
      if HProc^.CurJob < 10 then begin
        Inc(HProc^.CurJob);
        HProc^.States[HProc^.CurJob]:= HProc^.States[HProc^.CurJob] - (W - abs(HProc^.States[HProc^.CurJob] - T));
      end
      else begin
        if HProc^.NextProc <> nil then begin
          HProc:= HProc^.NextProc;
        end
        else begin
          Flag:= False;
        end;
      end;
    end;
    AllTime:= AllTime + 1;
  end;
end;

procedure DoAllStuff(HeadProc: TProcPtr);
var
  TickT, WriteT: Integer;
  K: Real;
begin
//  Writeln('+-------+--------------------------------------------------------------------------------------------------+');
//  Writeln('|       |                                  Write Time                                                      |');
//  Writeln('|ClkTime|--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------|');
//  Writeln('|       |   0    |   1    |   2    |   3    |   4    |   5    |   6    |   7    |   8    |   9    |   10   |');
//  Writeln('|-------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|');
  Writeln('|-------|--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------|');
  Writeln('|   x   |   0    |   1    |   2    |   3    |   4    |   5    |   6    |   7    |   8    |   9    |   10   |');
  Writeln('|-------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|');
  for TickT:= 1 to 10 do begin
    Write(  '|  ', TickT:2, '   |');
    for WriteT:= 0 to 10 do begin
      InitQueue();
      SortProcs(HeadProc);
      GetK(HeadProc, TickT, WriteT);
      //K:= (StatesSum()/(AllTime * TickT/TickT));
      K:= abs(1 - (LoseTime/AllTime));
      Write(K:1:2, ' ', LoseTime:3, '|');
    end;
    Writeln;
    Writeln('|-------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|');
  end;
end;

var
  BuffProc: TProc;
begin
  InitQueue();
  SortProcs(HeadProc);
  //PrintProcs(HeadProc);
  DoAllStuff(HeadProc);
  Readln;
end.
