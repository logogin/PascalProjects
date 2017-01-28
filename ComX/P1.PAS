uses crt;
var f1,f2:text;
    i1:integer;
     l:byte;
    st:string;
 procedure frame;
 begin
  writeln(f1);
  writeln(f1,'      ┌──────────────────┬────────────┬───────────────────┬──────────┐');
  writeln(f1,'      │       1          │     2      │         3         │    4     │');
  writeln(f1,'      │       1          │     2      │         3         │    4     │');
  writeln(f1,'      ├──────────────────┼────────────┼───────────────────┼──────────┤');
  writeln(f1,'      │       1          │     2      │         3         │    4     │');
  writeln(f1,'      ├──────────────────┼────────────┼───────────────────┼──────────┤');

 end;
 procedure telo;
 var i:integer;
 begin
 i:=0;
 repeat
 i:=i+1;
 delay(50);
 write(f1,'      │');write(f1,i-4:17,' │');write(f1,i:11,' │');write(f1,i++20:18,' │');
 writeln(f1,i*10:9,' │');
 until keypressed;
 end;
 procedure list;
  begin
    writeln(f2,'-':37,i1,'-');
    writeln(f2,'      ┌──────────────────┬────────────┬───────────────────┬──────────┐');
    writeln(f2,'      │       1          │     2      │         3         │     4    │');
    writeln(f2,'      ├──────────────────┼────────────┼───────────────────┼──────────┤');
  end;
 procedure ending;
  begin
    writeln(f1,'      └──────────────────┴────────────┴───────────────────┴──────────┘');
  end;
 procedure ending1;
  begin
    writeln(f2,'      └──────────────────┴────────────┴───────────────────┴──────────┘');
  end;
 begin
 assign(f1,'proba.txt');
 rewrite(f1);
 frame;
 telo;
   ending;
 close(f1);
 assign(f1,'proba.txt');
 reset(f1);
 assign(f2,'proba.bak');
 rewrite(f2);
 i1:=1;
 while not eof(f1) do
 begin
 readln(f1,st);
 writeln(f2,st);
 l:=l+1;
 if l=20 then begin ending1;i1:=i1+1; list; l:=0  end;
  end;
 erase(f1);
 close(f1);
 reset(f2);
 rename(f2,'proba.txt');
 close(f2);
 end.
