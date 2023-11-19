{Una red de librerias posee varios puntos de  ventas y debe procesar un archivo con las ventas realizadas en sus locales.
El archivo recibido tiene el siguiente formato: razon social libreria, genero literario,nombre del libro, precio y cantidad vendida.
El archivo se encuentra ordenado por libreria, luego por genero, y por ultimo por nombre del libro.
Escriba un programa(Programa principal, estructuras y modulos)que dado el archivo descripto, realice un informe con el siguiente formato}
program parcialito;
const
  valorAlto = 'ZZZ';
type
  cadena20: string[20];

  libreria =  record
    razon: cadena20;
    genero: cadena20;
    libro: cadena20;
    precio: real;
    cantV: integer;
  end;

  archivo = file of libreria;

procedure leer(var a :archivo; var dato: libreria);
begin
     if (not(EOF a))then
        read(a,dato);
     else
         dato.razon:= valorAlto;
end;

procedure procesarArchivo(var a:archivo);
var
  MontoTotal, MontoLib, MontoGen: real;
  totalLibros:integer;
  l:libreria;
  libreriaAct, genAct, libroAct : cadena20;
begin
     reset(a);
     leer(a, l);
     MontoTotal:= 0;
     while(l.razon<>valorAlto)do begin
       write('Libreria: ',l.razon);
       libreriaAct := l.razon;
       MontoLib:=0;
       while(libreriaAct = l.razon)do begin
         write('Genero: ',l.genero);
         genAct:= l.genero;
         MontoGen:= 0;
         while(libreriaAct = l.razon)and (genAct = l.genero)do begin
              write('Nombre de libro: ', l.libro);
              libroAct:= l.libro;
              MontoLib:P l.precio;
              totalLibros:= 0;
              while(libreriaAct = l.razon)and(genAct = l.genero)and (libroAct = l.libro)do begin
                   totalLibros:= totalLibros + l.cantV;
                   leer(a,l);
              end;
              write('Total vendido Libro ',libroAct,':',totalLibros);
              MontoLib := MontoLib* totalLibros;
              MontoGen:= MontoGen+ MontoLib;
         end;
         write('Monto vendido género ',genAct,':', MontoGen);
         MontoLib:= MontoLib +MontoGen;
       end;
       write('Monto vendido libreria ',libreriaAct,':',MontoLib);
       MontoTotal:= MontoTotal + MontoLib;
     end;
     write('Monto total librerias: ', MontoTotal);
     close(a);
end;

var
  a: archivo;
begin
  assign (a, 'Archivo_Ventas');
  cargarArchivo(a);{se dispone}
  procesarArchivo(a);
end.

