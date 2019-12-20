unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

const
  CENTRAL_INDEX = 500;
  MAX_NODES = 50;
  ITEM_EDGE = 50;
  STEP_TIME = 100;

type
  TTreePtr = ^TTreeNode;
  TTreeNode = Record
    Body: Integer;
    Left: TTreePtr;
    Right: TTreePtr;
    HasRightThread: Boolean;
    ItemHandle: TButton;
  end;

  TNodes = array [1..50] of TButton;

  TMainForm = class(TForm)
    DirectSearchLabel: TLabel;
    SymmetricalSearch: TLabel;
    ReversedSearch: TLabel;
    DirectSearchButton: TButton;
    DrawPic: TImage;
    SymmetricSearchButton: TButton;
    RevercedSearchButton: TButton;
    RemoveButton: TButton;
    RemoveField: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure PrintTree(TreeHead: TTreePtr; Shift: Integer);
    procedure DirectSearchButtonClick(Sender: TObject);
    procedure DirectDraw(TreeHead: TTreePtr);
    procedure RevercedSearchButtonClick(Sender: TObject);
    procedure SymmetricSearchButtonClick(Sender: TObject);
    function SymSearch(TreeHead: TTreePtr): String;
    procedure ThreadIt(TreeHead: TTreePtr);
    procedure RemoveButtonClick(Sender: TObject);
    //procedure Draw(El:TTreePtr;Y,X1,X2:Integer;var bmp:TBitmap);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  TreeHead: TTreePtr;
  NodesNum: Integer;
  Nodes: TNodes;
  RealNodes: Integer = 1;
  CurTop: Integer = 5;
  FinalTop: Integer = 200;
  FirstHead: Boolean = True;
  LastX, LastY: Integer;
  MainCanvas: TCanvas;
  GlobalPtr: TTreePtr;
  //prev:TTreePtr;
  GlobalResult: String;
  NeedNodes: TNodes;
  RealNeedNodes: Integer = 1;
  PrevItem: TTreePtr;

implementation

{$R *.dfm}

procedure Delay(const Delay: Cardinal);
var
  StT: Cardinal;
begin
  StT:= GetTickCount;
  repeat
    Application.ProcessMessages;
  until (GetTickCount - StT) >= Delay;
end;

procedure AddToTree(var TreeHead: TTreePtr; ValToAdd: Integer);
begin
  if  TreeHead = nil then begin
    New(TreeHead);
    TreeHead^.Body:= ValToAdd;
    TreeHead^.Left:= nil;
    TreeHead^.Right:= nil;
    TreeHead^.HasRightThread:= False;
  end
  else if ValToAdd < TreeHead^.Body then AddToTree(TreeHead^.Left, ValToAdd)
  else AddToTree(TreeHead^.Right, ValToAdd);
end;

function GenerateTree(var TreeHead: TTreePtr; NodeNum: Integer): Boolean;
var
  I: Integer;
begin
  TreeHead:= nil;
  New(TreeHead);
  TreeHead^.Body:= CENTRAL_INDEX;
  TreeHead^.Left:= nil;
  TreeHead^.Right:= nil;
  TreeHead^.HasRightThread:= False;
  Randomize;
  for I:= 2 to NodeNum do begin
    if I < NodeNum div 2 then AddToTree(TreeHead, I + Random(1000))
    else AddToTree(TreeHead, I + 100 + Random(1000));
  end;
end;

function GetButton(C: String): TButton;
var
  I: Integer;
begin
  for I:= 1 to RealNodes do begin
    if C = Nodes[I].Caption then begin
      Result:= Nodes[I];
      break;
    end;
  end;
end;

function DirectSearch(TreeHead: TTreePtr): String;
var
  Pic: TButton;
  W: String;
begin
  if TreeHead = nil then
  begin
    Result:='0 ';
    Exit;
  end;
  Pic:= GetButton(TreeHead^.Body.ToString);

  Result:=Result + '('+IntToStr(TreeHead^.Body) + ')' + ' ';

  Pic.ClientHeight := Round(Pic.ClientHeight * 1.25);
  Pic.ClientWidth := Round(Pic.ClientWidth * 1.25);
  Pic.Font.Size := Round(Pic.Font.Size * 1.25);
  Delay(STEP_TIME);
  Pic.ClientHeight := Round(Pic.ClientHeight / 1.25);
  Pic.ClientWidth := Round(Pic.ClientWidth / 1.25);
  Pic.Font.Size := Round(Pic.Font.Size / 1.25);

  Result:= Result + DirectSearch(TreeHead^.Left);
  Result:= Result + IntToStr(TreeHead^.Body)+ ' ';

  Result:= Result + DirectSearch(TreeHead^.Right);
  Result:= Result + IntToStr(TreeHead^.Body) + ' ';
end;

function ReversiveSearch(TreeHead: TTreePtr): String;
var
  Pic: TButton;
  W: String;
begin
  if TreeHead = nil then
  begin
    Result:= '0 ';
    Exit;
  end;
  Pic:= GetButton(TreeHead^.Body.ToString);

  Result:= IntToStr(TreeHead^.Body) + ' ';

  Result:= Result + ReversiveSearch(TreeHead^.Left);
  Result:= Result + IntToStr(TreeHead^.Body) + ' ';

  Result:= Result + ReversiveSearch(TreeHead^.Right);
  Result:= Result + '('+IntToStr(TreeHead^.Body) + ')' + ' ';

  Pic.ClientHeight := Round(Pic.ClientHeight * 1.25);
  Pic.ClientWidth := Round(Pic.ClientWidth * 1.25);
  Pic.Font.Size := Round(Pic.Font.Size * 1.25);
  Delay(STEP_TIME);
  Pic.ClientHeight := Round(Pic.ClientHeight / 1.25);
  Pic.ClientWidth := Round(Pic.ClientWidth / 1.25);
  Pic.Font.Size := Round(Pic.Font.Size / 1.25);
end;


function TMainForm.SymSearch(TreeHead: TTreePtr): String;
var
  Res: String;
  W: String;
  Pic: TButton;
  procedure SubSymSearch(SubPtr: TTreePtr);
  begin
    GlobalResult:= GlobalResult + '(' + SubPtr^.Body.ToString + ') ';

    NeedNodes[RealNeedNodes]:= SubPtr^.ItemHandle;
    Inc(RealNeedNodes);

    Pic:= GetButton(SubPtr^.Body.ToString);

    Pic.ClientHeight := Round(Pic.ClientHeight * 1.25);
    Pic.ClientWidth := Round(Pic.ClientWidth * 1.25);
    Pic.Font.Size := Round(Pic.Font.Size * 1.25);
    Delay(STEP_TIME);
    Pic.ClientHeight := Round(Pic.ClientHeight / 1.25);
    Pic.ClientWidth := Round(Pic.ClientWidth / 1.25);
    Pic.Font.Size := Round(Pic.Font.Size / 1.25);

    if GlobalPtr <> nil then begin
      if GlobalPtr^.Right = nil then
      begin
        GlobalPtr^.HasRightThread:= False;
        //GlobalPtr^.Right:= SubPtr;
      end
    else
      GlobalPtr^.HasRightThread:= True;
      GlobalResult:= GlobalResult + '0 ';
    end;
    GlobalPtr:= SubPtr;
  end;
begin
  if TreeHead <> nil then begin
    GlobalResult:= GlobalResult + TreeHead^.Body.ToString + ' ';

    SymSearch(TreeHead^.Left);
    SubSymSearch(TreeHead);
    SymSearch(TreeHead^.Right);
  end
  else if TreeHead = nil then begin
    GlobalResult:= GlobalResult + '0 ';
  end;
end;

procedure TMainForm.SymmetricSearchButtonClick(Sender: TObject);
begin
  GlobalResult:= '';
  SymSearch(TreeHead);
  SymmetricalSearch.Caption:= GlobalResult;
  FirstHead:= True;
  ThreadIt(TreeHead);
end;

procedure TMainForm.DirectDraw(TreeHead: TTreePtr);
var
  Pic: TButton;
begin
  if TreeHead = nil then
  begin
    Exit;
  end;

  Pic:= GetButton(TreeHead^.Body.ToString);
  ////////////
  if not FirstHead then begin
    DrawPic.Canvas.Pen.Color:= clBlack;
    DrawPic.Canvas.Pen.Width:= 3;
    DrawPic.Canvas.MoveTo(LastX, LastY);
    DrawPic.Canvas.LineTo(Pic.Left, Pic.Top);
  end;

  LastX:= Pic.Left;
  LastY:= Pic.Top;
  FirstHead:= False;

  DirectDraw(TreeHead^.Left);

  if not FirstHead then begin
    DrawPic.Canvas.Pen.Color:= clBlack;
    DrawPic.Canvas.Pen.Width:= 3;
    DrawPic.Canvas.MoveTo(LastX, LastY);
    DrawPic.Canvas.LineTo(Pic.Left, Pic.Top);
  end;

  LastX:= Pic.Left;
  LastY:= Pic.Top;
  FirstHead:= False;

  DirectDraw(TreeHead^.Right);

  if not FirstHead then begin
    DrawPic.Canvas.Pen.Color:= clBlack;
    DrawPic.Canvas.Pen.Width:= 3;
    DrawPic.Canvas.MoveTo(LastX, LastY);
    DrawPic.Canvas.LineTo(Pic.Left, Pic.Top);
  end;

  LastX:= Pic.Left;
  LastY:= Pic.Top;
  FirstHead:= False;
end;


procedure TMainForm.PrintTree(TreeHead: TTreePtr; Shift: Integer);
var
  FinalShift: Integer;
  I: Integer;
begin
  if TreeHead <> nil then begin
    PrintTree(TreeHead^.Left, Shift + 1);
    FinalShift:= Shift * 70;

    Nodes[RealNodes]:= TButton.Create(MainForm);
    Nodes[RealNodes].Parent:= MainForm;
    Nodes[RealNodes].Left:= FinalTop + 150;
    Nodes[RealNodes].Top:= FinalShift;
    Nodes[RealNodes].Height:= ITEM_EDGE;
    Nodes[RealNodes].Width:= ITEM_EDGE;
    Nodes[RealNodes].Caption:= TreeHead^.Body.ToString;
    Nodes[RealNodes].Font.Size:= 11;
    TreeHead^.ItemHandle:= Nodes[RealNodes];

    Inc(RealNodes);
    Inc(FinalTop, 70);
    PrintTree(TreeHead^.Right, Shift + 1);
  end;
end;


function FindItem(FindBody: Integer; Tree: TTreePtr): TTreePtr;
begin
  if Tree = nil then begin
    Result:= Tree;
    Exit;
  end;
  if Tree^.Body = FindBody then Result:= Tree
  else begin
    PrevItem:= Tree;
    if Tree^.Body < FindBody then
      Result:= FindItem(FindBody, Tree^.Right)
    else
      Result:= FindItem(FindBody, Tree^.Left);
  end;
end;

procedure RemoveNodes();
var
  I: Integer;
begin
  for I:= 1 to RealNodes - 1 do begin
    Nodes[I].Visible:= not Nodes[I].Visible;
    Nodes[I].Free;
  end;
end;

procedure TMainForm.ThreadIt(TreeHead: TTreePtr);
var
  Pic: TButton;
  I: Integer;
  LastX, LastY: Integer;
begin
  LastX:= NeedNodes[1].Left;
  LastY:= NeedNodes[1].Top;
  for I:= 2 to RealNeedNodes - 1 do begin
    Pic:= NeedNodes[I];

    if FindItem(StrToInt(NeedNodes[I-1].Caption),TreeHead).Right = nil then
    begin
      DrawPic.Canvas.Pen.Color:= clRed;
      DrawPic.Canvas.Pen.Width:= 3;
      DrawPic.Canvas.MoveTo(LastX, LastY);
      DrawPic.Canvas.LineTo(Pic.Left, LastY);
      DrawPic.Canvas.LineTo(Pic.Left, Pic.Top + Pic.ClientHeight div 2 + 10);
      DrawPic.Canvas.LineTo(Pic.Left - 10, Pic.Top + 25 + Pic.ClientHeight div 2 + 10);
      DrawPic.Canvas.LineTo(Pic.Left + 10, Pic.Top + 25 + Pic.ClientHeight div 2 + 10);
      DrawPic.Canvas.LineTo(Pic.Left, Pic.Top + Pic.ClientHeight div 2 + 10);
    end;

    LastX:= Pic.Left;
    LastY:= Pic.Top;
  end;
end;



procedure Delete(var t: TTreePtr; k: Integer);
var q: TTreePtr;
procedure Del(var w: TTreePtr); // поиск самого правого элемента
begin
if w^.right <> nil then Del(w^.right)
  else begin
  q := w;
  // запоминаем адрес, чтобы потом удалить этот элемент
  t^.Body := w^.Body;
  w := w^.left;
  end;
end;

begin

if t <> nil then
if k < t^.Body then Delete(t^.left, k)
else if k > t^.Body then Delete(t^.right, k)
  else begin
  q := t;
  if t^.right = nil then t := t^.left
  // правого поддерева нет
  else if t^.left = nil then t := t^.right
  // левого поддерева нет
  else Del(t^.left);
  // находим самый правый элемент в левом поддереве
  dispose(q);
  end;
end;

procedure TMainForm.RemoveButtonClick(Sender: TObject);
var
  ItemInt: Integer;
begin
  RemoveNodes();

  DrawPic.Canvas.Pen.Width:= 0;
  DrawPic.Canvas.Rectangle(-1, -1, 1500, 600);
  FirstHead:= True;


  RealNodes:= 1;
  CurTop:= 5;
  FinalTop:= 200;
  FirstHead:= True;
  RealNeedNodes:= 1;

  ItemInt:= StrToInt(RemoveField.Text);

  Delete(TreeHead, ItemInt);
  PrintTree(TreeHead, 1);
  DirectDraw(TreeHead);
  //SymSearch(TreeHead);
  //ThreadIt(TreeHead);
end;

procedure TMainForm.RevercedSearchButtonClick(Sender: TObject);
begin
  ReversedSearch.Caption:= ReversiveSearch(TreeHead);
end;

procedure TMainForm.DirectSearchButtonClick(Sender: TObject);
begin
  DirectSearchLabel.Caption:= DirectSearch(TreeHead);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  NodesNum:= 10;
  GenerateTree(TreeHead, NodesNum);
  FirstHead:= True;
  PrintTree(TreeHead, 1);
  DirectDraw(TreeHead);
  //ThreadIt(TreeHead);
end;

end.
