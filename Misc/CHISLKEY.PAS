program chislkey;
 uses crt,graph;
 label 1,2;
 var
   driver,mode,x:integer;
   ch:char;
Begin
   write('нажмите <enter>;вводите цифры;для завершения нажмите <enter>');
   readln;

   driver:=hercmono;
   mode:=hercmonohi;
   initgraph(driver,mode,'');
   line(50,50,300,150);

   x:=60;
2: repeat
   1: if keypressed       { если нажата клавиша , }
   then ch:=readkey { тогда величине ch присвоить символ клавиши,}
            else goto 1;     { иначе перейти на метку 1 }
     outtextxy(x,100,ch);
     x:=x+10;
   until ord(ch)=13;

   restorecrtmode;
   writeln('введите x-координату для ввода строки с клавиатуры');
   readln(x);writeln('текстовый режим;нажмите <enter>  ',x);readln;
     setgraphmode(mode);
     outtextxy(x,150,'графический режим;нажмите <enter>');

     closegraph   {перед окончанием программы необходимо выйти из}
                  {графического режима}

End.
