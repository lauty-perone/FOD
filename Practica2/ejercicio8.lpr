{8. Se cuenta con un archivo que posee información de las ventas que realiza una empresa a
los diferentes clientes. Se necesita obtener un reporte con las ventas organizadas por
cliente. Para ello, se deberá informar por pantalla: los datos personales del cliente, el total
mensual (mes por mes cuánto compró) y finalmente el monto total comprado en el año por el
cliente.
Además, al finalizar el reporte, se debe informar el monto total de ventas obtenido por la
empresa.
El formato del archivo maestro está dado por: cliente (cod cliente, nombre y apellido), año,
mes, día y monto de la venta.
El orden del archivo está dado por: cod cliente, año y mes.
Nota: tenga en cuenta que puede haber meses en los que los clientes no realizaron
compras.}
program ejercicio8;
const
  valorAlto = 9999;

type

  cadena20 = string[20];
  cliente= record
    cod:integer;
    nom:cadena20;
    ape: cadena20;
    mes: 1..12;
    anio: integer;
    dia:1..31;
    montoV: real;
  end;

  maestro = file of cliente;

procedure leer(var m:maestro; var dato:cliente);
begin
  if (not eof(m))then
       read(m,dato);
  else
     dato.cod:=valorAlto;
end;

procedure imprimirCliente (c:cliente);
begin
	with c do begin
		writeln ('|CODIGO: ',cod);
		writeln ('|NOMBRE Y APELLIDO: ',nom,ape);
	end;
end;

procedure reporte(var mae:maestro);
var
  c:cliente;
  totalMes,totalAnio,total:real;
  codActual,anioActual,mesActual:integer;
begin
  reset(mae);
  leer(mae, c);
  total:=0;
  while(c.cod<>valorAlto);
     codActual:=c.cod;
     imprimirCliente(c);
     while(codActual= c.cod)do begin
             anioActual:= c.anio;
             totalAnio:=0;
             while(codActual= c.cod)and (anioActual= c.anio)do begin
                        mesActual:= c.mes;
                        totalMes:=0;
                        while(codActual= c.cod)and(anioActual = c.anio)and (mesActual= c.mes)do begin
                                   total:= total +c.montoV;
                                   leer(mae,c);
                        end;
                        totalAnio:=totalAnio + totalMes;
             end;
             total:= total+ totalAnio;
     end;
  close(mae);
  writeln('Total de la empresa: ', total);
end;

var
  mae:maestro;
begin
  assign(mae,'maestro');
  reporte(mae);
end.

