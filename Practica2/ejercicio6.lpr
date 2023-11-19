{6- Se desea modelar la información necesaria para un sistema de recuentos de casos de
covid para el ministerio de salud de la provincia de buenos aires.
Diariamente se reciben archivos provenientes de los distintos municipios, la información
contenida en los mismos es la siguiente: código de localidad, código cepa, cantidad casos
activos, cantidad de casos nuevos, cantidad de casos recuperados, cantidad de casos
fallecidos.
El ministerio cuenta con un archivo maestro con la siguiente información: código localidad,
nombre localidad, código cepa, nombre cepa, cantidad casos activos, cantidad casos
nuevos, cantidad recuperados y cantidad de fallecidos.
Se debe realizar el procedimiento que permita actualizar el maestro con los detalles
recibidos, se reciben 10 detalles. Todos los archivos están ordenados por código de
localidad y código de cepa.
Para la actualización se debe proceder de la siguiente manera:
1. Al número de fallecidos se le suman el valor de fallecidos recibido del detalle.
2. Idem anterior para los recuperados.
3. Los casos activos se actualizan con el valor recibido en el detalle.
4. Idem anterior para los casos nuevos hallados.
Realice las declaraciones necesarias, el programa principal y los procedimientos que
requiera para la actualización solicitada e informe cantidad de localidades con más de 50
casos activos (las localidades pueden o no haber sido actualizadas).}

program ejercicio6;
const
  valorAlto= 9999;
  n = 10;

type

  regDet = record
    cod:integer;
    codCepa:integer;
    cantActivos:integer;
    cantNuevos:integer;
    cantRecu:integer;
    cantFallecidos:integer;
  end;


  regMae = record
    cod:integer;
    nom: string[20];
    codCepa:integer;
    nomCepa: string[10];
    totalFalle: integer;
    totalRecu: integer;
    totalActivos: integer;
    totalNuevos: integer;
  end;

  maestro = file of regMae;
  detalle = file of regDet;

  vecDetalle = array [1..n]of detalle;
  regDetalle = array [1..n]of regDet;

procedure leer(var arch: detalle; var dato: regDet);
begin
  if(not eof(arch))then
       read(arch,dato);
  else
      dato.cod:=valorAlto;
end;

procedure leerMae(var arch:maestro; var dato: regMae);
begin
  if (not eof (arch))then
       read(arch,dato);
  else
      dato.cod:=valorAlto;
end;

procedure minimo(var vDet:vecDetalle; var rDet:regDaetalle; var min:regDet);
var
  i,indiceMin:integer;
begin
  indiceMin:=-1;
  min.cod:=valorAlto;
  for i:=1 to n do begin
    if (rDet[i].cod<>valorAlto)then
         if (rDet[i].cod<= min.cod)then begin
              min.cod:=rDet[i];
              indiceMin:=i;
         end;
         {if (registro[i].cod < min.cod) then begin
					min:= registro[i];
					indiceMin:= i;
			end
			else
			if (registro[i].cod = min.cod)and (registro[i].cepa < min.cepa)then begin
				min:= registro[i];
				indiceMin:= i;
			end;}

  end;
  if (indiceMin<>-1)then
       leer(vDet[indiceMin], rDet[indiceMin]);
end;

procedure crearMaestro(var mae:maestro; var vDet:vecDetalle; var rDet:regDetalle);
var
  min:regDet;
  m:regMae;
  i,codActual,cepaActual,totalFallecidos,totalRecuperados,activos,nuevos:integer;
begin
  for i:=1 to n do begin
    assing (vDet[i],'detalle'+i);
    reset(vDet[i]);
    leer(vDet[i],rDet[i]);
  end;
  rewrite(mae);
  minimo(vDet,rDet,min);
  while(min.cod<>valorAlto)do begin
    codActual:= min.cod;
    while(codActual = min.cod)do begin
      cepaActual:=min.codCepa;
      totalFallecidos:= 0;
      totalRecuperados:= 0;
      while(codActual = min.cod)and (cepaActual= min.codCepa)do begin
        totalFallecidos:= totalFallecidos+min.cantFallecidos;
        totalRecuperados:= totalRecuperados+ min.cantRecu;
        activos:=min.cantActivos;
        nuevos:=min.cantNuevos;
        minimo(vDet,rDet,min);
      end;
      read(mae,m);
      while(m.cod<>codActual)do
          read(mae,m);
      while(m.codCepa<>codCepa)dp
          read(mae,m);
      m.totalNuevos:=nuevos;
      m.totalActivos:=sctivos;
      m.totalFalle:=totalFallecidos;
      m.totalRecu:=totalRecuperados;

      seek(mae, filepos(mae)-1);
      write(mae,m);
    end;
  end;
  for i:=1 to n do
     close(vDet[i]);
  close(mae);
end;

procedure recorrerMaestro(var mae:maestro);
var
  m:regMae;
  total,codActual:integer
begin
  reset(mae)
  leerMae(mae,m);
  while(m.cod<>valorAlto)do begin
    codActual:=m.cod;
    total:=0;
    while(codActual= m.cod)do begin
      total:=total+m.totalActivos;
      leerMae(mae,m);
    end;
    if (total>50)then
         write('La localidad de',m.nombre,'tiene mas', total, 'casos activos');
  end;
  close(mae);
end;

var
  mae: maestro;
  vDet: vecDetalle;
  rDet: regDetalle;

begin
  assign(mae, 'maestro');
  crearMaestro(mae,vDet,rDet);
  recorrerMaestro(mae);
end.

