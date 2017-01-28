{$M $800,0,0}
Uses Crt,Dos;
Var con:array[1..80,1..25,1..2] of byte absolute $B000:$0000;
    f:text;
    x,y:byte;
K_V:Procedure;
{$F+}
Procedure Work;
 Interrupt;
 begin
 if Port[$60]=132 then
  begin
{  assign (f, 'c:screen.pas'); }
{  rewrite(f);                   }
   for y:=1 to 80 do
     for x:=1 to 25 do
       begin
         Write({f,}con[y,x,1]);
         writeln{(f)};
       end;
 { close(f);  }
  sound(500);delay(2000);nosound;

  end;
  inline($9C);
  K_V;
  end;
 {$F-}
  BEGIN
   GetIntVec($9,@K_V);
   SetIntVec($9,Addr(Work));
  END.
