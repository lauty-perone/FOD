{2. Realizar un algoritmo, que utilizando el archivo de números enteros no ordenados
creados en el ejercicio 1, informe por pantalla cantidad de números menores a 1500 y
el promedio de los números ingresados. El nombre del archivo a procesar debe ser
proporcionado por el usuario una única vez. Además, el algoritmo deberá listar el
contenido del archivo en pantalla.}
program ejercicio2;
type
  archivo = file of integer;
  cadena20 = string[20];
procedure mostrarEnPantalla(var arch:archivo; var cantMenor:integer,var prom: real );
var
  num,cant,total:integer;
begin
  cant:=0;
  total:=0;
  reset(arch);
  while(not eof(arch))do begin
    cant:=cant+1;
    read(arch,num);
    total:=total+num;
    if(num<1500)then
        cantMenor:=cantMenor+1;
    writeln(num);
  end;
  close(arch);
end;


var
  arch:archivo;
  prom:real;
  cantMenor:integer
  nombre:cadena20;

begin
  cantMenor:=0;
  prom:=0;
  write('Ingrese el nombre del archivo');
  readln(nombre);
  assign (arch, nombre);
  mostrarEnPantalla(arch,prom,cantMenor);
  writeln('El promedio de los números ingresados en el archivo es: ', prom);
  writeln('La cantidad de números menores a 1500 es: ', cantMenor);
  readln();


end.

