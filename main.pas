program arboles1_TRES;

type
  final=record
    legajo:integer;
    materia:integer;
    fecha:string;
    nota:1..10;
  end; 
  
  finales=^nodoLista;
  nodoLista=record
    dato:final;
    sig:finales;
  end;
  
  arbol=^nodo;
  nodo=record
    legajo:integer;
    lista: finales;
    HI: arbol;
    HD:arbol;
  end;
  
  procedure incisoA(VAR a:arbol);
      procedure leerFinal(VAR f:final);
      begin
         writeln('ingrese legajo del alumno');
         readln(f.legajo);
         if (f.legajo<>0) then begin
            writeln('CODIGO DE MATERIA');
            readln(f.materia);
            writeln('FECHA');
            readln(f.fecha);
            writeln('NOTA');
            readln(f.nota);
         end;
      end;
      
      procedure agregarAdelante(VAR l:finales; f:final);
      VAR 
        nue:finales;
      begin
        new(nue);
        nue^.dato:=f;
        nue^.sig:=l;
        l:=nue;
      end;
      
      procedure agregarNodo(VAR a:arbol; f:final);
      begin
        if(a=nil) then begin
          new(a);
          a^.lista:=nil;
          a^.legajo:=f.legajo;
          agregarAdelante(a^.lista,f);
          a^.HI:=nil;
          a^.HD:=nil;
        end
        else
          if(a^.legajo=f.legajo) then
            agregarAdelante(a^.lista,f)
          else 
            if(a^.legajo<f.legajo) then
              agregarNodo(a^.HD,f)
            else
              agregarNodo(a^.HI,f);
      end;
      
      procedure cargarArbol(VAR a:arbol);
      var
        f:final;
      begin
        leerFinal(f);
        while(f.legajo<>0) do begin
          agregarNodo(a,f);
          leerFinal(f);
        end;
      end;
  begin
    cargarArbol(a);
  end;
  
  {function incisoB(a:arbol): integer;
    function impar(legajo:integer): boolean;
    begin
      if (legajo MOD 2=0) then
        impar:=true
      else
        impar:=false;
    end;
  begin
    if(a=nil) then incisoB:=0
    else
      if(impar(a^.legajo)) then
        incisoB:= incisoB+1+incisoB(a^.HI)+ incisoB(a^.HD)
      else 
        incisoB:= incisoB+incisoB(a^.HI)+ incisoB(a^.HD);
  end;
  }
  
  
  {
  procedure incisoB(a:arbol; VAR cant:integer);
    function impar(legajo:integer): boolean;
    begin
      if (legajo MOD 2=0) then
        impar:=true
      else
        impar:=false;
    end;
  begin
    if(a<>nil)then  
      if (impar(a^.legajo))then  
        cant:=cant+1;
    incisoB(a^.HI,cant);
    incisoB(a^.HD,cant);
  end;
  }
  
  
  procedure imprimir(a:arbol);
  begin
    if (a<>nil) then begin
      imprimir(a^.HI);
      writeln(a^.legajo);
      imprimir(a^.HD);
    end;
  end;
  
  procedure incisoC(a:arbol);
    function recorrerLista(l:finales):integer;
    VAR cant:integer;
    begin
      cant:=0;
      while(l<>nil) do begin
        if(l^.dato.nota>4)then  
          cant:=cant+1;
        l:=l^.sig;
      end;
      recorrerLista:=cant;
    end;
  begin
    if(a<>nil)then begin
    writeln('legajo: ', a^.legajo, ' cant finales aprobados ', 
                                                   recorrerLista(a^.lista));
    incisoC(a^.HI);
    incisoC(a^.HD);
    end;
  end;
  
  procedure incisoD (a:arbol; valor:real);
    function calcularPromedio(l:finales):real;
    var
      cant, total:integer;
    begin
      cant:=0;
      total:=0;
      while(l<>nil)do begin
        total:=total+l^.dato.nota;
        cant:=cant+1;
        l:=l^.sig;
      end;
      calcularPromedio:= total/cant;
    end;
  var promedio:real;
  begin
    if (a<>nil) then begin
      promedio:= (calcularPromedio(a^.lista));
      if (promedio>valor)then 
        writeln('legajo: ', a^.legajo, ' SUPERA. prom: ', promedio);
      incisoD(a^.HD,valor);
      incisoD(a^.HI,valor);
    end;  
  end;
var 
  a:arbol;
  cant:integer;
  valor:real;
BEGIN
  cant:=0;
  a:=nil;
  incisoA(a);
  {incisoB(a,cant);
  writeln('la cantidad de alumnos con legajo impar es de',cant);}
  imprimir(a);
  incisoC(a);
  writeln('ingrese un valor para calcular promedios mayor');
  readln(valor);
  incisoD(a,valor);
END.

