{5. A partir de un siniestro ocurrido se perdieron las actas de nacimiento y fallecimientos de
toda la provincia de buenos aires de los últimos diez años. En pos de recuperar dicha
información, se deberá procesar 2 archivos por cada una de las 50 delegaciones distribuidas
en la provincia, un archivo de nacimientos y otro de fallecimientos y crear el archivo maestro
reuniendo dicha información.
Los archivos detalles con nacimientos, contendrán la siguiente información: nro partida
nacimiento, nombre, apellido, dirección detallada (calle,nro, piso, depto, ciudad), matrícula
del médico, nombre y apellido de la madre, DNI madre, nombre y apellido del padre, DNI del
padre.
En cambio, los 50 archivos de fallecimientos tendrán: nro partida nacimiento, DNI, nombre y
apellido del fallecido, matrícula del médico que firma el deceso, fecha y hora del deceso y
lugar.
Realizar un programa que cree el archivo maestro a partir de toda la información de los
archivos detalles. Se debe almacenar en el maestro: nro partida nacimiento, nombre,
apellido, dirección detallada (calle,nro, piso, depto, ciudad), matrícula del médico, nombre y
apellido de la madre, DNI madre, nombre y apellido del padre, DNI del padre y si falleció,
además matrícula del médico que firma el deceso, fecha y hora del deceso y lugar. Se
deberá, además, listar en un archivo de texto la información recolectada de cada persona.
Nota: Todos los archivos están ordenados por nro partida de nacimiento que es única.
Tenga en cuenta que no necesariamente va a fallecer en el distrito donde nació la persona y
además puede no haber fallecido.
}

program ejercicio5;

const
  valorAlto = 9999;
  delegaciones = 50;

type
  cadena20 = string [20];

  direc = record
    calle: cadena20;
    nro:integer;
    piso:integer;
    depto:integer;
    ciudad: cadena20;
  end;

  mama = record
    nom:cadena20;
    ape:cadena20;
    dni:integer;
  end;

  papa= record
    nom:cadena20;
    ape:cadena20;
    dni:integer;
  end;

  nacido = record
    nroPartida:integer;
    nom:cadena20;
    ape: cadena20;
    dir : direc;
    matriculaMedico:integer;
    madre: mama;
    padre: papa;

  end;

  fallecido = record
    nroPartida:integer;
    dni:integer;
    nombre: cadena20;
    ape:cadena20;
    matriculaMedico: integer;
    fecha: cadena20;
    hora: cadena20;
  end;

  datosFalle = record
    matriculaMedico:integer;
    fecha:cadena20;
    hora:cadena20;
    lugar:cadena20;
  end;

  archMaestro = record
     datoNac: nacido;
     fallecio : boolean;
     datoFal: datosFalle;
  end;

  maestro = file of archMaestro;

  detalleNacido = file of nacido;
  detalleFallecido = file of fallecido;

  vectorDetalleNacido = array [1..delegaciones]of detallaNacido;
  vectorDetalleFallecido = array [1..delegaciones]of detalleFallecido;

  vectorNacido = array[1..delegaciones]of nacido;
  vectorFallecido = array [1..delegaciones]of fallecido;

procedure leerNacido(var arch:detalleNacido; dato: nacido);
begin
  if (not eof(arch))then
        read(arch,dato);
  else
     dato.nroPartida:=valorAlto;
end;

procedure leerFallecido(var arch: detalleFallecido ; dato: fallecido);
begin
  if (not eof(arch))then
        read(arch, dato);
  else
      dato.nroPartida:= valorAlto;
end;

procedure minimoNacido(var min:nacido; var det: vectorDetalleNacido; var regDet: vectorNacido);
var
  i,indiceMin:integer;
begin
  indiceMin:=-1;
  min.nroPartida:=valorAlto;
  for i:= 1 to delegaciones do
      if(regDet[i].nroPartida<>valorAlto)then
            if (regDet[i].nroPartida<= min.nroPartida)then begin
                   min:= regDet[i];
                   indiceMin:=i;
            end;
  if (indiceMin<>-1)then
        leer(det[indiceMin],regDet[indiceMin]);
end;

procedure minimoFallecido(var min:fallecido; var det:vectorDetalleFallecido; var regDet:vectorFallecido);
var
  i,indiceMin:integer;
begin
  indiceMin:=-1;
  min.nroPartida:=valorAlto;
  for i:=1 to delegaciones do
      if (regDet[i].nroPartida<>valorAlto)then
            if(regDet[i].nroPartida<= min.nroPartida)then begin
                   min:=regDet[i];
                   indiceMin:=i;
            end;
  if (indiceMin<>-1)then
        leer(det[indiceMin], regDet[indiceMin]);

end;

procedure crearMaestro(var mae: maestro; var vDetNac: vectorDetalleNacido;
                       var vDetFal: vectorDetalleFallecido; var regNac : vectorNacido;
                       var regFal : vectorFallecido);
var
  i:integer;
  n:nacido;
  f:fallecido;
  m: archMaestro;
begin
  for i:=1 to delegaciones do begin
    assign(vDetNac[i],'detalleNacido'+i);
    assign(vDetFal[i], 'detalleFallecido'+i);
    reset(vDetNac[i]); reset (vDetFal[i]);
    leerNacido(vDetNac[i], regNac[i]);
    leerFallecido(vDetFal[i], regFal[i]);
  end;
  minimoNacido(n,vDetNac,regNac);
  minimoFallecido(f,vDetFal,regFal);
  while(n.nroPartida<>valorAlto)do begin
            if (n.nroPartida= f.nroPartida)then
                  m.fallecio:=true;
                  m.dato:=n;
                  minimoFallecido(f,vDetFal,regDet);
            else begin
                        m.fallecio:= false;
			m.datoFal.matriculaMedico:='';
			m.datoFal.fecha:='';
			m.datoFal.hora:='';
			m.datoFal.lugar:='';
		end;
            m.datoNac:= n;
            write(mae,m);
            minimoNacido(n,vDetNac,regNac);

  end;
  for i:=1 to delegaciones do begin
      close(vDetNac[i]);
      close(vDetFal[i]);
  end;
  close(mae);

end;



var
  mae:maestro;
  vDetNac: vectorDetalleNacido;
  vDetFal: vectorDetalleFallecido;
  regNac : vectorNacido;
  regFal : vectorFallecido;
begin
  assign(mae,'maestro');
  crearMaestro(mae,vDetNac,vDetFal,regNac,regFal);

