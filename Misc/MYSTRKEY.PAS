program MyStrKey; {ввод символов и удаление последнего}
 uses Crt,Graph;  {символа из строки экрана в окне :  }
 var                   {Xn,Yn-начало окна,S-ширина,}
   Driver,Mode:integer;{H-высота,в графических еди-}
   ch:char;            {цах.Переменная str хранит  }
   str:string;         {введенную строку.}
   Xn,Yn,S,H:integer;{вводимой строки
   x3,y3:integer;
   flag:boolean;

 procedure Mydelch;{удаление символа из строки экрана}
  begin
   if x3>=Xn then x3:=x3-10;
   if x3<Xn then begin x3:=Xn+S-10;y3:=y3-10 end;
   SetViewPort(x3,y3,x3+10,y3+10,false);   {установка окна,допуск вывода  }
   ClearViewPort;SetViewPort(0,0,0,0,false){за пределами окна;очистка окна}
  end;

Begin
  writeln('Xn Yn L S H');readln(Xn,Yn,L,S,H);
  Driver:=HercMono;
  Mode:=HercMonoHi;
  InitGraph(Driver,Mode,'');
  str:='';x3:=Xn;y3:=Yn;
  repeat
    repeat until KeyPressed;
    ch:=ReadKey;if ch=#0 then ch:=ReadKey;
   if ch=#8
    then begin if y3>=Yn
               then begin Delete(str,length(str),1);{удаление последнего  }
                  flag:=false;                      {символа из строки str}
                  if flag then  Mydelch;
                  Mydelch
                 end
         end
    else if y3<Yn+H-1
           then begin
                 if y3<Yn then begin x3:=Xn;y3:=Yn end;
                 str:=str+ch;OutTextXY(x3,y3,ch);
                 if x3>=Xn+S-10
                   then begin x3:=Xn;y3:=y3+10 end
                   else x3:=x3+10;
                 flag:=true
                end;
  until ch=#13;CloseGraph  {по нажатию клавиши <enter> выход из программы}
End.