{4. Agregar al menú del programa del ejercicio 3, opciones para:
a. Añadir una o más empleados al final del archivo con sus datos ingresados por
teclado.
b. Modificar edad a una o más empleados.
c. Exportar el contenido del archivo a un archivo de texto llamado
“todos_empleados.txt”.
d. Exportar a un archivo de texto llamado: “faltaDNIEmpleado.txt”, los empleados
que no tengan cargado el DNI (DNI en 00).
NOTA: Las búsquedas deben realizarse por número de empleado.}
program ejercicio4;
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
   reset(arch);
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
   reset(arch);
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
  reset(arch);
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

procedure seleccion3(var arch:archivo);
var
  e:empleado;
begin
  reset(arch);
  seek(arch,filesize(arch));
  write('Si desea finalizar ingrese la palabra "fin" como apellido o nombre');
  leerEmpleado(e);
  while(e.ape<>'fin' or e.nom<>'fin')do begin
    write(arch,e);
    leerEmpleado(e);
  end;
  close(arch);

end;

procedure modificar(var arch:archivo; nro:integer);
var
  e:empleado;
  edad:integer;
  ok:boolean;
begin
   ok:=false;
   while(not eof (arch)and (not (ok))do begin
        read(arch,e);
        if (e.nro=nro)then begin
             ok:=true;
             writeln('Ingrese la edad para cambiarle al empleado nro: ',nro);
             readln(edad);
             e.edad:=edad;
             seek(arch,filepos(arch)-1);
             write(arch,e);
        end;
   end;
   if (not (ok))then
          writeln('No se encontro el empleado con nro:' ,nro);
   else
          writeln('Se modifico con exito');
   close (arch);
end;

procedure seleccion4(var arch:archivo);
var
  nro:integer;
begin
    write ('INGRESE Nro DEL EMPLEADO DEL QUE DESEA MODIFICAL LA EDAD. INGRESE -1 PARA FINALIZAR: ');
			readln (nro);
			while (nro <> -1) do begin
				reset (arch);
				modificar (arch,nro);
				write ('INGRESE Nro DEL EMPLEADO DEL QUE DESEA MODIFICAL LA EDAD. INGRESE -1 PARA FINALIZAR: ');
				readln (nro);
			end;

end;

procedure seleccion5(var arch,todos:archivo);
var
  e:empleado;
begin
   reset(arch);
   rewrite(todos);
   while(not eof(arch))do begin
     read(arch,e);
     write(todos,e);
   end;
   close(arch);
   close(todos);
end;

procedure seleccion6(var arch,sin_dni);
var
  e:empleado;
begin
   reset(arch);
   rewrite(sin_dni);
   while(not eof(arch))do begin
     read(arch,e);
     if(e.dni =00)then
         write(sin_dni,e);
   end;
   close(arch);
   close(sin_dni);
end;

procedure menu(var arch,todos,sin_dni:archivo);
var
  opcion:integer;
begin
	writeln ('1) CREAR EL ARCHIVO');
	writeln ('');
	writeln ('2) ABRIR EL ARCHIVO');
	writeln ('');
        writeln ('3) AGREGAR EMPLEADOS AL ARCHIVO');
	writeln ('');
        writeln('4) MODIFICAR EDAD');
        writeln('');
	writeln ('5) EXPORTAR CONTENIDO DEL ARCHIVO A UNO NUEVO');
	writeln ('');
        writeln ('6) EXPORTAR A UN ARCHIVO LOS EMPLEADOS QUE NO TENGAN DNI ASIGNADO');
	writeln ('');
	write 	('OPCION ELEGIDA -->  ');
	readln (opcion);
	writeln ('');
	case opcion of
		1:crear(arch);
                2:seleccion2(arch);
                3:seleccion3(arch);
                4:seleccion4(arch);
                5:seleccion5(arch,todos);
                6:seleccion6(arch,sin_dni);
		else writeln ('NO SE ENCUENTRA ESA OPCION');
	end;
end;

var
  palabra,nombre:cadena20;
  arch,sin_dni,todos:archivo;
  sigo:boolean;

begin
  sigo:=true;
  writeln('Ingrese el nombre del archivo a crear: ');
  readln(nombre);
  assign(arch,nombre);
  assign(todos,'todos_empleados.txt');
  assing(sin_dni,'faltaDNIEmpleado.txt')
  writeln ('A continuacion se mostrara un menú con distintas opciones para operar con el archivo: ');
  menu(arch,todos,sin_dni);
  while(sigo)do begin
    writeln('Si desea terminar con el menú ingrese la palabra "close"');
    readln(palabra);
    if (palabra= 'close')then sigo:=false;
    else menu(arch,todos,sin_dni);
  end;
end.


