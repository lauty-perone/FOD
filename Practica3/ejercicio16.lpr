{16. La editorial X, autora de diversos semanarios, posee un archivo maestro con la
información correspondiente a las diferentes emisiones de los mismos. De cada emisión se
registra: fecha, código de semanario, nombre del semanario, descripción, precio, total de
ejemplares y total de ejemplares vendido.
Mensualmente se reciben 100 archivos detalles con las ventas de los semanarios en todo el
país. La información que poseen los detalles es la siguiente: fecha, código de semanario y
cantidad de ejemplares vendidos. Realice las declaraciones necesarias, la llamada al
procedimiento y el procedimiento que recibe el archivo maestro y los 100 detalles y realice la
actualización del archivo maestro en función de las ventas registradas. Además deberá
informar fecha y semanario que tuvo más ventas y la misma información del semanario con
menos ventas.
Nota: Todos los archivos están ordenados por fecha y código de semanario. No se realizan
ventas de semanarios si no hay ejemplares para hacerlo}
program ejercicio16;
const
  n = 100;
  valorAlto = 'ZZZZ';

type
  cadena20 = string[20];
  cadena10 = string[10];

  emision = record
    fecha = cadena10;
    cod:integer;
    nom: cadena20;
    desc:cadena20;
    precio: real;
    totalE: integer;
    totalEVen:integer;
  end;

  reg_det = record
    fecha: cadena10;
    cod: integer;
    cantE:integer;
  end;

  maestro = file of emision;
  detalle = file of reg_det;

  archDetalle = array [1..n]of detalle;
  regDet = array [1..n]of reg_det;

procedure leer(var d:detalle; var reg: reg_det);
begin
  if (not eof(d))then
                  read(d,reg);
  else
                  reg.fecha:= valorAlto;
end;

procedure minimo(var d:archDetalle; var min:reg_det; var registro:regDet);
var
  i,indiceMin:integer;
  min.fecha:= valorAlto;
  for i:= 1 to n do
      if (registro[i].fecha<>valorAlto)then
         if(registro[i]<min.fecha)or (registro[i].fecha = min.fecha)and(registro[i].cod<min.cod)then begin
                   min:= registro[i];
                   indiceMin:= i;
  if (indiceMin<>-1)then begin
     leer(deta[indiceMin], registro[indiceMin]);
end;


procedure actualizar(var mae:maestro);
var
  e:emision;
  aDet: archDrtalle; registro :regDet;
  d:detalle;
  i,cantVentas,codActual:integer;
  aString,fechaActual:= cadena10;
  min: reg_det;
begin
  reset(mae);
  for i:= 1 to n do begin
    Str(i,aString);
    assign(aDet[i], aString);
    reset(aDet[i]);
    leer(aDet[i],registro[i]);
  end;
  minimo(aDet,min,registro);
  while(min.fecha<>valorAlto)do begin
    fechaActual:= min.fecha;
    while(fechaActual = min.fecha)do begin
      cantVentas:= 0;
      codActual:= min.cod;
      while(fechaActual = min.fecha)and (codActual = min.cod)do begin
        cantVentas := cantVentas + min.cantE;
        minimo(aDet,min,registro);
      end;
      read(mae,e);
      if (e.fecha<>fechaActual)and (e.cod <> codAct)then
                      read(mae, e);
      e.totalE := e.totalE -cantVentas;
      e.totalEVen:= e.totalEVen -cantVentas;
      seek(mae, filePos(mae)-1)
      write(mae,e);
    end;
  end;
  for i:= 1 to n do
      close(deta[i]);
  close(mae);
end;

begin
  indiceMin:= -1;
var
  mae:maestro;
  m, max, min : emision;
begin
  min.totalEVen := 9999999;
  max.totalEVen :=-1;
  assign(mae, 'Maestro');
  actualizar(mae);
  reset(mae);
  while (not eof(mae))do begin
    read(mae,m);
    if (m.totalEVen < min.totalEVen)then
                    min:=m;
    if (m.totalEVen) > max.totalEVen)then
                    max:=m;
  end;
  close(mae);
  writeln('MINIMO: ',min.fecha,' ',min.cod);
  writeln('MAXIMO', max,fecha,' ',max.cod);
end.

