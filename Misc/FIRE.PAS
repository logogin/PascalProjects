{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S-,T-,V+,X+,Y+}
{$M 16384,0,655360}

 uses Graph,Crt;


 Procedure FirePalette;
  var red,green,blue:byte;
      i:integer;
  begin
   red:=0;
   blue:=0;
   green:=0;
   for i:=1 to 31 do
   begin
     inc(red,2);
     setrgbpalette(i,red,green,blue);
   end;
   red:=62;

   for i:=32 to 94 do
    begin
      inc(green);
      setrgbpalette(i,red,green,blue);
    end;
  end;
  Procedure Init(Mode:Integer);
    Var   Driver,ErrCode:integer;
    begin
      Driver:=InstallUserDriver('svga256',nil);
      InitGraph(Driver, Mode,'');
      ErrCode := GraphResult;

      if ErrCode <> grOk then
           begin
              Writeln('Error during Init: ',ErrCode);
              Halt(1);
           end;
      ClearDevice;
    end;
   Procedure  ViewPal;
    var i,j,color:integer;
        x,y:string[4];
    begin
     str(getmaxx+1,x);
     str(getmaxy+1,y);
     for i:=1 to 15 do
          begin
            for j:=1 to 15 do
              begin
               setfillstyle(1,color);
               bar((i-1)*20,(j-1)*20,i*20 ,j*20);
               inc(color);
              end;
         end;
      outtext(x);
      outtext('  x  ');
      outtext(y);
      readkey;
    end;

  Procedure Fire(x1,y1,x2,y2:word);
    var  i,j,color: Integer;
         wood:array[0..320,0..200] of byte;
   begin
     for i:=1 to x2-x1 do wood[i,0]:=random(94)+20;

     for j:=0 to y2-y1 do
           for i:=1 to x2-x1  do
                wood[i,j+1]:=(wood[i-1,j]+wood[i+1,j]) div 2;

     for j:=y2 downto y1 do
         begin
           for i:=x1 to x2  do
              begin
                color:=wood[i-x1,j-y1];
                putpixel(i,j,color);
              end;
          end;
     
   end;
BEGIN
  Init(4);
  FirePalette;
  repeat
    fire(100,200,150,400);
  until keypressed;
  CloseGraph;
END.

 Procedure Fire;
    var  i,j,color,k: Integer;
   begin
     for k:=100 to 150  do putpixel(k,400,random(94)+20);
     for j:=400 downto 200 do
         begin
           for i:=100 to 150  do
              begin
                color:=(getpixel(i-1,j)+getpixel(i+1,j)) div 2;
                putpixel(i,j-1,color);
              end;
          end;
   end;