program TxtWindw;
 uses Crt;
 var
    Color,i:byte;
Begin

  TextbackGround(7);   { не влияет для Hercules }
  TextColor(0);

  for Color:=0 to 7 do begin
      i:=3*Color+3;
      Window(i,i,i+4,i+3);
      gotoXY(1,1);
      Write('  To be or not to be   ');
      NormVideo;
      end;

    Window(1,1,40,25);
    gotoXY(15,5);
    HighVideo;      { LowVideo - яркость такая же как при NormVideo- }
    Write('   To be or not to be   ');  { -для Hercules. }
   repeat until KeyPressed;

End.