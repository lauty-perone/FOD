{10. Se tiene información en un archivo de las horas extras realizadas por los empleados de
una empresa en un mes. Para cada empleado se tiene la siguiente información:
departamento, división, número de empleado, categoría y cantidad de horas extras
realizadas por el empleado. Se sabe que el archivo se encuentra ordenado por
departamento, luego por división, y por último, por número de empleados. Presentar en
pantalla un listado con el siguiente formato:
Departamento
División
Número de Empleado Total de Hs. Importe a cobrar
...... .......... .........
...... .......... .........
Total de horas división: ____
Monto total por división: ____
División
.................
Total horas departamento: ____
Monto total departamento: ____
Para obtener el valor de la hora se debe cargar un arreglo desde un archivo de texto al
iniciar el programa con el valor de la hora extra para cada categoría. La categoría varía
de 1 a 15. En el archivo de texto debe haber una línea para cada categoría con el número
de categoría y el valor de la hora, pero el arreglo debe ser de valores de horas, con la
posición del valor coincidente con el número de categoría.}
program ejercicio10;
const
  valorAlto: 9999;
  n = 15;
type

  categ = 1..n;
  empleado = record
    dep:integer;
    divi:integer;
    cat:categ;
    num:integer;
    cantH:integer;
  end;

  maestro = file of empleado;

  cat = record
    nro:categ;
    monto : real;
  end;

  vector = array [categ]of real;

procedure cargarVector(var arch: Text; var v:vector);
var
  i:integer;
  c:cat;
begin
  reset(arch);
  for i:=1 to n do begin
    readln(arch,c);
    v[c.nro]:= c.monto;
  end;
  close(arch);
end;

procedure leer(var mae:maestro; var e:empleado);
begin
  if (not eof (mae))then
      read(mae, e);
  else
      e.dep:=valorAlto;
end;

procedure informar(var mae:maestro;var v:vector);
var
  e:empleado;
  totalDep,totalDiv,totalNro:real;
  totalHsDep,totalHsDiv,totalHsEmp,depActual,divActual,nroActual:integer;
 begin
   reset(mae);
   leer(mae,e);
   while(e.dep<>valorAlto)do begin
      totalDep:=0;
      depActual:= e.dep;
      totalHsDep:=0;
      writeln('DEPARTAMENTO');
      writeln(' ',e.dep);
      while(depActual = e.dep)do begin
         writeln('DIVISON');
         writeln(' ',e.divi);
         totalDiv:=0;
         divActual:= e.divi;
         totalHsDiv:= 0;
         writeln('NUMERO DE EMPLEADO', 'TOTAL DE HORAS', 'IMPORTE A COBRAR');
         while(e.dep= depActual)and (e.divi= divActual)do begin
            nroActual:=e.num;
            totalNro:=0;
            totalHsEmp:=0;
            while(e.dep= depActual)and (e.divi= divActual)and (e.num= nroActual)do begin
               totalNro:= v[e.cat]+ e.cantH;
               totalHsEmp:= totalHsEmp + e.cantH;
               leer(mae,e);
            end;
            writeln(e.nro, totalHsEmp, totalNro);
            totalDiv:= totalDiv + totalNro;
            totalHsDiv:= totalHsDiv + totalHsEmp;
         end;
         writeln('TOTAL DE HORAS DE LA DIVISION:', totalHsDiv);
         writeln('TOTAL A COBRAR LA DIVISION',totalDiv);
         totalDep:= totalDep + totalDiv;
         totalHsDep:= totalHsDep + totalHsDiv;
      end;
      writeln('TOTAL DE HORAS DEL DEPARTAMENTO: ', totalHsDep);
      writeln('MONTO TOTAL POR EL DEPARTAMENTO: ',totalDep);
   end;
   close(mae);
 end;

var
  mae:maestro;
  v:vector;
  archTxt : Text;
begin
  assign(mae,'maestro');
  assign (archTxt,'monto.txt');
  cargarVector(archTxt,v);
  informar(mae,v);
end.

