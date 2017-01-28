program StrChKey;
 uses Crt,Graph;
 var
   Driver,Mode:integer;
   ch:char;
   str:string;
   Xn,Yn,L,S,H:integer;
   x3,y3:integer;

Begin
  writeln('Xn Yn L S H');readln(Xn,Yn,L,S,H);
  Driver:=HercMono;
  Mode:=HercMonoHi;
  InitGraph(Driver,Mode,'');
  str:='';x3:=Xn;y3:=Yn;l:=L;
  repeat
    repeat until KeyPressed;
    ch:=ReadKey;if ch=#0 then ch:=ReadKey;
   if ch=#8
    then begin if length(str)>0
            then begin Delete(str,length(str),1);
                  SetViewPort(x3-10,y3,x3,y3+10,false);
                  ClearViewPort;SetViewPort(0,0,0,0,false);
                  if ((x3<=Xn) and (y3>=Yn-1))
                       then begin x3:=Xn+S;y3:=y3-10 end
                       else x3:=x3-10;
                 end
         end
    else if y3<Yn+H-1
           then begin str:=str+ch;OutTextXY(x3,y3,ch);
                 if x3>=Xn+S-10
                   then begin x3:=Xn;y3:=y3+10 end
                   else x3:=x3+10;
                end;
  until ch=#13;CloseGraph
End.