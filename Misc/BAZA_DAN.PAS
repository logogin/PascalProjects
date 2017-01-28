Program BookPhone;
  uses Dos,Crt,MyServis;
  Const KR=7; {Количество режимов}
  Type
    Dlina=string;
  Var
    M        :array[1..KR] of string; {Названия режимов}
    I,T,R    :byte;
    Pp       :array[1..KR] of byte;
    Ch       :char;
    Fl       :boolean;
    Regime   :byte;
  Procedure GorizontalMenu(K2,Kp:byte;
            SS1,SS2,SS3,SS4,SS5,SS6,SS7:Dlina);{вывод горизонтального меню}
   Const K1:byte=0; {Отступ слева}
    begin
      Cursor(False);
      Fl:=True;
      M[1]:=SS1; M[2]:=SS2; M[3]:=SS3; M[4]:=SS4;
      M[5]:=SS5; M[6]:=SS6; M[7]:=SS7;
      T:=Length(M[1]);
      R:=0;
      for I:=1 to Kp do
      R:=R+Length(M[I]);
      R:=Round((78-R)/Kp)-1;
      Frame2(1,K2-1,80,K2+1);
      GoToXY(Round(R/3+5),K2);
       for I:=1 to Kp do
         begin
           If I=1 then CF(0,7) else CF(7,0);
             Pp[I]:=WhereX;
             write(M[I]);CF(7,0);
           if I=Kp then R:=3;write('':R)
         end;
      I:=1;
       while Fl=True do
         begin
           Ch:=ReadKey;
           if Ch=#13 then Fl:=False;
           if (Ch=#0) and KeyPressed then
             begin
               Ch:=ReadKey;
                 case Ch of
                   #77:begin
                         Beep;
                         GoToXY(K1+Pp[I],K2);
                         CF(7,0); write(M[I]);
                         I:=I+1;
                           if I=(Kp+1) then
                             begin
                               I:=1;
                               GoToXY(K1+Pp[I],K2);
                             end;
                         GoToXY(K1+Pp[I],K2);
                         CF(0,7); write(M[I]);
                       end;
                   #75:begin
                         Beep;
                         GoToXY(K1+Pp[I],K2);
                         CF(7,0); write(M[I]);
                         I:=I-1;
                           if I=0 then
                             begin
                               I:=Kp;
                               GoToXY(K1+Pp[I],K2);
                             end;
                          GoToXY(K1+Pp[I],K2);
                          CF(0,7); write(M[I]);
                       end
                 end
             end
         end;
      CF(7,0);
      Cursor(True)
    end;
  Procedure VerticalMenu(K1,K2,Kp:byte;{Quit:string;}
            SS1,SS2,SS3,SS4,SS5,SS6,SS7:Dlina;
            Var
            Result:byte);
            {вывод вертикального меню}
   Label met;
    begin
      Cursor(False);
      Fl:=True;
      M[1]:=SS1; M[2]:=SS2; M[3]:=SS3; M[4]:=SS4;
      M[5]:=SS5; M[6]:=SS6; M[7]:=SS7;
      T:=Length(M[1]);
      for I:=2 to Kp do
        if Length(M[I])>T then T:=Length(M[I]);
      Frame2(K1-2,K2,K1+T+1,K2+Kp+1);
      for I:=1 to Kp do
        begin
          if I=1 then CF(0,7) else CF(7,0);
          GoToXY(K1,K2+I); write(M[I]);
        end;
      I:=1;
        while Fl=True do
          begin
            Ch:=ReadKey;
            if ((Ch=#27) or (Ch=#68)) then
              begin
                EraseMenu(3,6,13,14);
                GoTo met;
                Window(1,4,80,22);
              end;
            if Ch=#13 then Fl:=False;
            if Ch=#27 then Fl:=False;
            if (Ch=#0) and KeyPressed then
              begin
                Ch:=ReadKey;
                  case Ch of
                    #80:begin
                          Beep; GoToXY(K1,K2+I);
                          CF(7,0); write(M[I]);
                          I:=I+1;
                          if I=(Kp+1) then
                            begin
                              I:=1;
                              GoToXY(K1,K2+I);
                            end;
                          GoToXY(K1,K2+I);
                          CF(0,7); write(M[I]);
                        end;
                    #72:begin
                          Beep; GoToXY(K1,K2+I);
                          CF(7,0); write(M[I]);
                          I:=I-1;
                          if I=0 then
                            begin
                              I:=Kp;
                              GoToXY(K1,K2+I);
                            end;
                          GoToXY(K1,K2+I);
                          CF(0,7); write(M[I])
                        end
                  end
              end;
          end;
met:  CF(7,0);
      Cursor(True);
      Result:=I;
    end;
  Procedure Directory;
        
   Var dirs      :text;
       direct    :array[1..40] of  record
                            size     :longint;
                            dt       :DateTime;
                            fullname :string[12];
                 end;
       st        :string[12];
       path,name :string;
       ch        :char;
       dsk       :word;
       l         :byte absolute st;
       note      :SearchRec;
       pos       :longint;
       i,k       :byte;
    begin
     { MkDir('C:\DBDIR');}
      pol;FrameWindName(6,6,46,8,7,'Enter path line','Frame1');readln(path);
      pol;
      FrameWindName(10,5,47,20,7,'Directory','Frame1');pol;GoToXY(11,6);write(path);
      writexy('╞═ File name ═══╦ Date ═══╦ Time ════╡',10,7);
      writexy('╞════════════════════════════════════╡',10,18);
      writexy('╬',26,18);
      writexy('╩',36,18);
      for i:=8 to 17 do
        begin
          writexy('║',26,i);
          writexy('║',36,i);
        end;
      writexy('║',26,19);
      writexy('╨',26,20);
      assign(dirs,'C:\DBDIR\dirs.txt');rewrite(dirs);findfirst(path,$20,note);
      while doserror=0 do
        begin
          fillchar(st[1],12,' ');l:=12;
          with note do
            begin
              move(name[1],st[1],length(name));
              for k:=1 to length(st) do direct[1].fullname[k]:=UpCase(st[k]);
            end;
          i:=i+1;findnext(note);
        end;
      findfirst(path+'*.*',archive,note);
      while doserror=0 do
        begin
          fillchar(st[1],12,' ');l:=12;
          with note do
            begin
              move(name[1],st[1],length(name));UnPackTime(time,direct[i].dt);
              direct[i].fullname:=st;direct[i].size:=size;
            end;
          i:=i+1;
          findnext(note);
        end;
      ch:=path[i];dsk:=ord(ch)-65;k:=lo(dsk);gotoxy(36,19);write(diskfree(k),' free');
      k:=1;window(11,8,22,17);
      while k<9 do
        begin
          writeln(direct[k].fullname);k:=k+1;
         end;
      Cursor(False);
      readln;
    end;
BEGIN
  ClrScr;
  directory;
  Frame3WindName(1,1,80,20,2,' Edit ',' Watch ','H','N');
  {MakeMusik; }
  Frame3WindName(1,4,80,20,2,' Edit ',' Watch ','H','N');
  GorizontalMenu(2,7,'bnbnm','nbnb','bncbvn','xncbnx','xnvcmv','cvcbv','dhgfhd');
  VerticalMenu(4,3,7,'dnbcXXX','jhfdjff','jdsjdsd','3754yre','ccnvcnb','nvfnvbn','nbnbnbn',Regime);
  case Regime of
   1:  writeln('                    ПРОГРАММА СОЗДАНИЯ ЗАПИСЕЙ ФАЙЛА Phone.dat');
   4:  writeln('                   --------------------------------------------');
   1:  Telephone;
   5:  readln ;
  end;
  readln
END.
