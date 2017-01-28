program kartgr1;
 uses graph,crt;
 var gd,gm:integer;
     p:pointer;
     size:word;
     file1:file of byte;
     i:integer;
     A,B,data:word;
     p1:^byte;

 Begin
   gd:=detect;
   initgraph(gd,gm,'');
   if graphresult<>grok then halt(1);
   bar(0,0,getmaxx,getmaxy);size:=imagesize(10,20,30,40);
   getmem(p,size);{выделить память в динамически распределяемой области}
   getimage(10,20,30,40,p^);readln;
   assign(file1,'rdata.dta');rewrite(file1);
                       { data:=mem[seg(p):ofs(p)]; }
   A:=seg(p^);B:=ofs(p^);

   for i:=1 to size do
    begin
     p1:=ptr(A,B);write(file1,p1^);B:=B+1;
    end;

   cleardevice;
   putimage(100,100,p^,normalput);
   close(file1);readln;
   closegraph;
 End .
