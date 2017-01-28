 Unit MyServis;
   Interface
 Uses Crt,Dos;
  Procedure Z;
  Procedure O;
  Procedure C(C:byte);
  Procedure F(F:byte);
  Procedure CF(C,F:byte);
  Procedure Beep;
  Procedure Cursor(Flag:boolean);
  Procedure Frame(X1,Y1,X2,Y2:integer);
  Procedure FrameWind(V1,V2,V3,V4,Fon:byte);
  Procedure FrameWindName(V1,V2,V3,V4,Fon:byte;St:string);
  Procedure Pol;
   Implementation
  Procedure Z;
   { Вывод черных символов на ярком фоне (для черно-белого экрана)}
    begin
      TextColor(0);
      TextBackGround(7)
    end;
  Procedure O;
   { Вывод белых символов на черном фоне (для черно-белого экрана)}
    begin
      TextColor(7);
      TextBackGround(0)
    end;
  Procedure C;
   { Установка цвета выводимых символов}
    begin
      TextColor(C)
    end;
  Procedure F;
   { Установка фона для выводимых символов}
    begin
      TextBackGround(F)
    end;
  Procedure CF;
   { Установка цвета и фона}
    begin
      TextColor(C);
      TextBackGround(F)
    end;
  Procedure Beep;
   {Звуковое сопровождение}
    begin
      Sound(8000);
      Delay(9);
      NoSound
    end;
  Procedure Cursor;
     {Видемый - не видемый курсор}
    Const
         SizeCursor :word=0;
    Var
         Reg :registers;
     begin
       with Reg do
         begin
           if Flag then CX:=SizeCursor
                   else
                     begin
                       BH:=0;
                       AH:=03;
                       Intr($10,Reg);
                       SizeCursor:=CX;
                       CH:=$20
                     end;
           AH:=01;
           Intr($10,Reg)
         end
     end;
  Procedure Frame;
   { Черчение рамок}
    Const
       { Для черчения двойной линии
      A=#186;B=#187;C=#188;
      D=#200;E=#201;F=#205;
    {
       { Для черчения одинарной линии}
      A=#179;B=#191;C=#217;
      D=#192;E=#218;F=#196;
    Var I,J:integer;
      begin
        GoToXY(X1,Y1);
        write(E);
        for I:=(X1+1) to (X2-1) do write(F);
        write(B);
        for I:=(Y1+1) to (Y2-1) do
          begin
            GoToXY(X1,I);
            write(A);
            GoToXY(X2,I);
            write(A)
          end;
        GoToXY(X1,Y2);
        write(D);
        for I:=(X1+1) to (X2-1) do write(F);
        write(C)
      end;
  Procedure FrameWind;
   { Выделение ограниченого рамкой окна с заданным фоном}
    begin
      Frame(V1,V2,V3,V4);
      Window(V1+1,V2+1,V3-1,V4-1);
      F(Fon);
      ClrScr
    end;
  Procedure FrameWindName;
   { Выделение ограниченого рамкой окна с заданным фоном и заголовком}
    begin
      Frame(V1,V2,V3,V4);
      GoToXY(V1+ROUND((((V3-V1)-LENGTH(St))/2)),V2);
      Window(V1+1,V2+1,V3-1,V4-1);
      F(Fon);
      ClrScr
    end;
  Procedure Pol;
   { Формирование полного экрана}
    begin
      Window(1,1,80,25)
    end;
 BEGIN

 END.
