{1. Realizar un algoritmo que cree un archivo de números enteros no ordenados y permita
incorporar datos al archivo. Los números son ingresados desde teclado. El nombre del
archivo debe ser proporcionado por el usuario desde teclado. La carga finaliza cuando
se ingrese el número 30000, que no debe incorporarse al archivo.}
program ejercicio1;
type
  archivo = file of integer;
var
  arc_logico:archivo;
  nro:integer;
  nombre:string[20];

begin
  write ('Ingrese el nombre del archivo: ');
  readln(nombre);
  assign(arc_logico,nombre);
  rewrite(arc_logico);
  write ('INgrese un numero para poder agregarlo al archivo: ');
  readln(nro);
  while(nro <>3000)do begin
    write(arc_logico, nro);
    write ('INgrese un numero para poder agregarlo al archivo: ');
    readln(nro);
  end;
  close(arc_logico);
end.

