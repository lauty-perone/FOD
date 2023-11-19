{1. Una empresa posee un archivo con información de los ingresos percibidos por diferentes
empleados en concepto de comisión, de cada uno de ellos se conoce: código de empleado,
nombre y monto de la comisión. La información del archivo se encuentra ordenada por
código de empleado y cada empleado puede aparecer más de una vez en el archivo de
comisiones.
Realice un procedimiento que reciba el archivo anteriormente descripto y lo compacte. En
consecuencia, deberá generar un nuevo archivo en el cual, cada empleado aparezca una
única vez con el valor total de sus comisiones.
NOTA: No se conoce a priori la cantidad de empleados. Además, el archivo debe ser
recorrido una única vez.}
program ejercicio1;
const
  valorAlto =9999;
type
  cadena20 =string[20]

  empleado =record
    cod:integer;
    nombre:cadena20;
    monto:real;
  end;

  compacto = record
    codigo: integer;
    monto:real;
  end;

  detalle = file of compacto;
  maestro = file of empleado;

procedure leerDetalle(detalle:det; var dato:compacto);
begin
  if (not(EOF(archivo))) then
     read (archivo, dato)
 else
     dato.codigo := valorAlto;
end;

procedure compactar(mae:maestro; var det:detalle);
var
  e:empleado;
  c:compacto;
  actual:integer;
begin
  reset(mae);
  reset(det);
  leerDetalle(det,e);
  while(e.cod <> valorAlto)do begin
    actual := e.cod;
    c.monto:=0;
    while(e.cod= actual)do begin
      c.monto:= c.monto + e.monto;
      leerDetalle(det,e);
    end;
    c.codigo:=actual;
    write(mae,c);
  end;
  close(det);
  close(mae);
end;

var
  mae: maestro;
  det: detalle;


begin
  Assign (mae, 'arch_empleados'); {se recibe ordenada por codigo de empleado}
  Assign (det, 'arch_compacto');
  compactar(mae,det);
  imprimir(det);


end.

