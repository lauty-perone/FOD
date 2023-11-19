{7. Realizar un programa que permita:
a. Crear un archivo binario a partir de la información almacenada en un archivo de texto.
El nombre del archivo de texto es: “novelas.txt”
b. Abrir el archivo binario y permitir la actualización del mismo. Se debe poder agregar
una novela y modificar una existente. Las búsquedas se realizan por código de novela.
NOTA: La información en el archivo de texto consiste en: código de novela,
nombre,género y precio de diferentes novelas argentinas. De cada novela se almacena la
información en dos líneas en el archivo de texto. La primera línea contendrá la siguiente
información: código novela, precio, y género, y la segunda línea almacenará el nombre
de la novela.
IMPORTANTE: Se recomienda implementar los ejercicios prácticos en Dev-Pascal. El ejecutable
puede descargarse desde la plataforma Ideas}
program ejercicio7;
type
  cadena20=string[20];
  novela=record
    cod:integer;
    nombre:cadena20;
    genero:cadena20;
    precio:real;
  end;

  archivo =file of novela;

procedure leerNovela(var n:novela);
begin
  writeln('Ingrese codigo, nombre , genero y precio de la novela en ese orden');
  readln(n.cod); readln(n.nombre); readln(n.genero);
  readln(n.precio);
end;

procedure imprimirNovela(n:novela);
begin
  writeln('Nombre: ',n.nombre, ' Genero: ', n.genero, ' Codigo: ',n.codigo, 'Precio: ', n.precio:0:2);
end;

procedure crear(var arch_log:archivo; var arch_txt:Text);
var
  n:novela;
begin
  rewrite(arch_log);
  reset(arch_txt);
  while(not eof(arch_txt))do begin
      readln(arch_txt, n.cod,n.genero,n.precio);
      readln(arch_txt,n.nombre);
      write(arch_log,n);
  end;
  close(arch_log);
  close(arch_txt);
end;

procedure mostrarPantalla(var arch_log:archivo);
var
  n:novela;
begin
  reset(arch_log);
  while(not eof(arch_log))do begin
      read(arch_log,n);
      imprimrNovela(n);
  end;
  close(arhc_log);
end;

procedure modificarNovela(var n:novela);
  var
	opcion:integer;

begin
	writeln ('SELECCIONE QUE DESEA MODIFICAR');
	writeln ('');
	writeln ('1) PRECIO');
	writeln ('');
	writeln ('2) GENERO');
	writeln ('');
	writeln ('3) NOMBRE');
	writeln ('');
	write ('OPCION ELEGIDA --> ');
	readln (opcion);
	writeln ('');
	case opcion of
	1:
		begin
			write ('INGRESE NUEVO PRECIO: '); readln (n.precio);
		end;
	2:
		begin
			write ('INGRESE NUEVO GENERO: '); readln (n.genero);
		end;
	3:
		begin
			write ('INGRESE NUEVO NOMBRE: '); readln (n.nombre);
		end
	else
		writeln ('NO ES UNA OPCION VALIDA');
	end;
	writeln ('');
end;

procedure modificar(var arch_log:archivo);
var
  cod:integer;
  ok:boolean;
  n:novela;
begin
     reset(arch_log);
     ok:=false;
     writeln('Ingrese el codigo de la novela que desea modificar')
     readln(codigo);
     while(not eof(arch_log))do begin
         read(arch_log,n);
         if(n.cod=cod)then begin
                  ok:=true;
                  modificarNovela(n);
                  seek(arch_log, filepos(arch_log)-1);
                  write(arch_log,n);
         end;
     end;
     if(ok)then writeln('Se modifico correctamente');
     else
        writeln('No se encontro la novela con codigo: ', cod);
     close(arch_log);
end;

procedure menu(var arch_log:archivo; var arch_txt:Text);
var
  opcion:char;
begin
  writeln('INGRESE POR TECLADO LA OPCION QUE DESEAR REALIZAR CON EL ARCHIVO');
  writeln('1: CREAR ARCHIVO BINARIO');
  writeln('2: MOSTRAR EN PANTALLA');
  writeln('3: AÑADIR NOVELA');
  writeln('4: MODIFICAR NOVELA');
  writeln('5: SALIR');
  writeln('OPCION ELEGIA: ');
  readln(opcion);
  case opcion of
         1: crear(arch_log, arch_txt);
         2: mostrarPantalla(arch_log);
         3: agregar(arch_log);
         4: modificar(arch_log);
         5: halt;
  else
    writeln('Opcion incorrecta');
  end;
end;

var
  arch_log:archivo;
  arch_txt:Text;
  nombre,palabra:cadena20;
  sigo:boolean;


begin
  writeln('Ingrese el nombre del archivo');
  readln(nombre);
  assign(arch_log,nombre);
  assign (arch_txt,'novelas.txt');
  menu(arch_log, arch_txt);
  sigo:=true;
  while(sigo)do begin
    writeln('Presione cualquier tecla o inserte fin para finalizar');
    readln(palabra);
    if (palabra='fin')then
            sigo:=false;
    else menu(arch_log,arch_txt);
  end;
end.

