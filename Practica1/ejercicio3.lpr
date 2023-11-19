{3. Realizar un programa que presente un menú con opciones para:
a. Crear un archivo de registros no ordenados de empleados y completarlo con
datos ingresados desde teclado. De cada empleado se registra: número de
empleado, apellido, nombre, edad y DNI. Algunos empleados se ingresan con
DNI 00. La carga finaliza cuando se ingresa el String ‘fin’ como apellido.
b. Abrir el archivo anteriormente generado y
i. Listar en pantalla los datos de empleados que tengan un nombre o apellido
determinado.
ii. Listar en pantalla los empleados de a uno por línea.
iii. Listar en pantalla empleados mayores de 70 años, próximos a jubilarse.
NOTA: El nombre del archivo a crear o utilizar debe ser proporcionado por el usuario una
única vez}
program ejercicio3;

uses unit1;

const
  mayor =70;

type
  cadena20= string[20];
  empleado =record
    nro:integer;
    ape:cadena20;
    nom:cadena20;
    edad:integer;
    dni:integer;
  end;

  archivo =file of empleado;
procedure leerEmpleado(var e:empleado);
begin
  writeln('INGRESE NRO DE EMPLEADO, APELLIDO,NOMBRE,EDAD Y DNI EN ESE ORDEN');
  readln(e.nro);readln(e.ape); readln(e.nom); readln(e.edad); readln(e.dni);
end;

procedure imprimirEmpleado(e:empleado);
begin
  writeln('Nombre: ',e.nom,' Apellido: '
  ,e.ape,' Nro de empleado: ',e.nro,' Edad: ',e.edad,' Dni: ',e.dni);

end;

procedure crear(var archivo:arch);
var
  e:empleado;
  nombre:cadena20;
begin
  writeln('Ingrese el nombre del archivo a crear: ');
  readln(nombre);
  assign (arch, nombre);
  rewrite(arch);
  leerEmpleado(e);
  while(e.ape<>'fin')do begin
    read(arch,e);
    leerEmpleado(e);
  end;
  close(arch);
end;

procedure mostrarPantallaNomDeterminado(var arch:archivo);
var
  nomb:cadena20;
  e:empleado;
begin
   writeln('Ingrese el nombre o el apellido del empleado que desea imprimir en pantalla: ');
   readln(nomb);
   while(not eof (arch))do begin
     read(arch,e);
     if (e.nom=nomb)or (e.ape=nomb)then
         imprimirEmpleado(e);
   end;
   close(arch);
end;

procedure mostrarDeAUno(var arch:archivo);
var
  e:empledo;
begin
   while(not eof(arch))do begin
      read(arch,e);
      imprmirEmpleado(e);
   end;
   close(arch);
end;

procedure mostrarMayores(var arch:archivo);
var
  e:empleado;
begin
  while(not eof(arch))do begin
    read(arch,e);
    if (e.edad > mayor)then begin
      writeln('Empleado proximo a jubilarse: ');
      imprimirEmpleado(e);
    end;
  end;
end;

procedure seleccion2(var arch:archivo);
var
  opcion:cadena20;
begin
  writeln('INGRESE POR TECLADO LA OPCION QUE DESEA REALIZAR CON EL ARCHIVO ABIERTO');
  	writeln ('');
  	writeln('a. Listar en pantalla los datos de empleados que tengan un nombre o apellido determinado.');
  	writeln('b. Listar en pantalla los empleados de a uno por linea.');
  	writeln('c. Listar en pantalla empleados mayores de 70 anos, proximos a jubilarse.');
  	writeln ('');
  	write 	('OPCION ELEGIDA -->  ');
  	readln (opcion);
  	writeln ('');
        reset(arch);
  	case opcion of
  		'a': mostrarPantallaNomDetermiando (arch);
  		'b': mostrarDeAUno (arch);
  		'c': mostrarMayores (arch);
  		else writeln ('NO SE ENCUENTRA ESA OPCION');
  	end;
  end;
procedure menu(var archivo:arch);
var
  opcion:integer;
begin
	writeln ('1) CREAR EL ARCHIVO');
	writeln ('');
	writeln ('2) ABRIR EL ARCHIVO');
	writeln ('');
	write 	('OPCION ELEGIDA -->  ');
	readln (opcion);
	writeln ('');
	case opcion of
		1:crear (arch);
                2:seleccion2 (arch);

		else writeln ('NO SE ENCUENTRA ESA OPCION');
	end;

end;

var
  palabra,nombre:cadena20;
  arch:archivo;
  sigo:boolean;

begin
  sigo:=true;
  writeln('Ingrese el nombre del archivo a crear: ');
  readln(arch);
  assign(arch);
  writeln ('A continuacion se mostrara un menú con distintas opciones para operar con el archivo: ');
  menu(arch);
  while(sigo)do begin
    writeln('Si desea terminar con el menú ingrese la palabra "close"');
    readln(palabra);
    if (palabra= 'close')then sigo:=false;
    else menu(arch);
  end;
end.

