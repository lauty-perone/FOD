{7- El encargado de ventas de un negocio de productos de limpieza desea administrar el
stock de los productos que vende. Para ello, genera un archivo maestro donde figuran todos
los productos que comercializa. De cada producto se maneja la siguiente información:
código de producto, nombre comercial, precio de venta, stock actual y stock mínimo.
Diariamente se genera un archivo detalle donde se registran todas las ventas de productos
realizadas. De cada venta se registran: código de producto y cantidad de unidades vendidas.
Se pide realizar un programa con opciones para:
a. Actualizar el archivo maestro con el archivo detalle, sabiendo que:
● Ambos archivos están ordenados por código de producto.
● Cada registro del maestro puede ser actualizado por 0, 1 ó más registros del
archivo detalle.
● El archivo detalle sólo contiene registros que están en el archivo maestro.
b. Listar en un archivo de texto llamado “stock_minimo.txt” aquellos productos cuyo
stock actual esté por debajo del stock mínimo permitido.}
program ejercicio7;
const
  valorAlto= 9999;
  n =2;

type

  cadena20 = string [20];
  producto= record
    cod:integer;
    com: cadena20;
    precio: real;
    stockAn: integer;
    stockMin: integer;
  end;

  venta = record
    cod:integer;
    cantV: integer;
  end;

  maestro = file of producto;
  detalle = file of venta;

  vecDet = array[1..n]of detalle;
  vecReg = array [1..n]of venta;

procedure leer(var arch:detalle; var dato: venta);
begin
   if (not eof (arch))then
       read(arch,dato);
   else
       dato.cod:=valorAlto;
   end;

procedure minimo(var vDet: vecDet; var vReg: vecReg; var min: venta);
var
  i,indiceMin:integer;
begin
   indiceMin :=-1;
   min.cod:= valorAlto;

   for i :=1 to n do
      if  (vReg[i]<>valorAlto)then
          if (vReg[i].cod<= min.cod)then begin
               min:= vReg[i];
               indiceMin:= i;
          end;
   if (indiceMin<>-1)then
       leer(vDet[i], vReg[i]);
end;

procedure actualizarMaestro(var mae:maestro; var vReg: vecReg; var vDet: vecDet);
var
  p:producto;
  min:venta;
  i,codActual,cantV:integer;
begin
   reset(mae); rewrite(mae);
   for i:=1 to n do begin
     assign (vDet[i],'detalle'+i);
     reset(vDet[i]);
     leer(vDet[i],vReg[i]);
   end;
   minimo(vDet,vReg,min);
   while (min.cod<>valorAlto)do begin
     cantV:=0;
     codActual:= min.cod;
     while (codActual= min.cod)do begin
       cantV:= cantV+ min.cantV;
       minimo(vDet,vReg,min);
     end;
     read(mae, p);
     while (p.cod<>codActual)do
         read(mae, p);
     seek (mae, filepos(mae)-1);
     p.stockAn:=p.stockAn- cantV;
     write(mae, p);
     for i:=1 to n do
        close(vDet[i]);
     close(mae);
  end;
end;

procedure listarStock(var mae:maestro; var arch:Text);
var
  p:producto;

begin
   reset(mae);
   rewrite(arch);
   while (not eof(mae))do begin
     read(mae,p);
     if (p.stockAn<p.stockMin)then
         writeln (arch,p.cod,'  ',p.com,'  ',p.precio:1:1,'  ',p.stockAn,'  ',p.stockMin);         )
   end;
   close(mae);close(arch);

end;

var
  mae:maestro;
  vDet:vecDet;
  vReg: vecReg;
  arch: Text;
begin
  assign(mae,'maestro');
  actualizarMaestro (mae, vReg,vDet);
  assign(arch, 'stock_minimo.txt');
  listarStock(mae, arch);

end.

