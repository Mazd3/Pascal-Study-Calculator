Uses GraphABC; 

Var Mx, My ,x0, y0, x, y, u, v, t: integer;
    dx, xi, eta: real;

Begin
  x0:=35; y0:=500; Mx:=100; My:=100; t:=0;
 
  SetPenColor(clRed);
  dx:=0.02; xi:=0; eta:=tan(xi);
  x:=x0+trunc(Mx*xi); y:=y0-trunc(My*eta);
  u:=x; v:=y;
  repeat
    xi:=xi+dx; eta:=tan(xi);
    x:=x0+trunc(Mx*xi); y:=y0-trunc(My*eta);
    Line(u, v, x, y); u:=x; v:=y;
  until xi>5;
  
  SetPenColor(clBlack);
  Line(35, y0, 1500, y0);   Line(x0, 5, x0, 1000);
  Line(1495, y0+3, 1500, y0); Line(x0+3, 10, x0, 5);
  Line(1495, y0-3, 1500, y0); Line(x0-3, 10, x0, 5);
  repeat
  Line(x0+t, y0-5, x0+t, y0+5);
  t:=t+314;
  until t>1500;
  
  TextOut(x0+12, 5, 'y');   TextOut(590, y0-20, 'x');
end.