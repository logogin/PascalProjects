unit Figures;
 interface
 uses Graph,Crt;
 type
   Location=object
     X,Y:integer;
     procedure Init(InitX,InitY:integer);
     function GetX:integer;
     function GetY:integer;
   end;
   PointPtr=^Point;
   Point=object(Location)
     Visible:Boolean;
     constructor Init(InitX,InitY:integer);
     destructor Done;virtual;
     procedure Show;virtual;
     procedure Hide;virtual;
     function IsVisible:Boolean;
     procedure MoveTo(NewX,NewY:integer);
     procedure Drag(DragBy:integer);virtual;
   end;
   CirclePtr=^Circle;
   Circle=object(Point)
     Radius:integer;
     constructor Init(InitX,InitY:integer;
                      InitRadius:integer);
     procedure Show;virtual;
     procedure Hide;virtual;
     procedure Expand(ExpandBy:integer);virtual;
     procedure Contract(ContractBy:integer);virtual;
   end;

      implementation
   {---------------------------------}
   {реализация правил модуля Location}
   {---------------------------------}
   procedure Location.Init(InitX,InitY:integer);
    begin
      X:=InitX;
      Y:=InitY;
    end;
   function Location.GetX:integer;
     begin
      GetX:=X;
    end;
   function Location.GetY:integer;
    begin
      GetY:=Y;
    end;

   {---------------------------------}
   {реализация правил модуля Point   }
   {---------------------------------}
   constructor Point.Init(InitX,InitY:integer);
    begin
      Location.Init(InitX,InitY);
      Visible:=False;
    end;
   destructor Point.Done;
    begin
      Hide;
    end;
   procedure Point.Show;
    begin
      Visible:=True;
      PutPixel(X,Y,GetColor);
    end;
   procedure Point.Hide;
    begin
      Visible:=False;
      PutPixel(X,Y,GetBkColor);
    end;
   function Point.IsVisible:Boolean;
     begin
      IsVisible:=Visible;
    end;
   procedure Point.MoveTo(NewX,NewY:integer);
     begin
      Hide;
      X:=NewX;
      Y:=NewY;
      Show;
    end;
   function GetDelta(var DeltaX:integer;
                     var DeltaY:integer):boolean;
     var
       KeyChar : Char;
       Quit : Boolean;
     begin
       DeltaX:=0;DeltaY:=0; {нет изменений в положении}
       GetDelta:=True;      {True-мы возвращаем дельту}
      repeat
        KeyChar:=ReadKey;   {сначала прочитать нажатие клавиш}
        Quit:=True;         {предположим это используемая клавиша}
        case Ord(KeyChar) of
         0:begin               {0 значит расширенный 2-байтный код}
             KeyChar:=ReadKey; {прочитать второй байт кода}
             case Ord(KeyChar) of
               72: DeltaY:=-1;    {стрелка вверх;декремент Y}
               80: DeltaY:=1;     {стрелка вниз;инкремент Y}
               75: DeltaX:=-1;    {стрелка влево;декремент X}
               77: DeltaX:=1;     {стрелка вправо;инкремент X}
               else Quit:=False;  {игнорируется любой другой код}
             end; {case}
           end;
         13: GetDelta:=False;   {нажатие CR значит не дельта}
         else Quit:=False;      {игнорирует все другие нажатия клавиш}
       end; {case}
      until Quit;
      end;

   procedure Point.Drag(DragBy:integer);
     var
      DeltaX,DeltaY:integer;
      FigureX,FigureY:integer;
     begin
      Show;          {показ фигуры,которая будет буксироваться}
      FigureX:=GetX; {читает начальное положение фигуры}
      FigureY:=GetY;
      {это цикл буксировки : }
      while GetDelta(DeltaX,DeltaX) do
      begin                 {применяет дельту к фигуре X,Y}
        FigureX:=FigureX+(DeltaX*DragBy);
        FigureY:=FigureY+(DeltaY*DragBy);
        MoveTo(FigureX,FigureX);    {и говорит фигуре двигаться}
      end;
     end;

   {---------------------------------}
   {реализация правил модуля Circle  }
   {---------------------------------}

   constructor Circle.Init(InitX,InitY:integer;
                      InitRadius:integer);
   begin
     Point.Init(InitX,InitY);
     Radius:=InitRadius;
   end;

   procedure Circle.Show;
   begin
     Visible:=True;
     Graph.Circle(X,Y,Radius);
   end;

   procedure Circle.Hide;
   var
     TempColor:word;
   begin
     TempColor:=Graph.GetColor;
     Graph.SetColor(GetBkColor);
     Visible:=False;
     Graph.Circle(X,Y,Radius);
     Graph.SetColor(TempColor);
   end;

   procedure Circle.Expand(ExpandBy:integer);
   begin
     Hide;
     Radius:=Radius+ExpandBy;
     if Radius<0 then Radius:=0;
     Show;
   end;

   procedure Circle.Contract(ContractBy:integer);
   begin
     Expand(-ContractBy);
   end;

   {раздела инициализации нет}
   begin

   end.
