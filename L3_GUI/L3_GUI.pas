unit L3_GUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

type
  TForm1 = class(TForm)
    GridPanel1: TGridPanel;
    Memo1: TMemo;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Label1: TLabel;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    INPUT_TF: TMemo;
    SpeedButton8: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
const
  hashListSize = 500;
  mainFileName = 'Input.txt';
  stdStrSize = 100;
  detailedOutput = false;

type
  fileElementString = String[stdStrSize];
  fileStringsArray = Array of fileElementString;

  pagesListElementPointer = ^pagesListElement;
  pagesListElement = Record
    name: String;
    value: Array of Integer;
    nextElement: pagesListElementPointer;
  End;

  hashListElementPointer = ^hashListElement;
  hashListElement = Record
    key: String;
    value: String;
    additionalListElement: hashListElementPointer;
    pages: pagesListElementPointer;
    internalList: hashListElementPointer;
    nextElement: hashListElementPointer;
  End;

var
  hashListHead,outputListHead,currentElementPointer,currentHeadPointer: hashListElementPointer;
  pageListHead: pagesListElementPointer;


function getHashOfString(hashableString: String): Integer;
var
  value, i: Integer;
begin
  getHashOfString := 0;
  value := 0;

  for i := 1 to Length(hashableString) do
  begin
    value := value + ord(hashableString[i]);
  end;

  getHashOfString := (value mod hashListSize);
end;

function generateRandomString(L: Integer): String;
var
  str: String;
  i: Integer;
begin
  generateRandomString := '';
  str := '';
  for i := 1 to L do
  begin
    case i mod 3 of
      0:
        str := str + Chr(ord('a') + Random(26));
      1:
        str := str + Chr(ord('A') + Random(26));
      2:
        str := str + Chr(ord('0') + Random(10));
    end;

  end;

  generateRandomString := str;
end;

function generateKeyV(initialStr: String): String;
begin
  //insert(generateRandomString(15),initialStr,pos('%',initialStr)+1);
  generateKeyV := initialStr;
end;


function getPagesByName(const head: pagesListElementPointer; const name: String): String;
var
  buffStr: String;
  element: pagesListElementPointer;
  i: Integer;
begin
  element := head;
  buffStr := '';

  while element<>nil do
  begin
    if element.name = name then
    begin
      for i := 0 to Length(element.value)-1 do
      begin
        buffStr:= buffStr + ' ' + IntToStr(element.value[i]);
      end;

      element := nil;
    end;

    if element <> nil then
    begin
      element := element.nextElement;
    end;
  end;

  if buffStr <> '' then
  begin
    insert('(',buffStr,2);
    buffStr := buffStr + ')';
  end;

  getPagesByName := buffStr;
end;


procedure createFile(name: String);
var
  F: File of fileElementString;
  str: fileElementString;
begin
  Assign(F,name);
  rewrite(f);
  str := generateKeyV('(EUROPE)%(1)');
  write(f,str);
  str := generateKeyV('_(FRANCE)%(1)');
  write(f,str);
  str := generateKeyV('__(PARIS)%(3)');
  write(f,str);
  str := generateKeyV('__(LYON)%(4)');
  write(f,str);
  str := generateKeyV('__(CAEN)%(5)');
  write(f,str);
  str := generateKeyV('_(GERMANY)%(10)');
  write(f,str);
  str := generateKeyV('__(BERLIN)%(11)');
  write(f,str);
  str := generateKeyV('__(FRANKFURT)%(12)');
  write(f,str);
  str := generateKeyV('__(MUNICH)%(13)');
  write(f,str);
  str := generateKeyV('_(UK)%(50)');
  write(f,str);
  str := generateKeyV('__(LONDON)%(50)');
  write(f,str);
  str := generateKeyV('__(YORK)%(51)');
  write(f,str);
  str := generateKeyV('__(NORWICH)%(52)');
  write(f,str);
  str := generateKeyV('__(BATH)%(53)');
  write(f,str);
  str := generateKeyV('__(MINSK)%(105)');
  write(f,str);
  str := generateKeyV('(NORTH AMERICA)%(100)');
  write(f,str);
  str := generateKeyV('_(USA)%(100)');
  write(f,str);
  str := generateKeyV('__(NEW-YORK)%(101)');
  write(f,str);
  str := generateKeyV('__(SAN-FRANCISCO)%(102)');
  write(f,str);
  str := generateKeyV('__(LOS-ANGELES)%(103)');
  write(f,str);
  str := generateKeyV('__(CHICAGO)%(104)');
  write(f,str);
  str := generateKeyV('__(MINSK)%(105)');
  write(f,str);
  str := generateKeyV('__(PITTSBURG)%(106)');
  write(f,str);
  str := generateKeyV('_(CANADA)%(110)');
  write(f,str);
  str := generateKeyV('__(TORONTO)%(111)');
  write(f,str);
  str := generateKeyV('__(OTTAWA)%(112)');
  write(f,str);
  str := generateKeyV('__(MONTREAL)%(113)');
  write(f,str);
  str := generateKeyV('_(MEXICO)%(120)');
  write(f,str);
  str := generateKeyV('__(MEXICO CITY)%(121)');
  write(f,str);
  str := generateKeyV('__(CANCUN)%(122)');
  write(f,str);
  str := generateKeyV('(ABC)%(500)');
  write(f,str);
  str := generateKeyV('_(D)%(504)');
  write(f,str);
  str := generateKeyV('_(A)%(501)');
  write(f,str);
  str := generateKeyV('__(B)%(502)');
  write(f,str);
  str := generateKeyV('___(C)%(503)');
  write(f,str);
  close(f);
end;

procedure addPageElement(var head: pagesListElementPointer; var element: pagesListElementPointer);
var
  el: pagesListElementPointer;
  i,q:Integer;
  foundPage, addedPages:Boolean;
begin
  el := head;
  addedPages := false;
  while el<>nil do
  begin
    if el.name = element.name then
    begin
      for i := 0 to Length(element.value)-1 do
      begin
        foundPage := false;
        for q := 0 to Length(el.value)-1 do
        begin
          if el.value[q] = element.value[i] then
          begin
            foundPage := true;
          end;

          if not(foundPage) then
          begin
            SetLength(el.value,Length(el.value)+1);
            el.value[Length(el.value)-1] := element.value[i];
          end;

          addedPages := true;
        end;
      end;

      el := nil;
    end;

    if el<>nil then
    begin
      el := el.nextElement;
    end;
  end;

  if not(addedPages) then
  begin
    el := head;

    while el.nextElement<>nil do
    begin
      el := el.nextElement;
    end;


    new(el.nextElement);
    el := el.nextElement;
    el.name := element.name;
    el.nextElement := nil;

    SetLength(el.value,Length(element.value));
    for i := 0 to Length(el.value)-1 do
    begin
      el.value[i] := element.value[i];
    end;
  end;
end;

procedure extractPages(var arr: fileStringsArray; var head: pagesListElementPointer);
var
  i,p,p1,p2,count,q: Integer;
  element: pagesListElementPointer;
  buffStr,buffName,buffNum: String;
  buffArr: Array of Integer;
begin
  if head = nil then
  begin
    new(head);
    head.name := '';
    head.nextElement := nil;
  end;


  for i := 0 to Length(arr) do
  begin
    p1 := pos('(',arr[i]) + 1;
    p2 := pos(')',arr[i]);
    buffName := '';
    buffName := copy(arr[i],p1,p2-p1);
//    writeln(buffName);

    p := pos('%',arr[i]);
    buffStr := copy(arr[i],pos('(',arr[i],p),pos(')',arr[i],pos('(',arr[i],p)));
    if buffStr <> '()' then
    begin
      element := nil;

      buffNum := '';
      count := 0;
      SetLength(buffArr,0);
      while length(buffStr) > 0 do
      begin
        if (buffStr[1]>='0') and (buffStr[1]<='9') then
        begin
          buffNum := buffNum + buffStr[1];
          delete(buffStr,1,1);
        end else
            begin
              if buffNum <> '' then
              begin
//                writeln(buffNum);
                count := count + 1;
                SetLength(buffArr,count);
                buffArr[count-1] := StrToInt(buffNum);
                buffNum := '';
              end;
              delete(buffStr,1,1);
            end;
      end;

      if count>0 then
      begin
        new(element);
        element.name := buffName;
        SetLength(element.value,Length(buffArr));
        for q := 0 to Length(element.value)-1 do
        begin
          element.value[q] := buffArr[q];
        end;
        addPageElement(head,element);
//        dispose(element);
      end;
//      writeln(' ',count);
    end;

    Delete(arr[i],p,pos(')',arr[i],p)-p+1);
  end;
end;

procedure outputFile(name: String);
var
  F: File of fileElementString;
  str: fileElementString;
begin
  Assign(F,name);
  reset(F);
  while (not(eof(F))) do
  begin
    read(F,str);
    writeln(str);
  end;
  close(F);
end;

function getStringsFromFile(name: String): fileStringsArray;
var
  F: File of fileElementString;
  count: Integer;
  arr: fileStringsArray;
begin
  count := 0;

  Assign(F,name);
  reset(F);
  while (not(eof(F))) do
  begin
    count := count + 1;
    SetLength(arr, count);
    read(F,arr[count-1]);
  end;
  close(F);

  getStringsFromFile := arr;
end;

procedure createHashListElement(var element: hashListElementPointer);
begin
  if element = nil then
  begin
    new(element);
  end;
  element.key := '';
  element.value := '';
  element.additionalListElement := nil;
  element.pages := nil;
  element.internalList := nil;
  element.nextElement := nil;
end;

procedure createHashList(var head: hashListElementPointer);
var
  i: Integer;
  element: hashListElementPointer;
begin
  createHashListElement(head);
  element := head;

  for i := 2 to hashListSize do
  begin
    new(element.nextElement);
    element := element.nextElement;
    createHashListElement(element);
  end;

end;

procedure updateValue(forKey: String; strValue: String ;var listHeadPointer: hashListElementPointer; pageListHead: pagesListElementPointer);
var
  hash,i: Integer;
  element: hashListElementPointer;
begin
  if listHeadPointer = nil then
  begin
    createHashList(listHeadPointer);
  end;
  element := listHeadPointer;
  hash := getHashOfString(forKey);
  for i := 1 to hash do
  begin
    element := element.nextElement;
  end;

//  if element.key <> '' then
//  begin
//    while (element.additionalListElement <> nil) and (element.key <> forKey) do
//    begin
//      element := element.additionalListElement
//    end;
//
//    if (element.key <> forKey) then
//    begin
//      createHashListElement(element.additionalListElement);
//      element := element.additionalListElement;
//    end;
//  end;
  //writeln('Updating value for key ''',forKey,''' from ''',element.value,''' to ''',strValue,'''');
  if element.key = forKey then
  begin
    element.value := strValue;
  end else
      begin
        if element.key = '' then
        begin
          element.key := forKey;
          element.value := strValue;
        end else
            begin
              while (element.additionalListElement <> nil) and (element.key <> forKey) do
              begin
                element := element.additionalListElement
              end;

              if (element.key = forKey) then
              begin
                element.value := strValue;
              end else
                  begin
                    createHashListElement(element.additionalListElement);
                    element := element.additionalListElement;

                    element.key := forKey;
                    element.value := strValue;
                  end;
            end;
      end;
  element.pages := pageListHead;
end;

procedure outputHashListElement(element: hashListElementPointer; var buffString: String);
begin
  if detailedOutput then
  begin
//    write(': [KEY: ''',element.key);
    buffString := buffString + ': [KEY: ''' + element.key;
//    write(''' VALUE: ''',element.value);
    buffString := buffString + ''' VALUE: ''' + element.value;
    if element.pages <> nil then
    begin
//      write(''' PAGES: TRUE');
      buffString := buffString + ''' PAGES: TRUE';
    end else
        begin
//          write(''' PAGES: FALSE');
          buffString := buffString + ''' PAGES: FALSE';
        end;

    if element.internalList <> nil then
    begin
//      writeln(' INTERNAL LIST: TRUE]');
      buffString := buffString + ' INTERNAL LIST: TRUE]' + #13 + #10;
    end else
        begin
//          writeln(' INTERNAL LIST: FALSE]');
          buffString := buffString + ' INTERNAL LIST: FALSE]' + #13 + #10;
        end;
  end else
      begin
//        writeln(element.value);
        buffString := buffString + element.value + getPagesByName(element.pages,element.value) + #13 + #10;
      end;
end;

//procedure outputHashList(outputAdditionalString: String; listHeadPointer: hashListElementPointer; var buffString: String);
//var
//  i: Integer;
//  element,additionalElement: hashListElementPointer;
//begin
//  element := listHeadPointer;
//  i := 0;
//  while element <> nil do
//  begin
//    if (element.key <> '') and (element.value <> '') then
//    begin
////      write(outputAdditionalString);
//      buffString := buffString + outputAdditionalString;
//      if detailedOutput then
//      begin
////        write(i:3);
//        buffString := buffString + IntToStr(i);
//      end;
//      outputHashListElement(element,buffString);
//      if element.internalList <> nil then
//      begin
//        outputHashList(outputAdditionalString+'    ',element.internalList,buffString);
//      end;
//      additionalElement := element;
//      if additionalElement.additionalListElement <> nil then
//      begin
//        additionalElement := additionalElement.additionalListElement;
//        while additionalElement <> nil do
//        begin
////          write(outputAdditionalString);
//          buffString := buffString + outputAdditionalString;
////          write('  ');
//          buffString := buffString + '  ';
//          outputHashListElement(additionalElement,buffString);
//          if additionalElement.internalList <> nil then
//          begin
//            outputHashList(outputAdditionalString+'    ',additionalElement.internalList,buffString);
//          end;
//          additionalElement := additionalElement.additionalListElement;
//        end;
//      end;
//
//
//    end;
//    i := i + 1;
//    element := element.nextElement;
//  end;
//end;

function getElementPointerByKey(head: hashListElementPointer; key: String): hashListElementPointer;
var
  hash,i: Integer;
begin
  getElementPointerByKey := nil;
  hash := getHashOfString(key);
  for i := 1 to hash do
  begin
    head := head.nextElement;
  end;

  if head.key <> key then
  begin
    while head<>nil do
    begin
      head := head.additionalListElement;
      if (head<>nil) and (head.key = key) then
      begin
        getElementPointerByKey := head;
        head := nil;
      end;
    end;
  end else
      begin
        getElementPointerByKey := head;
      end;
end;

procedure fillHashInternalLists(head: hashListElementPointer; arr: fileStringsArray; k: Integer; pageListHead: pagesListElementPointer);
var
  i,p1,p2,count: Integer;
  buffVal: fileElementString;
  buffArr: fileStringsArray;
  buffDashStr,buffKey: String;
  internalPointer: hashListElementPointer;
begin
  buffDashStr := '_';
  for i := 1 to k do
  begin
    buffDashStr := buffDashStr + '_';
  end;

  for i := 0 to length(arr)-1 do
  begin
    if pos(buffDashStr,arr[i]) <> 1 then
    begin
      p1 := pos('(',arr[i]) + 1;
      p2 := pos(')',arr[i]);
      buffVal := '';
      buffVal := copy(arr[i],p1,p2-p1);
      updateValue(buffVal,buffVal,head,pageListHead);
    end;
  end;

  while Length(arr)>0 do
  begin
    count := 0;
    i := 0;
    SetLength(buffArr, 0);
    buffKey := arr[0];
    Delete(arr,0,1);
    while (Length(arr)>0) and (pos(buffDashStr,arr[i]) = 1) do
    begin
      count := count + 1;
      SetLength(buffArr, count);
      buffArr[count-1] := arr[0];
      Delete(arr,0,1);
    end;

    if count > 0 then
    begin
//      writeln(buffKey);
//      writeln(count);
      p1 := pos('(',buffKey) + 1;
      p2 := pos(')',buffKey);
      buffKey := copy(buffKey,p1,p2-p1);

      internalPointer := getElementPointerByKey(head,buffKey);
      createHashList(internalPointer.internalList);
      fillHashInternalLists(internalPointer.internalList,buffArr,k+1,pageListHead);
    end;
  end;
end;

procedure fillHashList(head: hashListElementPointer; arr: fileStringsArray; pageListHead: pagesListElementPointer);
var
  buffArr: fileStringsArray;
  count,i,p1,p2: Integer;
  buffVal, buffKey: fileElementString;
  internalPointer: hashListElementPointer;
begin
  for i := 0 to Length(arr)-1 do
  begin
    if (pos('_',arr[i]) <> 1) then
    begin
      p1 := pos('(',arr[i]) + 1;
      p2 := pos(')',arr[i]);
      buffVal := '';
      buffVal := copy(arr[i],p1,p2-p1);
      updateValue(buffVal,buffVal,head,pageListHead);
    end
  end;

  while Length(arr)>0 do
  begin
    count := 0;
    i := 0;
    SetLength(buffArr, 0);
    buffKey := arr[0];
    Delete(arr,0,1);
    while (Length(arr)>0) and (arr[0][1] = '_') do
    begin
      count := count + 1;
      SetLength(buffArr, count);
      buffArr[count-1] := arr[0];
      Delete(arr,0,1);
    end;

    if count > 0 then
    begin
//      writeln(buffKey);
//      writeln(count);
      p1 := pos('(',buffKey) + 1;
      p2 := pos(')',buffKey);
      buffKey := copy(buffKey,p1,p2-p1);

      internalPointer := getElementPointerByKey(head,buffKey);
      createHashList(internalPointer.internalList);
      fillHashInternalLists(internalPointer.internalList,buffArr,1,pageListHead);
    end;
  end;
end;

procedure getOutputList(head: hashListElementPointer; outputHead: hashListElementPointer);
var
  hashListElement,outputListElement,additionalHashListElement,additionalOutputListElement: hashListElementPointer;
begin
  hashListElement := head;
  outputListElement := outputHead;
  while hashListElement <> nil do
  begin
    if (hashListElement.key <> '') and (hashListElement.value <> '') then
    begin
      if outputListElement.key <> '' then
      begin
        createHashListElement(outputListElement.nextElement);
        outputListElement := outputListElement.nextElement;
      end;
      outputListElement.key := hashListElement.key;
      outputListElement.value := hashListElement.value;
      outputListElement.pages := hashListElement.pages;

      if hashListElement.internalList <> nil then
      begin
        createHashListElement(outputListElement.internalList);
        getoutputList(hashListElement.internalList,outputListElement.internalList);
      end;


      additionalHashListElement := hashListElement;
      additionalOutputListElement := outputListElement;
      if additionalHashListElement.additionalListElement <> nil then
      begin
        additionalHashListElement := additionalHashListElement.additionalListElement;
        while additionalHashListElement <> nil do
        begin
          createHashListElement(additionalOutputListElement.nextElement);
          additionalOutputListElement := additionalOutputListElement.nextElement;

          additionalOutputListElement.key := additionalHashListElement.key;
          additionalOutputListElement.value := additionalHashListElement.value;
          additionalOutputListElement.pages := additionalHashListElement.pages;


          if additionalHashListElement.internalList <> nil then
          begin
            getoutputList(additionalHashListElement.internalList,additionalOutputListElement.internalList);
          end;
          additionalHashListElement := additionalHashListElement.additionalListElement;
        end;
      end;

    end;

    hashListElement := hashListElement.nextElement;
  end;

end;

procedure getOutputListString(outputAdditionalString: String; head: hashListElementPointer; var buffString: String);
var
  i: Integer;
  element,additionalElement: hashListElementPointer;
  newOutputAdditionalString: String;
begin
  element := head;
  i := 0;
  while element <> nil do
  begin

    buffString := buffString + outputAdditionalString;
    if detailedOutput then
    begin
      buffString := buffString + IntToStr(i);
    end;

    outputHashListElement(element,buffString);
    if element.internalList <> nil then
    begin
      newOutputAdditionalString := outputAdditionalString;
      for i := 1 to Length(element.value)+Length(getPagesByName(element.pages,element.value)) do
      begin
        newOutputAdditionalString := newOutputAdditionalString + ' ';
      end;
      getOutputListString(newOutputAdditionalString,element.internalList,buffString);
    end;

    additionalElement := element;
    if additionalElement.additionalListElement <> nil then
    begin
      additionalElement := additionalElement.additionalListElement;

      while additionalElement <> nil do
      begin
        buffString := buffString + outputAdditionalString;
        buffString := buffString + '  ';
        outputHashListElement(additionalElement,buffString);

        if additionalElement.internalList <> nil then
        begin
          newOutputAdditionalString := outputAdditionalString;
          for i := 1 to Length(element.key)+Length(getPagesByName(element.pages,element.value)) do
          begin
            newOutputAdditionalString := newOutputAdditionalString + ' ';
          end;
          getOutputListString(newOutputAdditionalString,additionalElement.internalList,buffString);
        end;

        additionalElement := additionalElement.additionalListElement;
      end;
    end;
    i := i + 1;
    element := element.nextElement;
  end;
end;

procedure sortOutputListByABC(var head: hashListElementPointer);
var
  i: Integer;
  element,buffElement,additionalElement,buffHead: hashListElementPointer;
  sorted: Boolean;
begin
  sorted := false;

  buffHead := nil;
  createHashListElement(buffHead);
  buffHead.nextElement := head;
  element := buffHead;

  if head.nextElement <> nil then
  begin
    while not(sorted) do
    begin
      sorted := true;
      element := buffHead;
      while element.nextElement.nextElement<>nil do
      begin
        if element.nextElement.value > element.nextElement.nextElement.value then
        begin
          buffElement := element.nextElement;
          element.nextElement := buffElement.nextElement;
          buffElement.nextElement := buffElement.nextElement.nextElement;
          element.nextElement.nextElement := buffElement;
          sorted := false;
        end;

        element := element.nextElement;
      end;
    end;


  end;


  head := buffHead.nextElement;
  dispose(buffHead);

  element := head;
  while element <> nil do
  begin

    if element.internalList <> nil then
    begin
      sortOutputListByABC(element.internalList);
    end;

    additionalElement := element;
    if additionalElement.additionalListElement <> nil then
    begin
      additionalElement := additionalElement.additionalListElement;

      while additionalElement <> nil do
      begin

        if additionalElement.internalList <> nil then
        begin
          sortOutputListByABC(additionalElement.internalList);
        end;

        additionalElement := additionalElement.additionalListElement;
      end;
    end;

    element := element.nextElement;
  end;

end;


function cmpPages(el1:hashListElementPointer;el2:hashListElementPointer):Boolean;
var
  buffStr,buffNum,s1,s2:String;
  i,num1,num2:Integer;
  arr: Array[1..2] of String;
  num: Array[1..2] of Integer;
  foundNum: Boolean;
begin
  cmpPages := false;
  arr[1] := getPagesByName(el1.pages,el1.value);
  arr[2] := getPagesByName(el2.pages,el2.value);
  num[1] := 0;
  num[2] := 0;

  for i := 1 to 2 do
  begin
    buffStr := copy(arr[i],pos('(',arr[i]),pos(')',arr[i]));
    if buffStr <> '()' then
    begin
      buffNum := '';
      foundNum := false;
      while (length(buffStr) > 0) and (not(foundNum)) do
      begin
        if (buffStr[1]>='0') and (buffStr[1]<='9') then
        begin
            buffNum := buffNum + buffStr[1];
            delete(buffStr,1,1);
        end else
            begin
              if buffNum <> '' then
              begin
                foundNum := true;
              end;
              delete(buffStr,1,1);
            end;
      end;

      num[i] := StrToInt(buffNum);
    end;
  end;

  cmpPages := num[1] > num[2];
end;

procedure sortOutputListByPAGES(var head: hashListElementPointer);
var
  i: Integer;
  element,buffElement,additionalElement,buffHead: hashListElementPointer;
  sorted: Boolean;
begin
  sorted := false;

  buffHead := nil;
  createHashListElement(buffHead);
  buffHead.nextElement := head;
  element := buffHead;

  if head.nextElement <> nil then
  begin
    while not(sorted) do
    begin
      sorted := true;
      element := buffHead;
      while element.nextElement.nextElement<>nil do
      begin
        if cmpPages(element.nextElement,element.nextElement.nextElement) then
        begin
          buffElement := element.nextElement;
          element.nextElement := buffElement.nextElement;
          buffElement.nextElement := buffElement.nextElement.nextElement;
          element.nextElement.nextElement := buffElement;
          sorted := false;
        end;

        element := element.nextElement;
      end;
    end;


  end;


  head := buffHead.nextElement;
  dispose(buffHead);

  element := head;
  while element <> nil do
  begin

    if element.internalList <> nil then
    begin
      sortOutputListByPAGES(element.internalList);
    end;

    additionalElement := element;
    if additionalElement.additionalListElement <> nil then
    begin
      additionalElement := additionalElement.additionalListElement;

      while additionalElement <> nil do
      begin

        if additionalElement.internalList <> nil then
        begin
          sortOutputListByPAGES(additionalElement.internalList);
        end;

        additionalElement := additionalElement.additionalListElement;
      end;
    end;

    element := element.nextElement;
  end;

end;


procedure resetApp(Label1: TLabel; Memo1: TMemo);
var
  outputStr: String;
begin
  //RESET
  Label1.Caption := 'ROOT';
  createHashListElement(outputListHead);
  getOutputList(hashListHead,outputListHead);
  outputStr := '';
  getOutputListString('',outputListHead,outputStr);
  Memo1.Text := outputStr;
  currentHeadPointer := nil;
  currentElementPointer := nil;
end;

procedure main();
var
  arr: fileStringsArray;
  i: Integer;
  outputStr: String;
begin
  createFile(mainFileName);
  arr := getStringsFromFile(mainFileName);
  extractPages(arr,pageListHead);
  for i := 0 to Length(arr)-1 do
  begin
    write(arr[i]);
    writeln(' HASH:',getHashOfString(arr[i]));
  end;
  writeln;
  writeln;

  hashListHead := nil;
  createHashList(hashListHead);
  fillHashList(hashListHead, arr, pageListHead);

//  updateValue('YORK','MINSK2',getElementPointerByKey(getElementPointerByKey(hashListHead,'EUROPE').internalList,'UK').internalList);
//  updateValue('EUROPE','',hashListHead);
  createHashListElement(outputListHead);
  getOutputList(hashListHead,outputListHead);

  writeln;
  writeln;

  sortOutputListByABC(outputListHead);
  outputStr := '';
  getOutputListString('',outputListHead,outputStr);
  writeln(outputStr);

  writeln;
  writeln;

  sortOutputListByPAGES(outputListHead);
  outputStr := '';
  getOutputListString('',outputListHead,outputStr);


  readln;
end;


procedure getBranchListString(outputAdditionalString: String; head: hashListElementPointer; var buffString: String);
var
  i: Integer;
  element,additionalElement: hashListElementPointer;
  newOutputAdditionalString: String;
begin
  element := head;
  i := 0;
  while element <> nil do
  begin

    buffString := buffString + outputAdditionalString;
    if detailedOutput then
    begin
      buffString := buffString + IntToStr(i);
    end;

    outputHashListElement(element,buffString);
    if element.internalList <> nil then
    begin
      newOutputAdditionalString := outputAdditionalString;
      for i := 1 to Length(element.value)+Length(getPagesByName(element.pages,element.value)) do
      begin
        newOutputAdditionalString := newOutputAdditionalString + ' ';
      end;
      getOutputListString(newOutputAdditionalString,element.internalList,buffString);
    end;

    additionalElement := element;
    if additionalElement.additionalListElement <> nil then
    begin
      additionalElement := additionalElement.additionalListElement;

      while additionalElement <> nil do
      begin
        buffString := buffString + outputAdditionalString;
        buffString := buffString + '  ';
        outputHashListElement(additionalElement,buffString);

        if additionalElement.internalList <> nil then
        begin
          newOutputAdditionalString := outputAdditionalString;
          for i := 1 to Length(element.key)+Length(getPagesByName(element.pages,element.value)) do
          begin
            newOutputAdditionalString := newOutputAdditionalString + ' ';
          end;
          getOutputListString(newOutputAdditionalString,additionalElement.internalList,buffString);
        end;

        additionalElement := additionalElement.additionalListElement;
      end;
    end;
    i := i + 1;

    if getElementPointerByKey(hashListHead,head.key) = nil then
    begin
      element := element.nextElement;
    end else
        begin
          element := nil;
        end;
  end;
end;


procedure extractPagesFromStr(var str: String);
var
  i,p,p1,p2,count,q: Integer;
  element: pagesListElementPointer;
  buffStr,buffName,buffNum: String;
  buffArr: Array of Integer;
  arr: Array[1..1] of String;
begin
  arr[1] := str;
  for i := 1 to Length(arr) do
  begin
    p1 := 1;
    p2 := pos('%',arr[i]);
    buffName := '';
    buffName := copy(arr[i],p1,p2-p1);
//    writeln(buffName);

    p := pos('%',arr[i]);
    buffStr := copy(arr[i],pos('(',arr[i],p),pos(')',arr[i],pos('(',arr[i],p)));
    if buffStr <> '()' then
    begin
      element := nil;

      buffNum := '';
      count := 0;
      SetLength(buffArr,0);
      while length(buffStr) > 0 do
      begin
        if (buffStr[1]>='0') and (buffStr[1]<='9') then
        begin
          buffNum := buffNum + buffStr[1];
          delete(buffStr,1,1);
        end else
            begin
              if buffNum <> '' then
              begin
//                writeln(buffNum);
                count := count + 1;
                SetLength(buffArr,count);
                buffArr[count-1] := StrToInt(buffNum);
                buffNum := '';
              end;
              delete(buffStr,1,1);
            end;
      end;

      if count>0 then
      begin
        new(element);
        element.name := buffName;
        SetLength(element.value,Length(buffArr));
        for q := 0 to Length(element.value)-1 do
        begin
          element.value[q] := buffArr[q];
        end;
        addPageElement(pageListHead,element);
//        dispose(element);
      end;
//      writeln(' ',count);
    end;

    Delete(arr[i],p,pos(')',arr[i],p)-p+1);
  end;
  str := arr[1];
end;


procedure TForm1.FormShow(Sender: TObject);
var
  arr: fileStringsArray;
  i: Integer;
  outputStr: String;
begin
  INPUT_TF.Text := '';
  Memo1.Font.Size := -12;
  createFile(mainFileName);
  arr := getStringsFromFile(mainFileName);
  extractPages(arr,pageListHead);

  hashListHead := nil;
  createHashList(hashListHead);
  fillHashList(hashListHead, arr, pageListHead);

//  updateValue('YORK','MINSK2',getElementPointerByKey(getElementPointerByKey(hashListHead,'EUROPE').internalList,'UK').internalList);
//  updateValue('EUROPE','',hashListHead);
  createHashListElement(outputListHead);
  getOutputList(hashListHead,outputListHead);

  outputStr := '';
  getOutputListString('',outputListHead,outputStr);
  Memo1.Text := outputStr;

  currentHeadPointer := nil;
  currentElementPointer := nil;
end;


procedure findByKey(head:hashListElementPointer; key: String; var check:Boolean);
var
  element,additionalElement: hashListElementPointer;
begin
  element := head;
  while (element<>nil) and (not(check)) do
  begin

    if element.key = key then
    begin
      check := true;
    end else
          if element.internalList <> nil then
          begin
            findByKey(element.internalList,key,check);
          end;

    if (element.additionalListElement<>nil) and (not(check)) then
    begin
      additionalElement := element.additionalListElement;
      while additionalElement<>nil do
      begin
        if element.key = key then
        begin
          check := true;
        end else
              if additionalElement.internalList <> nil then
              begin
                findByKey(additionalElement.internalList,key,check);
              end;

        additionalElement := element.additionalListElement;
      end;
    end;
    element := element.nextElement;
  end;
end;



procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  headArr: Array of hashListElementPointer;
  element,additionalElement: hashListElementPointer;
  check: Boolean;
  buffStr: String;
  i: Integer;
begin
  //SEARCH
  SpeedButton1.Enabled := false;
  SpeedButton2.Enabled := false;
  SpeedButton3.Enabled := false;
  SpeedButton4.Enabled := true; // R
  SpeedButton5.Enabled := false;
  SpeedButton6.Enabled := false;
  SpeedButton7.Enabled := false;
  SpeedButton8.Enabled := false;

  element := outputListHead;
  while element<>nil do
  begin
    check:=false;

    if element.key = INPUT_TF.Text then
        begin
          check := true;
        end else
            if element.internalList<>nil then
            begin
              findByKey(element.internalList,INPUT_TF.Text,check);
            end;

    if check then
    begin
      SetLength(headArr,Length(headArr)+1);
      headArr[Length(headArr)-1] := element;
    end;
    if element.additionalListElement<>nil then
    begin
      additionalElement := element.additionalListElement;
      while additionalElement<>nil do
      begin
        check:=false;

        if additionalElement.key = INPUT_TF.Text then
        begin
          check := true;
        end else
            if additionalElement.internalList<>nil then
            begin
              findByKey(additionalElement.internalList,INPUT_TF.Text,check);
            end;


        if check then
        begin
          SetLength(headArr,Length(headArr)+1);
          headArr[Length(headArr)-1] := additionalElement;
        end;
        additionalElement := element.additionalListElement;
      end;
    end;
    element := element.nextElement;
  end;

  Memo1.Text := '';
  for i := 0 to Length(headArr)-1 do
  begin
    buffStr := '';
    getBranchListString('',headArr[i],buffStr);
    Memo1.Text := Memo1.Text + buffStr + #13 + #10 + '------------------------------------------------------------' + #13 + #10;
  end;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
var
  outputStr: String;
begin
  //DELETE
  if Label1.Caption <> 'ROOT' then
  begin
    updateValue(currentElementPointer.key,'',currentHeadPointer,currentElementPointer.pages);

    createHashListElement(outputListHead);
    getOutputList(hashListHead,outputListHead);
    outputStr := '';
    getOutputListString('',outputListHead,outputStr);
    Memo1.Text := outputStr;

//    resetApp(Label1,Memo1);
  end;
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
var
  outputStr: String;
begin
  //SORT
  if pos('ABC',SpeedButton3.Caption) > 0 then
  begin
    sortOutputListByABC(outputListHead);
    outputStr := '';
    getOutputListString('',outputListHead,outputStr);
    SpeedButton3.Caption := 'Sort by PAGES'
  end else
      begin
        sortOutputListByPAGES(outputListHead);
        outputStr := '';
        getOutputListString('',outputListHead,outputStr);
        SpeedButton3.Caption := 'Sort by ABC'
      end;

  Memo1.Text := outputStr;
end;


procedure TForm1.SpeedButton4Click(Sender: TObject);
var
  outputStr: String;
begin
  //RESET
//  Label1.Caption := 'ROOT';
//  createHashListElement(outputListHead);
//  getOutputList(hashListHead,outputListHead);
//  outputStr := '';
//  getOutputListString('',outputListHead,outputStr);
//  Memo1.Text := outputStr;
//  currentHeadPointer := nil;
//  currentElementPointer := nil;
  resetApp(Label1,Memo1);
  SpeedButton1.Enabled := true;
  SpeedButton2.Enabled := true;
  SpeedButton3.Enabled := true;
  SpeedButton4.Enabled := true; // R
  SpeedButton5.Enabled := true;
  SpeedButton6.Enabled := true;
  SpeedButton7.Enabled := true;
  SpeedButton8.Enabled := true;
//  //RESET
//  Label1.Caption := 'ROOT';
//
//  createFile(mainFileName);
//  arr := getStringsFromFile(mainFileName);
//  extractPages(arr,pageListHead);
//
//  hashListHead := nil;
//  createHashList(hashListHead);
//  fillHashList(hashListHead, arr, pageListHead);
//
//  createHashListElement(outputListHead);
//  getOutputList(hashListHead,outputListHead);
//
//  outputStr := '';
//  getOutputListString('',outputListHead,outputStr);
//  Memo1.Text := outputStr;
//
//  currentHeadPointer := nil;
//  currentElementPointer := nil;
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
var
  outputStr: String;
  buffStr: String;
begin
  //ADD
  if Label1.Caption = 'ROOT' then
  begin
    buffStr := INPUT_TF.Text;
    extractPagesFromStr(buffStr);
    INPUT_TF.Text := buffStr;

    updateValue(INPUT_TF.Text,INPUT_TF.Text,hashListHead,pageListHead);

    createHashListElement(outputListHead);
    getOutputList(hashListHead,outputListHead);
    outputStr := '';
    getOutputListString('',outputListHead,outputStr);
    Memo1.Text := outputStr;
  end else
      begin
        buffStr := INPUT_TF.Text;
        extractPagesFromStr(buffStr);
        INPUT_TF.Text := buffStr;

        updateValue(INPUT_TF.Text,INPUT_TF.Text,currentElementPointer.internalList,pageListHead);

        createHashListElement(outputListHead);
        getOutputList(hashListHead,outputListHead);
        outputStr := '';
        getOutputListString('',outputListHead,outputStr);
        Memo1.Text := outputStr;
      end;
end;

procedure TForm1.SpeedButton6Click(Sender: TObject);
var
  outputStr: String;
  buffStr: String;
  buffPointer: hashListElementPointer;
begin
  //EDIT
  if Label1.Caption <> 'ROOT' then
  begin
//    updateValue(currentElementPointer.key,INPUT_TF.Text,currentHeadPointer,pageListHead);
    updateValue(currentElementPointer.key,'',currentHeadPointer,pageListHead);
    buffPointer := currentElementPointer.internalList;
    buffStr := INPUT_TF.Text;
    extractPagesFromStr(buffStr);
    INPUT_TF.Text := buffStr;
    updateValue(INPUT_TF.Text,INPUT_TF.Text,currentHeadPointer,pageListHead);
    currentElementPointer :=  getElementPointerByKey(currentHeadPointer,INPUT_TF.Text);
    currentElementPointer.internalList := buffPointer;
    Label1.Caption := Label1.Caption + '->' + currentElementPointer.key;

    createHashListElement(outputListHead);
    getOutputList(hashListHead,outputListHead);
    outputStr := '';
    getOutputListString('',outputListHead,outputStr);
    Memo1.Text := outputStr;
  end;
end;

procedure TForm1.SpeedButton7Click(Sender: TObject);
begin
  // MOVE TO
  if Label1.Caption = 'ROOT' then
  begin
    if getElementPointerByKey(hashListHead,INPUT_TF.Text) <> nil then
    begin
      currentHeadPointer := hashListHead;
      currentElementPointer :=  getElementPointerByKey(currentHeadPointer,INPUT_TF.Text);
      Label1.Caption := Label1.Caption + '->' + currentElementPointer.key;
    end;
  end else
      begin
        if getElementPointerByKey(currentHeadPointer,INPUT_TF.Text) <> nil then
        begin
          currentElementPointer :=  getElementPointerByKey(currentHeadPointer,INPUT_TF.Text);
          Label1.Caption := Label1.Caption + '->' + currentElementPointer.key;
        end;
      end;

end;

procedure TForm1.SpeedButton8Click(Sender: TObject);
begin
  // MOVE IN
  if Label1.Caption <> 'ROOT' then
  begin
    if currentElementPointer.internalList <> nil then
    begin
      currentHeadPointer := currentElementPointer.internalList;
      currentElementPointer :=  currentHeadPointer;
      while currentElementPointer.value = '' do
      begin
        currentElementPointer := currentElementPointer.nextElement;
      end;
      Label1.Caption := Label1.Caption + '->' + currentElementPointer.key;
    end;
  end;
end;

end.
