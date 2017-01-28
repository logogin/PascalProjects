 Unit MyServis;
   Interface
 Uses Crt,Dos;
  Procedure Z;
  Procedure O;
  Procedure L;
  Procedure H;
  Procedure N;
  Procedure C(C:byte);
  Procedure F(F:byte);
  Procedure CF(C,F:byte);
  Procedure Telephone;
  Procedure Beep;
  Procedure Cursor(Flag:boolean);
  Procedure Frame1(X1,Y1,X2,Y2:integer);
  Procedure Frame2(X1,Y1,X2,Y2:integer);
  Procedure Frame3(X1,Y1,X2,Y2,K:integer);
  Procedure MakeMusik;
  Procedure FrameWind(V1,V2,V3,V4,Fon:byte;Fr:string);
  Procedure FrameWindName(V1,V2,V3,V4,Fon:byte;St,Fr:string);
  Procedure Frame3WindName(V1,V2,V3,V4,K:byte;St1,St2,Fon1,Fon2:string);
  Procedure Pol;
  Procedure EraseMenu(V1,V2,V3,V4:byte);
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
  Procedure L;
   { Вывод символов с минимальной яркостью}
    begin
      LowVideo
    end;
  Procedure H;
   { Вывод символов с максимальной яркостью}
    begin
      HighVideo
    end;
  Procedure N;
   { Вывод символов с нормальной яркостью}
    begin
      NormVideo
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
  Procedure Telephone;
   { Сорпровождение аварийных ситуаций}
    Var I:integer;
      begin
        repeat
          for I:=1 to 10 do
            begin
              Sound(1200);
              Delay(100);
              NoSound
            end;
          Delay(180);
        Until KeyPressed;
      end;
  Procedure Beep;
   { Звуковое сопровождение}
    begin
      Sound(9000);
      Delay(5);
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
  Procedure Frame1;
   { Черчение рамок}
    Const
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
  Procedure Frame2;
   { Черчение рамок}
    Const
      A=#186;B=#187;C=#188;
      D=#200;E=#201;F=#205;
    Var I:integer;
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
  Procedure Frame3;
   { Черчение рамок}
   Const
     A=#213;B=#184;C=#205;
     D=#179;E=#192;F=#217;
     J=#196;
   Var I:integer;
    begin
      GoToXY(X1,Y1);write(A);
      for I:=(X1+1) to (X2-1) do
      write(C);write(B);
      for I:=(Y1+1) to (Y2+K-1) do
          begin
            GoToXY(X1,I);
            write(D);
            GoToXY(X2,I);
            write(D)
          end;
      GoToXY(X1,Y2+K);write(E);
      for I:=(X1+1) to (X2-1) do
      write(J);write(F);
      GoToXY(X1,Y2);write(#195);
      for I:=(X1+1) to (X2-1) do
      write(J);write(#180)
    end;
  Procedure MakeMusik;
   { Звуковое сопровождение}
   Var I:integer;
    begin
      H;
      Frame2(35,22,45,24);
      N;
      GoToXY(36,23);
      write('Press '); H; write('Esc'); N;
      Cursor(False);
      I:=0;
        repeat
          I:=I+1;
          Sound(Random(180)+40+I);
          Delay(170);
          NoSound;
          Delay(100)
        Until KeyPressed
    end;
  Procedure FrameWind;
   { Выделение ограниченого рамкой окна с заданным фоном}
    begin
      if Fr='Frame1' then Frame1(V1,V2,V3,V4);
      if Fr='Frame2' then Frame2(V1,V2,V3,V4);
      Window(V1+1,V2+1,V3-1,V4-1);
      F(Fon);
      ClrScr
    end;
  Procedure FrameWindName;
   { Выделение ограниченого рамкой окна с заданным фоном и заголовком}
    begin
      if Fr='Frame1' then Frame1(V1,V2,V3,V4);
      if Fr='Frame2' then Frame2(V1,V2,V3,V4);
      GoToXY(V1+ROUND((((V3-V1)-LENGTH(St))/2)),V2);
      write(St);
      Window(V1+1,V2+1,V3-1,V4-1);
      F(Fon);
      ClrScr
    end;
  Procedure Frame3WindName;
   { Черчение рамки с загооловком}
    begin
      Frame3(V1,V2,V3,V4,K);
      if Fon1='N' then
        begin
          GoToXY(V1+ROUND((((V3-V1)-LENGTH(St1))/2)),V2);
          write(St1)
        end;
      if Fon1='H' then
        begin
          GoToXY(V1+ROUND((((V3-V1)-LENGTH(St1))/2)),V2);
          H;
          write(St1);N
        end;
      if Fon2='N' then
        begin
          GoToXY(V1+ROUND((((V3-V1)-LENGTH(St2))/2)),V4);
          write(St2)
        end;
      if Fon2='H' then
        begin
          GoToXY(V1+ROUND((((V3-V1)-LENGTH(St2))/2)),V4);
          H;
          write(St2);N
        end;
    end;
  Procedure Pol;
   { Формирование полного экрана}
    begin
      Window(1,1,80,25)
    end;
  Procedure EraseMenu;
   { Очистка меню}
    begin
      Window(V1,V2,V3,V4);
      ClrScr;
      Pol
    end;
 BEGIN

 END.
