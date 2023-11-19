{4. Suponga que trabaja en una oficina donde está montada una LAN (red local). La misma
fue construida sobre una topología de red que conecta 5 máquinas entre sí y todas las
máquinas se conectan con un servidor central. Semanalmente cada máquina genera un
archivo de logs informando las sesiones abiertas por cada usuario en cada terminal y por
cuánto tiempo estuvo abierta. Cada archivo detalle contiene los siguientes campos:
cod_usuario, fecha, tiempo_sesion. Debe realizar un procedimiento que reciba los archivos
detalle y genere un archivo maestro con los siguientes datos: cod_usuario, fecha,
tiempo_total_de_sesiones_abiertas.
Notas:
- Cada archivo detalle está ordenado por cod_usuario y fecha.
- Un usuario puede iniciar más de una sesión el mismo día en la misma o en diferentes
máquinas.
- El archivo maestro debe crearse en la siguiente ubicación física: /var/log.}

program ejercicio4;
const
  valorAlto =9999;
  maquinas = 5;
type
  ´cadena10 = string[10];

  regMaestro = record
    cod_usuario:integer;
    fecha:cadena10;
    tiempoTotal:real:
  end;

  regDetalle = record
    cod:integer;
    fecha: cadena10;
    tiempo:real;
  end;

  maestro = file of regMaestro;

  vectorDetalles = array [1..maquinas]of file of regDetalle;
  vectorRegDetalle= array [1..maquinas]of regDetalle;

procedure leer(var arch:detalle; var dato:regDetalle);
begin
  if (not eof (arch))then
      read(arch,dato);
  else
      dato.cod:=valorAlto;
end;

procedure leerDatos(var d:regDetalle);
begin
  write('Escriba cod del usuario');
  read(d.cod);
  if (d.cod<>valorAlto)then begin
      write('Escriba la fecha y el tiempo de la sesion del usuario');
      with d do begin
        read(fecha); read(tiempo);
      end;
  end;
end;

procedure minimo(var rDet:vectorRegDetalle; var min:regDetalle;var v:vectorDetalle);
var
  indiceMin,i:integer;
begin
  indiceMin :=-1;
  min.cod := valorAlto;
  for i:=1 to maquinas do
     if (rDet[i].cod<>9999)then
         if (rDet[i].cod<= min.cod)then begin
             indiceMin:=i;
             cod.min:= rDet[i].cod;
         end;
  if (indiceMin<>-1)then
      leer(rDet[indiceMin], v[indiceMin]);
end;

procedure actualizarMaestro(var mae:maestro; var v:vectorDetalles; var rDet:vectorRegDetalle);
var
  i:integer;
  min: regDetalle;
  m:regMaestro;
begin

  for i:=1 to maquinas do begin
    assign(v[i],'detalle'+i);
    reset(v[i]):;
    leer(v[i],rDet[i]);
  end;
  assign (mae, 'maestro');
  rewrite (mae);
  minimo(rDet,min,v);
  while(min.cod<>valorAlto)do begin
     m.cod:=min.cod;

     m.tiempoTotal:=0;
     while(m.cod= min.cod)do begin
        m.tiempoTotal:= m.tiempoTotal +min.tiempo;
        m.fecha:= min.fecha; {queda asignada la ultima fecha, la mas reciente}
        minimo(rDet,min,v);
     end;
     write(mae,m);
  end;
  close(mae);
  for i:=1 to maquinas do
     close(v[i]);
end;

var
  mae:maestro;
  v:vectorDetalles;
  rDet:vectorRegDetalle;

begin

  actualizarMaestro(mae,v,rDet);
end.

