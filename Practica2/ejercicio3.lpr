{3. Se cuenta con un archivo de productos de una cadena de venta de alimentos congelados.
De cada producto se almacena: código del producto, nombre, descripción, stock disponible,
stock mínimo y precio del producto.
Se recibe diariamente un archivo detalle de cada una de las 30 sucursales de la cadena. Se
debe realizar el procedimiento que recibe los 30 detalles y actualiza el stock del archivo
maestro. La información que se recibe en los detalles es: código de producto y cantidad
vendida. Además, se deberá informar en un archivo de texto: nombre de producto,
descripción, stock disponible y precio de aquellos productos que tengan stock disponible por
debajo del stock mínimo.
Nota: todos los archivos se encuentran ordenados por código de productos. En cada detalle
puede venir 0 o N registros de un determinado producto.}

program
const
  valorAlto =9999;
  suc = 30;
type
  cadena20= string[20];

  producto = record
    cod:integer;
    nom:cadena20;
    desc: cadena20;
    sDisp: integer;
    sMin: integer;
    precio:real;
  end;

  archDetalle = record
    cod:integer;
    cantVend:integer; {stock - cantVendida}
  end;

   maestro = file of producto;
   detalle = file of archDetalle;
   vec_detalle = array [1..suc]of detalle;
   reg_detalle = array [1..suc] of archDetalle;

procedure leerDetalle(var det:detalle; var regd:archDetalle);
begin
  if (not eof(det))then
       read(det,regd);
  else
      regd.cod:= valorAlto;
end;

procedure minimo(var det:vec_detalle; var registro:reg_detalle; var min:archDetalle);

var
  i,indiceMin:integer;
begin
  indiceMin:=1;
  min.cod:=valorAlto;
  for i:=1 to suc do
      if (registro[i].cod<>valorAlto)then
        if (registro[i].cod<= min.cod)then begin
           indiceMin:=i;
           min.cod:= registro[i].cod;
        end;
  if (indiceMin<>-1)then leerDetalle(det[indiceMin],registro[indiceMin]);
end;

procedure actualizar(var mae:maestro; var det:vec_detalle; var registro : reg_detalle);
var
  min: archDetalle;
  i:integer;
  aString:string;
  m:producto;
  cantVendida:integer;
  codActual:integer;
begin
  reset(mae);
  for i := 1 to suc do begin
    assign(registro[i],'det'+i);{agregar tipo}
    reset(registro[i]);
    leer(det[i],registro[i]);
    writeln(registros[i].cod);
  end;
  minimo(det,registro,min);
  while(min.cod<>valorAlto)do begin
    codActual:= min.cod;
    cantVendida:=0;
    while(min.cod = codActual)do begin
      cantVendida:= cantVendida + min.cantVend;
      minimo(det,registro,min);
    end;
    read(mae,m);
    while(m.cod <>codActual)do begin
      read(mae,m);
    end;
    seek(mae,filepos(mae)-1);
    m.sDisp:= m.sDisp - cantVendida;
    write(mae,m);
  end;
  for i:=1 to n do
      close(registro[i]);
  close(mae);


end;

var
  mae:maestro;
  det:vec_detalle;
  archTxt : Text;
  registro : reg_detalle;
begin
  assign(mae,'maestro'); {se dispone}
  assign (archTxt, 'menosStock.txt'};
  actualizar(mae,det,registro);
  crearArchivo(mae,archTxt);

end.
