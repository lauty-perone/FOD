{9. Se necesita contabilizar los votos de las diferentes mesas electorales registradas por
provincia y localidad. Para ello, se posee un archivo con la siguiente información: código de
provincia, código de localidad, número de mesa y cantidad de votos en dicha mesa.
Presentar en pantalla un listado como se muestra a continuación:
Código de Provincia
Código de Localidad Total de Votos
................................ ......................
................................ ......................
Total de Votos Provincia: ____
Código de Provincia
Código de Localidad Total de Votos
................................ ......................
Total de Votos Provincia: ___
…………………………………………………………..
Total General de Votos: ___
NOTA: La información se encuentra ordenada por código de provincia y código de
localidad.}
program ejercicio9;
const
  valorAlto= 9999;

type

  archMaestro = record
    codP:integer;
    codL: integer;
    num:integer;
    cantV:integer;
  end;

  maestro = file of archMaestro;

procedure leer(var arch:maestro; var d:archMaestro);
begin
   if (not eof (arch))then
      read(arch, d);
   else
      d.codP:=valorAlto;
end;

procedure informar(var mae:maestro);
var
  a:archMaestro;
  totalLoc,totalProv,total:integer;
  actLoc,actProv:integer;
begin
   reset(mae);
   leer(mae, a);
   total:=0;
   while(a.codP<>valorAlto)do begin
     actProv:= a.codP;
     totalProv:=0;
     writeln('Código de Provincia')
     writeln('',a.codP);
     writeln ('|CODIGO LOCALIDAD|TOTAL DE VOTOS');
     while(actProv= a.codP)do begin
       actLoc:= a.codL;
       totalLoc:=0;
       while(actProv= a.codP)and (actLoc= a.codL)do begin
         totalLoc := totalLoc+ a.cantV;
         leer(mae,a);
       end;
       writeln('Localidad numero',actLoc,'total de votos ', totalLoc);
       totalProv:= totalProv+ totalLoc;
     end;
     writeln('Total votos de la provincia', totalProv);
     total:= total + totalProv;
  end;
   writeln('Total de votos', total);
   close(mae);

   end;
end;

begin
  assign(mae,'maestro');
  informar(mae);
end.

