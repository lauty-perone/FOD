{5. Realizar un programa para una tienda de celulares, que presente un menú con
opciones para:
a. Crear un archivo de registros no ordenados de celulares y cargarlo con datos
ingresados desde un archivo de texto denominado “celulares.txt”. Los registros
correspondientes a los celulares, deben contener: código de celular, el nombre,
descripcion, marca, precio, stock mínimo y el stock disponible.
b. Listar en pantalla los datos de aquellos celulares que tengan un stock menor al
stock mínimo.
c. Listar en pantalla los celulares del archivo cuya descripción contenga una
cadena de caracteres proporcionada por el usuario.
d. Exportar el archivo creado en el inciso a) a un archivo de texto denominado
“celulares.txt” con todos los celulares del mismo.
NOTA 1: El nombre del archivo binario de celulares debe ser proporcionado por el usuario
una única vez.
NOTA 2: El archivo de carga debe editarse de manera que cada celular se especifique en
tres líneas consecutivas: en la primera se especifica: código de celular, el precio y
marca, en la segunda el stock disponible, stock mínimo y la descripción y en la tercera
nombre en ese orden. Cada celular se carga leyendo tres líneas del archivo
“celulares.txt”

6. Agregar al menú del programa del ejercicio 5, opciones para:
a. Añadir uno o más celulares al final del archivo con sus datos ingresados por
teclado.
b. Modificar el stock de un celular dado.
c. Exportar el contenido del archivo binario a un archivo de texto denominado:
”SinStock.txt”, con aquellos celulares que tengan stock 0.
NOTA: Las búsquedas deben realizarse por nombre de celular.}
program ejercicio5y6;
type
  cadena20=string[20];
  cadena40=string[40];
  celular=record
    cod:integer;
    nombre: cadena20;
    desc:cadena40;
    marca:cadena20;
    precio:real;
    stockMin:integer;
    stockDis:integer;
  end;

  archivo = file of celular;

procedure leerCelu(var c:celular);
begin
  writeln('Ingrese el cod, el nombre, la marca ,el precio, el stock Minimo y el stock disponible del celular en ese orden');
  readln(c.cod);readln(c.nombre);readln(c.desc); readln(c.marca); readln(c.precio);
  readln(c.stockMin); readln(c.stockDis);
end;

procedure imprimir(c:celular);
begin
  writeln('Nombre: ',c.nombre,' Codigo: ',c.cod, ' Marca: ',c.marca);
  writeln(' precio: ', c.precio, ' StockMinimo: ',c.stockMin, ' Stock Disponible: ',c.stockDis);
end;

procedure crear(var arch:archivo);
var
  c:celular;
begin
  rewrite(arch);
  writeln('La carga del archivo finalizara cuando se ingrese como nombre "zzz"');
  leerCelu(c);

  while(c.nombre<>'zzz')do begin
    write(arch,c);
    leerCelu(c);
  end;
  close(arch);
end;

procedure menosStockMinimo(var arch:archivo);
var
  c:celular;
begin
  reset(arch);
  while(not eof(arch))do begin
    read(arch,e);
    if (c.stockDis<c.stockMin)then
         imprimir(c);
  end;
end;

procedure buscarCadena(var arch:archivo);
var
  cadena:cadena20;
  ok:boolean;
begin
  reset(arch);
  writeln('Ingrese una descripicon para poder imprimir los celulares con la misma descripcion');
  readln(cadena);
  while(not eof(arch))do begin
    read(arch,c);
    if (c.desc=cadena)then begin
      imprimir(c);
      ok:=true;
    end;
  end;
  if(not (ok))then writeln('Ningun celular tiene esa descripcion');
  close(arch);
end;

procedure exportar(var arch:archivo; var todos:Text);
var
  c:celular;
begin
  reset(arch);
  rewrite(todos);
  while(not eof (arch))do begin
    read(arch,c);
    with c do begin
		writeln (celu2,'|CODIGO: ',cod:10,' |PRECIO: ',precio:10:2,' |MARCA: ',marca:10,'|STOCK DISPONIBLE: ',stockD:10,' |STOCK MINIMO: ',stockM:10,
		'|DESCRIPCION:',des:10,' |NOMBRE: ',nombre:10);
  end;
  close(arch);
  close(todos);
end;


procedure aniadir(var arch:archivo);
var
  c:celular;
begin
  writeln('A continuación se podra añadir celulares');
  writeln('La carga finalizara con codigo -1');
  leerCelu(c);
  reset(arch);
  seek(arch,filesize(arch));
  while(c.cod<>-1)do begin
    write(arch,c);
    leerCelu(c);
  end;
  close(arch);
end;

procedure modificar(var arch:archivo);
var
  cod,nro:integer;
  ok:boolean;
  c:celular;
begin
  writeln('Ingrese el codigo del celular por el que desea modificar su stock');
  readln(cod);
  ok:=false;
  reset(arch);
  while(not eof(arch))and(not(ok))do begin
    read(arch,c);
    if(c.cod =cod)then begin
      ok:=true;
      writeln('Ingrese el nuevo stock para modificarlo');
      readln(nro);
      c.stockDis:=nro;
      seek(arch,filepos(arch)-1);
      write(arch,c);
    end;
  end;
  if(not (ok))then writeln('No se encontro el celular');
  close(arch);
end;

procedure exportarNoStock(var arch:archivo; var sinStock:Text);
var
  c:celular;
begin
  rewrite(sinStock);
  reset(arch);
  while(not eof(arch))do begin
    read(arch,c);
    if (c.stockDis=0)then
         with c do writeln (noStock,'|CODIGO: ',cod:10,' |PRECIO: ',precio:10:2,' |MARCA: ',marca:10,'|STOCK DISPONIBLE: ',stockD:10,' |STOCK MINIMO: ',stockM:10,
		'|DESCRIPCION:',des:10,' |NOMBRE: ',nombre:10);
  end;
  close(arch);
  close(sinStock);
end;

procedure menu(var arch, todos,sinStock:archivo);
var
  opcion:char;
begin
  writeln('INGRESE POR TECLADO LA OPCION QUE DESEA REALIZAR CON EL ARCHIVO ');
	writeln ('');
	writeln ('1) CREAR EL ARCHIVO BINARIO CON LOS DATOS DE "celulares.txt"');
	writeln ('');
	writeln ('2) MOSTRAR EN PANTALLA LOS DATOS DE LOS CELULARES CON STOCK MENOR AL STOCK MINIMO');
	writeln ('');
	writeln ('3) MOSTRAR EN PANTALLA CELULARES CUYA DESCRIPCION TENGA UNA CADENAS DE CARACTERES PROPORCIONADA POR EL USUARIO');
	writeln ('');
	writeln ('4) EXPORTAR ARCHIVO A "celulares2.txt"');
	writeln ('');
	writeln ('5) ANIADIR CELUAR');
	writeln ('');
	writeln ('6) MODIFICAR STOCK DE UN CELULAR DADO');
	writeln ('');
	writeln ('7) EXPORTAR A "SinStock.txt" AQUELLOS CELULAR SIN STOCK');
	writeln ('');
	write ('OPCION ELEGIDA -->  ');
	readln (opcion);
	writeln ('');
        case opcion of
		1:crear (arch);
		2:menosStockMinimo (arch);
		3:buscarCadena(arch);
                4:exportar (arch,todos);
		5:aniadir (arch);
                6:modificar (arch);
		7:exportarNoStock (arch,sinStock);
		else writeln ('NO SE ENCUENTRA ESA OPCION');

        end;
end;

var
  arch:archivo;
  todos,sinStock:Text;
  opcion,nombre:cadena20;
  sigo:boolean;
begin
  sigo:=true;
  writeln('Ingrese el nombre del archivo');
  readln(nombre);
  assign(arch,nombre);
  assign(todos,celulares.txt );
  assign(sinStock,SinStock.txt );
  writeln('Si desea seguir con el menu aprete cualquier letra y si desea finalizar ingrese la palabra "fin"');
  readln(opcion);
  while(opcion<>'fin')do begin
    menu(arch,todos,sinStock);

  end;

end.

