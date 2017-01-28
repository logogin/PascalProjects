program TurtleGraphics;
 uses CRT,GRAPH;
 var
   Driver,Mode:integer;

 procedure aCircle(Rad:integer);
  var
     i:integer;
     Side:integer;             { Указанные в скобках процедуры не   }
  begin                        { работают из-за отсутствия вызова   }
     {PenUp;}                  { библиотеки Graph.p расширения и    }
     {Forwd(Rad);}             { отсутствия модуля реализации этого }
     {TurnRight(90);}          { расширения см.стр.1-174.Graph.bin  }
     {PenDown;}
      Side:=trunc(Pi*Rad/18);
      for i:=1 to 36 do begin
       {Forwd(Side);}
       {TurnRight(10);}
      end;
     {PenUp;}
     {TurnLeft(90);}
     {Back(Rad);}
     {PenDown}
  end;

 procedure anArc(Side,Angle:integer);
  var
     i:integer;
  begin
    {TurnRight(5);}
     for i:=1 to trunc(Angle/10) do begin
      {Forwd(Side);}
      {TurnRight(10);}
     end;
    {TurnRight(-5);}
  end;

 procedure aPetal(Side,Angle:integer);
  begin
    anArc(Side,Angle);
    {TurnRight(180-Angle);}
    anArc(Side,Angle);
    {TurnRight(180-Angle);}
  end;

 procedure aDaisy(Side,Angle,Count:integer);
  var
    i:integer;
  begin
     for i:=1 to Count do begin
      aPetal(Side,Angle);
      {TurnRight(trunc(360/Count)) }
     end;
    {Home;}
    aCircle(trunc(Side))
  end;

Begin
  Driver:=HercMono;
  Mode:=HercMonoHi;
  InitGraph(Driver,Mode,'');
    {GraphColorMode; }

  Line(0,0,319,0);
  Line(319,0,319,199);
  Line(319,199,0,199);
  Line(0,199,0,0);

  aDaisy(10,80,9);
  aDaisy(15,40,18);
  {Wrap;}
  {TurnLeft(275);}
  anArc(20,90);

  gotoXY(4,21);
  {Write('Daisy');}

  repeat until KeyPressed;

  TextMode(1)
End.
