{2. Se dispone de un archivo con información de los alumnos de la Facultad de Informática. Por
cada alumno se dispone de su código de alumno, apellido, nombre, cantidad de materias
(cursadas) aprobadas sin final y cantidad de materias con final aprobado. Además, se tiene
un archivo detalle con el código de alumno e información correspondiente a una materia
(esta información indica si aprobó la cursada o aprobó el final).
Todos los archivos están ordenados por código de alumno y en el archivo detalle puede
haber 0, 1 ó más registros por cada alumno del archivo maestro. Se pide realizar un
programa con opciones para:
a. Actualizar el archivo maestro de la siguiente manera:
i.Si aprobó el final se incrementa en uno la cantidad de materias con final aprobado.
ii.Si aprobó la cursada se incrementa en uno la cantidad de materias aprobadas sin
final.
b. Listar en un archivo de texto los alumnos que tengan más de cuatro materias
con cursada aprobada pero no aprobaron el final. Deben listarse todos los campos.
NOTA: Para la actualización del inciso a) los archivos deben ser recorridos sólo una vez.}

program ejercicio2;
const
  valorAlto= 9999;

type
  cadena20= string[20];

  alumnoMaestro= record
    cod:integer;
    ape:cadena20;
    nom: cadena20;
    cantSinFinal: integer;
    cantAprob:integer;
  end;

  alumnoDetalle = record
    cod:integer;
    aprobCursada: integer;
    aprobFinal:integer;
  end;

  maestro = file of alumnoMaestro;
  detalle = file of alumnoDetalle;

procedure crearMaestro(var mae:maestro);
begin

end;

procedure leerDet (var d:deta);
begin
	with d do begin
		write ('INGRESE COD: '); readln (cod);
		if (cod <> -1) then begin
			write ('INGRESE SI APROBO CURSADA: '); readln (curs);
			write ('INGRESE SI APROBO FINAL: '); readln (fin);
		end;
		writeln ('');
	end;
end;

procedure crearDetalle(var det: detalle);
var
  a:alumnoDetalle;
begin
  rewrite(det);
  leerDet(a);
  while (a.cod<>0)do begin
          read(det,a);
          leerDet(a);
  end;
  close(det);


end;

procedure leerDetalle(var det:detalle; var regd:alumnoDetalle);
begin
  if(not eof(det))then
       read(det,regd);
  else
     regd.cod:=valorAlto;
end;

procedure compactar(var det:detalle; var mae:maestro);
var
  regm:alumnoMaestro;
  regd:alumnoDetalle;
  codActual:integer;
begin
  reset(det);
  reset(mae);
  read(mae,regm);
  leerDetalle(det,regd);
  while(regd.cod<>valorAlto)do begin
          codActual:=regd.cod;
          while(codActual= regm.cod)do begin
                  if (regd.aprobFinal =1)then
                       regm.cantAprob:=regm.cantAprob+ 1;
                  if (regd.aprobCursada = 1)then
                       regm.cantSinFinal:=regm.cantSinFinal+1;
                  leerDetalle(det,regd);
          end;
          seek (mae, filepos(mae)-1);
          write(mae,regm);
          if (not EOF (mae))then
               read(mae, regm);

  end;
  close(mae);
  close(det);
end;

procedure crearNuevoArchivo(var mea:maestro; var nueArch:Text);
var
  a:alumnoMaestro;
begin
  reset(mae);
  rewrite(nueArch);
  while(not eof (mae))do begin
          read(mae,a);
          if (a.cantSinFinal - a.cantAprob > 4)then
               with a do begin
                       write(arcTxt,cod,'  ',ape,'  ',nom,'  ',cantSinFinal,'  ',cantAprob);
               end;
  end;
  close(mae);
  close(nueArch);
end;

var
  mae:maestro;
  det:detalle;
  nueArch: Text;
begin
  assign(mae,'maestro');
  assign(det,'detalle');
  assign(nueArch,'Archivo.txt');
  crearDetalle(det);
  crearMaestro(mae); {se dispone}
  compactar(det,mae);
  crearNuevoArchivo(mae, nueArch);

end.


