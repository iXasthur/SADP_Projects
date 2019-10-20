program L3;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

const
  hashListSize = 500;
  mainFileName = 'Angelina.txt';
  stdStrSize = 100;
  detailedOutput = false;

type
  fileElementString = String[stdStrSize];
  fileStringsArray = Array of fileElementString;

  pagesListElementPointer = ^pagesListElement;
  pagesListElement = Record
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
  insert(generateRandomString(15),initialStr,pos('%',initialStr)+1);
  generateKeyV := initialStr;
end;


procedure createFile(name: String);
var
  F: File of fileElementString;
  str: fileElementString;
begin
  Assign(F,name);
  rewrite(f);
  str := generateKeyV('(EUROPE)%%(1)'); 
  write(f,str);
  str := generateKeyV('_(FRANCE)%%(1)'); 
  write(f,str);
  str := generateKeyV('__(PARIS)%%(1)'); 
  write(f,str);
  str := generateKeyV('__(LYON)%%(1)'); 
  write(f,str);
  str := generateKeyV('__(CAEN)%%(1)'); 
  write(f,str);
  str := generateKeyV('_(GERMANY)%%(1)'); 
  write(f,str);
  str := generateKeyV('__(BERLIN)%%(1)'); 
  write(f,str);
  str := generateKeyV('__(FRANKFURT)%%(1)'); 
  write(f,str);
  str := generateKeyV('__(MUNICH)%%(1)'); 
  write(f,str);
  str := generateKeyV('_(UK)%%(1)'); 
  write(f,str);
  str := generateKeyV('__(LONDON)%%(1)'); 
  write(f,str);
  str := generateKeyV('__(YORK)%%(1)'); 
  write(f,str);
  str := generateKeyV('__(NORWICH)%%(1)'); 
  write(f,str);
  str := generateKeyV('__(BATH)%%(1)'); 
  write(f,str);
  str := generateKeyV('(NORTH AMERICA)%%(1)'); 
  write(f,str);
  str := generateKeyV('_(USA)%%(1)'); 
  write(f,str);
  str := generateKeyV('__(NEW-YORK)%%(1)'); 
  write(f,str);
  str := generateKeyV('__(SAN-FRANCISCO)%%(1)'); 
  write(f,str);
  str := generateKeyV('__(LOS-ANGELES)%%(1)'); 
  write(f,str);
  str := generateKeyV('__(CHICAGO)%%(1)'); 
  write(f,str);
  str := generateKeyV('__(MINSK)%%(1)'); 
  write(f,str);
  str := generateKeyV('__(PITTSBURG)%%(1)'); 
  write(f,str);
  str := generateKeyV('_(CANADA)%%(1)'); 
  write(f,str);
  str := generateKeyV('__(TORONTO)%%(1)'); 
  write(f,str);
  str := generateKeyV('__(OTTAWA)%%(1)'); 
  write(f,str);
  str := generateKeyV('__(MONTREAL)%%(1)'); 
  write(f,str);
  str := generateKeyV('_(MEXICO)%%(1)'); 
  write(f,str);
  str := generateKeyV('__(MEXICO CITY)%%(1)'); 
  write(f,str);
  str := generateKeyV('__(CANCUN)%%(1)'); 
  write(f,str);
  close(f);
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

procedure updateValue(forKey: String; strValue: String ;var listHeadPointer: hashListElementPointer);
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

  if element.key <> '' then
  begin
    while element.additionalListElement <> nil do
    begin
      element := element.additionalListElement
    end;

    createHashListElement(element.additionalListElement);
    element := element.additionalListElement
  end;

  element.key := forKey;
  element.value := strValue;
end;

procedure outputHashListElement(element: hashListElementPointer);
begin
  if detailedOutput then
  begin
    write(': [KEY: ''',element.key);
    write(''' VALUE: ''',element.value);
    if element.pages <> nil then
    begin
      write(''' PAGES: TRUE');
    end else
        begin
          write(''' PAGES: FALSE');
        end;

    if element.internalList <> nil then
    begin
      writeln(' INTERNAL LIST: TRUE]');
    end else
        begin
          writeln(' INTERNAL LIST: FALSE]');
        end;
  end else
      begin
        writeln(element.value);
      end;
end;

procedure outputHashList(outputAdditionalString: String; listHeadPointer: hashListElementPointer);
var
  i: Integer;
  element,additionalElement: hashListElementPointer;
begin
  element := listHeadPointer;
  i := 0;
  while element <> nil do
  begin
    if element.key <> '' then
    begin
      write(outputAdditionalString);
      if detailedOutput then
      begin
        write(i:2);
      end;
      outputHashListElement(element);
      if element.internalList <> nil then
      begin
        outputHashList(outputAdditionalString+'    ',element.internalList);
      end;
      additionalElement := element;
      if additionalElement.additionalListElement <> nil then
      begin
        additionalElement := additionalElement.additionalListElement;
        while additionalElement <> nil do
        begin
          write(outputAdditionalString);
          write('  ');
          outputHashListElement(additionalElement);
          if additionalElement.internalList <> nil then
          begin
            outputHashList(outputAdditionalString+'    ',additionalElement.internalList);
          end;
          additionalElement := additionalElement.additionalListElement;
        end;
      end;
      
      
    end;
    i := i + 1;
    element := element.nextElement;
  end;
end;

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
      if head.key = key then
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

procedure fillHashInternalLists(head: hashListElementPointer; arr: fileStringsArray; k: Integer);
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
      updateValue(arr[i],buffVal,head);
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
      internalPointer := getElementPointerByKey(head,buffKey);
      createHashList(internalPointer.internalList);
      fillHashInternalLists(internalPointer.internalList,buffArr,k+1);
    end;
  end;
end;

procedure fillHashList(head: hashListElementPointer; arr: fileStringsArray);
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
      updateValue(arr[i],buffVal,head);
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
      internalPointer := getElementPointerByKey(head,buffKey);
      createHashList(internalPointer.internalList);
      fillHashInternalLists(internalPointer.internalList,buffArr,1);
    end;
  end;
end;

var
  hashListHead: hashListElementPointer;
  arr: fileStringsArray;
  i: Integer;
begin
  createFile(mainFileName);
  arr := getStringsFromFile(mainFileName);
  for i := 0 to Length(arr)-1 do
  begin
    write(arr[i]);
    writeln(' HASH:',getHashOfString(arr[i]));
  end;
  writeln;
  writeln;

  hashListHead := nil;
  createHashList(hashListHead);
  fillHashList(hashListHead, arr);
  outputHashList('',hashListHead);
  readln;
end.
