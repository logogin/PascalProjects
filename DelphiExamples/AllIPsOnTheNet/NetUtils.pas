unit NetUtils;
interface
uses Windows, Classes;
function GetContainerList(ListRoot:PNetResource):TList; Type
  {$H+}
   PNetRes = ^TNetRes;
   TNetRes = Record
             dwScope       : Integer;
             dwType        : Integer;
             dwDisplayType : Integer;
             dwUsage       : Integer;
             LocalName     : String;
             RemoteName    : String;
             Comment       : String;
             Provider      : String;
           End;
  {H-}

implementation
uses SysUtils;
 type
 PnetResourceArr = ^TNetResource; {TNetResource - это запись,
                      эквивалентная TNetRes, за исключением того, что
                      вместо типов string там типы PChar. }

function GetContainerList(ListRoot:PNetResource):TList;
Var TempRec          : PNetRes;
    Buf              : Pointer;
    Count,BufSize,Res: DWORD;
    lphEnum          : THandle;
    p                : PNetResourceArr;
    i                : SmallInt;
    NetworkList      : TList;
Begin
  NetworkList := TList.Create;
  Result:=nil;
  BufSize := 8192;
  GetMem(Buf, BufSize);
  Try
    Res := WNetOpenEnum(RESOURCE_GLOBALNET, RESOURCETYPE_DISK, RESOURCEUSAGE_CONTAINER{0}, ListRoot,lphEnum);
    If Res <> 0 Then Raise Exception(Res);
    Count := $FFFFFFFF; {всі ресурси}
    Res := WNetEnumResource(lphEnum, Count, Buf, BufSize); {в буфере Buf - списочек
                         в виде массива указателей на структуры типа TNetResourceArr
                         а в Count - число этих структур}
    If Res = ERROR_NO_MORE_ITEMS Then Exit;
    If (Res <> 0) Then Raise Exception(Res);
    P := PNetResourceArr(Buf);
    For I := 0 To Count - 1 Do
    Begin                   //Требуется копирование из буфера, так как он
      New(TempRec);         //действителен только до следующего  вызова функций группы WNet
      TempRec^.dwScope := P^.dwScope;
      TempRec^.dwType := P^.dwType ;
      TempRec^.dwDisplayType := P^.dwDisplayType ;
      TempRec^.dwUsage := P^.dwUsage ;
      TempRec^.LocalName := StrPas(P^.lpLocalName);  {имеются  ввиду вот эти указатели}
      TempRec^.RemoteName := StrPas(P^.lpRemoteName); {в смысле  - строки PChar}
      TempRec^.Comment := StrPas(P^.lpComment);
      TempRec^.Provider := StrPas(P^.lpProvider);
      NetworkList.Add(TempRec);
      Inc(P);
    End;
    Res := WNetCloseEnum(lphEnum);
    {а следующий вызов - вот он!}
    If Res <> 0 Then Raise Exception(Res);
    Result:=NetWorkList;
    Finally
      FreeMem(Buf);
  End;
End;
end.

 