unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.ValEdit;

const
  NODES_NUMBER = 6;

type
  TNode = Record
    Body: Integer;
    Line: String;
  end;

  TSetOfUsed = set of Byte;

  TWay = Record
    NodeName: String;
    Used: TSetOfUsed;
    Cost: Integer;
  end;

  TListPtr = ^TListNode;
  TListNode = record
    Way: TWay;
    Next: TListPtr;
  end;

  DeykstRes = array of Integer;
  TGraphMatrix = array of array of Integer;
  TMinWaysMatrix = array of array of TNode;


  TMainForm = class(TForm)
    GraphTable: TStringGrid;
    StartPointText: TStaticText;
    StartPointEdit: TEdit;
    EndPointText: TStaticText;
    EndPointEdit: TEdit;
    CountButton: TButton;
    GenerateGraphButton: TButton;
    RoutesTable: TValueListEditor;
    ShortestWayText: TStaticText;
    LongestWayText: TStaticText;
    GraphCenterText: TStaticText;
    AllRoutesText: TStaticText;
    procedure FillGraphTable();
    procedure CountButtonClick(Sender: TObject);
    procedure GenerateGraphButtonClick(Sender: TObject);
    procedure SignTableHeaders();
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

  GraphMatrix: TGraphMatrix;
  kol: Integer;
  AllWays: TListPtr;

  I, J, K: Integer;
  Fl: TMinWaysMatrix;
  ListNode: TListPtr;

implementation

{$R *.dfm}

procedure TMainForm.SignTableHeaders();
var
  I: Integer;
begin
  for I:= 1 to NODES_NUMBER do begin
    GraphTable.Cells[0, I]:= I.ToString;
    GraphTable.Cells[I, 0]:= I.ToString;
  end;
end;

function NewList: TListPtr;
begin
  New(Result);
  Result^.Next:= nil;
end;

procedure AddToList(Way:TWay; var List: TListPtr);
var
  LastNode: TListPtr;
begin
  LastNode:= List;
  while LastNode^.Next<> nil do LastNode:= LastNode^.Next;
  New(LastNode^.Next);
  LastNode^.Next^.Way:= Way;
  LastNode^.Next^.Next:= nil;
end;

procedure Sort(var W:TListPtr);
var
  Temp: TWay;
  Cur, Prev: TListPtr;
begin
  Prev:= W;
  while Prev^.Next<> nil do begin
    Prev:= Prev^.Next;
    Cur:= Prev;
    while Cur^.Next <> nil do begin
      Cur:= Cur^.Next;
      if Cur^.Way.Cost < Prev^.Way.Cost then begin
        Temp:= Prev^.Way;
        Prev^.Way:= Cur^.Way;
        Cur^.Way:= Temp;
      end;
    end;
  end;
end;

procedure AddToSortedList(Way: TWay; var List:TListPtr);
var
  X, Y: TListPtr;
begin
  X:= List;
  while (x^.Next <> nil) and (x^.Next.Way.Cost < Way.Cost) do
  New(y);
  y^.Way:=Way;
  New(y^.Next);
  y^.Next:=x^.Next;
  x^.Next:=y;
  New(x^.Next^.Next);
end;

function FindWays(Src, Dest: Integer): TListPtr;
var
  NullWay:TWay;
  procedure FindRoute(V: Integer; Way:TWay);
  var
    i: Integer;
    NewWay:TWay;
  begin
    if V = Dest then begin
      AddToList(Way, AllWays);
    end
    else begin
    for i := 0 to High(GraphMatrix[V]) do
      if (GraphMatrix[V, i] <> 666) and Not( i in Way.Used) then
      begin
        NewWay.Used:= Way.Used + [i];
        NewWay.NodeName:= Way.NodeName +  ' -> ' + IntToStr(i+1);
        NewWay.Cost:=Way.Cost + GraphMatrix[V,i];
        FindRoute(i,NewWay);
      end;
    end;
  end;

begin
  AllWays:= NewList;
  with NullWay do begin
    NodeName:= IntToStr(Src + 1);
    Cost:=0;
    Used:= [Src];
  end;
  FindRoute(Src,NullWay);
  Result:= AllWays;
  Sort(AllWays);
  Result:= AllWays;
end;

procedure GenerateGraph(NodesNum: Integer);
var
  I, J: Integer;
begin
  SetLength(GraphMatrix, NodesNum, NodesNum);
  for I:= 0 to NodesNum - 1 do begin
    for J:= 0 to NodesNum - 1 do begin
      if i=j then begin
        GraphMatrix[I, J]:= 0
      end
      else begin
         GraphMatrix[I, J]:= Random(10) + 1;
      end;
    end;
  end;
end;

procedure TMainForm.FillGraphTable();
var
  I, J: Integer;
begin
  for I:= 0 to NODES_NUMBER - 1do begin
    for J:= 0 to NODES_NUMBER - 1 do begin
      GraphTable.Cells[J+1, I+1]:= GraphMatrix[I, J].ToString;
    end;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  SignTableHeaders();
end;

function Floyd(): TMinWaysMatrix;
var
  I, J, K: Integer;
begin
  SetLength(Result, High(GraphMatrix) + 1, High(GraphMatrix) + 1);
  for I:= 0 to High(GraphMatrix) do begin
    for J:= 0 to High(GraphMatrix) do begin
      Result[I, J].Body:= GraphMatrix[I, J];
      Result[I, J].Line:= IntToStr(I + 1);
    end;
  end;

  for I:= 0 to High(GraphMatrix) do begin
    for J:= 0 to High(GraphMatrix) do begin
      for K:= 0 to High(GraphMatrix) do begin
        if Result[I, K].Body + Result[K, J].Body < Result[I, J].Body then begin
          Result[I, J].Body:= Result[I, K].Body + Result[K, J].Body;
          Result[I, J].Line:= Result[I, J].Line + ','+ Copy(Result[i,k].Line, 3, Length(Result[I, K].Line));
        end;
      end;
      if (Result[i,j].Line <> IntToStr(J + 1)) then Result[I, J].Line:= Result[I, J].Line + ','+ IntToStr(J + 1);
    end;
  end;
end;

function GraphCenter(MinWaysMatrix: TMinWaysMatrix): Integer;
var
  MaxWay: array of Integer;
  I, J: Integer;
begin
  SetLength(MaxWay, High(GraphMatrix)+1);
  for I:= 0 to High(GraphMatrix) do begin
    MaxWay[I]:= MinWaysMatrix[0, I].Body;
    for J:= 0 to High(GraphMatrix) do begin
      if MaxWay[I] < MinWaysMatrix[J, I].Body then MaxWay[I]:= MinWaysMatrix[J, I].Body;
    end;
  end;

  Result:= 0;
  for i := 0 to High(GraphMatrix) do begin
    if MaxWay[i] < MaxWay[Result] then Result:= I + 1;
  end;
end;

procedure TMainForm.CountButtonClick(Sender: TObject);
var
  I: Integer;
  First: Boolean;
begin
  First:= True;
  RoutesTable.Strings.Clear;
  AllWays:= FindWays(StrToInt(StartPointEdit.Text) - 1, StrToInt(EndPointEdit.Text) - 1);
  ListNode:= AllWays^.Next;
  while ListNode <> nil do begin
    RoutesTable.InsertRow(IntToStr(ListNode^.Way.Cost), ListNode^.Way.NodeName, True);
    if First then begin
      First:= False;
      ShortestWayText.Caption:= 'Кратчайший путь: ' + ListNode^.Way.NodeName;
    end;
    if ListNode^.Next = nil then begin
      LongestWayText.Caption:= 'Длиннейший путь: ' + ListNode^.Way.NodeName;
    end;
    ListNode:= ListNode^.Next;
  end;

  Fl:= Floyd();
  GraphCenterText.Caption:= 'Центр графа: ' + GraphCenter(Fl).ToString;
end;

procedure TMainForm.GenerateGraphButtonClick(Sender: TObject);
begin
  GenerateGraph(NODES_NUMBER);
  FillGraphTable();
end;

end.
