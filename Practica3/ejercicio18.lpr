{{18 . Se cuenta con un archivo con información de los casos de COVID-19 registrados en los
diferentes hospitales de la Provincia de Buenos Aires cada día. Dicho archivo contiene:
cod_localidad, nombre_localidad, cod_municipio, nombre_minucipio, cod_hospital,
nombre_hospital, fecha y cantidad de casos positivos detectados.
El archivo está ordenado por localidad, luego por municipio y luego por hospital.
a. Escriba la definición de las estructuras de datos necesarias y un procedimiento que haga
un listado con el siguiente formato:

Nombre: Localidad 1
Nombre: Municipio 1
Nombre Hospital 1……………..Cantidad de casos Hospital 1
……………………..
Nombre Hospital N…………….Cantidad de casos Hospital N
Cantidad de casos Municipio 1
…………………………………………………………………….
Nombre Municipio N
Nombre Hospital 1……………..Cantidad de casos Hospital 1
……………………..
NombreHospital N…………….Cantidad de casos Hospital N
Cantidad de casos Municipio N
Cantidad de casos Localidad 1
-----------------------------------------------------------------------------------------
Nombre Localidad N
Nombre Municipio 1
Nombre Hospital 1……………..Cantidad de casos Hospital 1
……………………..
Nombre Hospital N…………….Cantidad de casos Hospital N
Cantidad de casos Municipio 1
…………………………………………………………………….
Nombre Municipio N
Nombre Hospital 1……………..Cantidad de casos Hospital 1
……………………..
Nombre Hospital N…………….Cantidad de casos Hospital N
Cantidad de casos Municipio N
Cantidad de casos Localidad N
Cantidad de casos Totales en la Provincia

b. Exportar a un archivo de texto la siguiente información nombre_localidad,
nombre_municipio y cantidad de casos de municipio, para aquellos municipios cuya
cantidad de casos supere los 1500. El formato del archivo de texto deberá ser el
adecuado para recuperar la información con la menor cantidad de lecturas posibles.
NOTA: El archivo debe recorrerse solo una vez.}}
program ejercicio18;
const
  valorAlto = 9999;
type

  cadena20 = string[20];

  hospital = record
    cod_localidad:integer;
    nombre_localidad:cadena20;
    cod_municipio: integer;
    nombre_municipio: cadena20;
    cod_hospital:integer;
    nombre_hospital: cadena20;
    fecha: cadena20;
    cantP:integer;
  end;

  archivo = file of hospital;

procedure leer(var a:archivo; var h:hospital);
begin
  if (not eof(a))then
     read(a,h);
  else
      h.cod_localidad:= valorAlto;
end;

procedure pantalla(var a:archivo; var nArch: txt);
var
  h:hospital;
  locAct, munAct, hospAct: integer;
  total,totalMun, totalLoc,totalHosp:integer;
  locActNom, munActNom, hospActNom: cadena20;
begin
  reset(a);
  rewrite(nArch);
  leer(a,h);
  total:= 0;
  while(h.cod_localidad<>valorAlto)do begin
          write('Nombre localidad: ',h.nombre_localidad);
          locAct:= h.cod_localidad;
          totalLoc:=0;
          while(locAct = h.cod_localidad)do begin
                  write('Nombre municipio: ',h.nombre_municipio);
                  munAct:= h.cod_municipio;
                  totalMun:=0;
                  locActNom:= h.nombre_localidad;
                  while(locAct = h.cod_localidad)and (munAct = h.cod_municipio)do begin
                          write('Nombre hospital: ',h.nombre_hospital);
                          totalHosp:=0;
                          hospAct := h.cod_hospital;
                          munActNom:= h.nombre_municipio;
                          while(locAct = h.cod_localidad)and (munAct = h.cod_municipio)and (hospAct =h.cod_hospital)do begin
                                  totalHosp:= totalHosp + h.cantP;
                                  hospActNom:= h.nombre_hospital;
                                  leer(a,h);
                          end;
                          write('NOMBRE HOSPITAL: ',hospActNom,'..............................CANTIDAD DE CASOS: ',totalHosp);
                          totalMun:= totalMun + totalHosp;
                  end;
                  if (munCasos> 1500)then begin
                                writeln(nArch, totalMun, ' ', munActNom);
                                writeln(nArch, locActNom);
                  end;

                  writeln('Cantidad de casos municipio: ',munActNom,':', totalMun);
                  totalLoc:= totalLoc + totalMun;
          end;
          writeln('Canntidad de casos localidad: ', locActNom, ':', totalLoc);
          total:= total + totalLoc;
  end;
  writeln('CANTIDAD DE CASOS TOTALES EN LA PROVINCIA: ',total);
  close(a);
  close(nArch);
end;

var
  a:archivo
  nue_arch: txt

begin
  assign (a, 'Archivo hospitales');
  assign(nue_arch, 'Archivo texto');
  pantalla(a,nue_arch);
end.

