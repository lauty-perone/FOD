{15. Se desea modelar la información de una ONG dedicada a la asistencia de personas con
carencias habitacionales. La ONG cuenta con un archivo maestro conteniendo información
como se indica a continuación: Código pcia, nombre provincia, código de localidad, nombre
de localidad, #viviendas sin luz, #viviendas sin gas, #viviendas de chapa, #viviendas sin
agua,# viviendas sin sanitarios.
Mensualmente reciben detalles de las diferentes provincias indicando avances en las obras
de ayuda en la edificación y equipamientos de viviendas en cada provincia. La información
de los detalles es la siguiente: Código pcia, código localidad, #viviendas con luz, #viviendas
construidas, #viviendas con agua, #viviendas con gas, #entrega sanitarios.
Se debe realizar el procedimiento que permita actualizar el maestro con los detalles
recibidos, se reciben 10 detalles. Todos los archivos están ordenados por código de
provincia y código de localidad.
Para la actualización se debe proceder de la siguiente manera:
1. Al valor de vivienda con luz se le resta el valor recibido en el detalle.
2. Idem para viviendas con agua, gas y entrega de sanitarios.
3. A las viviendas de chapa se le resta el valor recibido de viviendas construidas
La misma combinación de provincia y localidad aparecen a lo sumo una única vez.
Realice las declaraciones necesarias, el programa principal y los procedimientos que
requiera para la actualización solicitada e informe cantidad de localidades sin viviendas de
chapa (las localidades pueden o no haber sido actualizadas).}
program ejercicio15;
const
  valorAlto = 9999;
  n = 10;

type

  cadena20 = string[20];

  ong = record
    codProv:integer;
    nomProv : cadena20;
    codLoc:integer;
    nomLoc: cadena20;
    cantSinLuz:integer;
    cantSinGas:integer:
    chapa:integer;
    cantSinAgua:integer;
    cantSinBaños:integer;
  end;

  reg_det= record
    codProv:integer;
    codLoc:integer;
    vivConLuz:integer;
    construidas:integer;
    conAgua:integer;
    conGas:integer;
    sanitarios:integer;
  end;

  maestro= file of ong;
  detalle = file of reg_det;

  arregloDetalles = array [1..n]of detalle;
  regDetalle = array[1..n]of reg_det;

procedure leer(var det:detalle; var reg:reg_det);
begin
     if (not eof(det))then
                 read(det, reg);
     else
           reg.codProv:= valorAlto;
end;

procedure minimo(var deta:arregloDetalles; var min:reg_det; var registro:regDetalle);
var
  indiceMin,i:integer;
begin
    indiceMin :=-1;
    min.codProv := valorAlto;
    for i:=1 to n do
        if (deta[i].codProv<>valorAlto)then
                    if (deta[i].codProv< min.codProv)or ((registro[i].codProv = min.codProv)and (registro[i].codLoc< min.codLoc))then begin
                                         min:= registro[i];
                                         indiceMin:=i;
                    end;
    if (indiceMin<>-1)then
                leer(deta[indiceMin], registro[indiceMin]);
end;

procedure actualizar(var mae:maestro);
var
  deta: arregloDetalles;
  min: reg_det;
  registro: regDetalle;
  o:ong;
  i,codProv,codLoc, cantConLuz,cantConAgua, cantConGas,cantSani, cantConst:integer;
  aString: string;
begin
    reset(mae);
    for i:= 1 to n do begin
         Str(i,aString);
         assing (deta[i], 'detalle'+aString);
         reset(deta[i]);
         leer(deta[i], arreglo[i]);
    end;
    minimo(deta,min,arreglo);
    while(min.codProv<>valorAlto)do begin
         codProv:= min.codProv;
         while(codProv = min.codProv)do begin
              codLoc:= min.codLoc;
              cantConLuz:=0;cantConAgua:=0; cantConGas:=0; cantSani:=0; cantConst:=0;
              while(codProv = min.codProv )and(codLoc = min.codProv)do begin
                   cantConLuz:=cantConLuz + min.vivConLuz;
                   cantConAgua:=cantConAgua +min.conAgua;
                   cantConGas:= cantConGas + conGas;
                   cantSani:= cantSani + sanitarios;
                   cantConst:= cantConst + min.construidas;
                   minimo(deta,min,arreglo);
              end;
              read(mae, o);
              while(o.codProv<> codProv)and (o.codLoc <>codLoc)do read(mae,o);

              o.cantSinLuz := o.cantSinLuz - cantConLuz;
              o.cantSinAgua := o.cantSinAgua - cantConAgua;
              o.cantSinGas := o.cantSinGas - cantConGas;
              o.cantSinBaños := o.cantSinBaños - cantSani;
              o.chapa := o.chapa - cantConst;

              seek(mae, filePos(mae)-1);
              writeln(mae, o);
         end;
    end;
    for i:= 1 to n do
        close(deta[i]);
    close(mae);
end;



var
  mae : maestro;
  o:ong;
  cant: integer;

begin
     assign(mae, 'Archivo maestro');
     actualizar(mae);
     reset(mae);
     while(not eof(mae))do begin
           read(mae,o);
           if (o.chapa = 0)then
                       cant:= cant+1;
     end;
     writeln('CANTIDAD DE LOCALIDADES SIN VIVIENDA DE CHAPAS: ', cant);
end.

