global main

extern system
extern gets
extern printf
extern sscanf
extern sprintf
extern puts

extern fopen
extern fgets
extern fputs
extern fclose

%macro mStrAInt 3
    mov     rdi, %1
    mov     rsi, %2
    mov     rdx, %3
    sub     rsp, 8
    call    sscanf
    add     rsp, 8
%endmacro

%macro mEscribirArchivo 2
    mov     rdi, %1
    mov     rsi, %2 
    call    fputs
%endmacro

%macro mCastearAString 3
    mov rdi, %1
    mov rsi, %2
    xor rdx, rdx
    mov dx, %3
    call sprintf
%endmacro

%macro mMostrarTurno 0
    sub     rsp, 8
    call    mostrarTurno
    add     rsp, 8
%endmacro

%macro mLimparConsola 1
    mov     rdi, %1
    sub     rsp, 8
    call    system
    add     rsp, 8
%endmacro

%macro mBorrarPartida 1
    mov     rdi, %1
    sub     rsp, 8
    call    system
    add     rsp, 8
%endmacro

%macro mValidarFormatoFilYCol 0
    sub                 rsp,8 
    call                validarFormatoFilYCol
    add                 rsp,8 
%endmacro

%macro mEleccionOca 0
    sub                 rsp,8        
    call                calcular_desplazamiento
    add                 rsp,8

    sub                 rsp,8 
    call                validar_eleccion_oca
    add                 rsp,8 
%endmacro

%macro mValidarOca 0
    sub                 rsp,8 
    call                validar_oca
    add                 rsp,8 
%endmacro

%macro mValidarZorro 0
    sub                 rsp,8 
    call                validar_zorro
    add                 rsp,8 
%endmacro

%macro mValidarMovimiento 0
    sub                 rsp,8        
    call                calcular_desplazamiento
    add                 rsp,8

    sub                 rsp,8    
    call                validarMovimiento
    add                 rsp,8
%endmacro

%macro mEjecutarMovimiento 0
    sub                 rsp,8
    call                ejecutar_movimiento
    add                 rsp,8
%endmacro

%macro mValidarZorroEncerrado 0
    sub                 rsp,8
    call                ValidarZorroEncerrado
    add                 rsp,8
%endmacro

%macro mSscanf 4
    mov        rdi, %1 
    mov        rsi, %2 
    mov        rdx, %3
    mov        rcx, %4    
    sub        rsp, 8
    call       sscanf
    add        rsp, 8
%endmacro

%macro mGets 1
    mov        rdi, %1
    sub        rsp, 8
    call       gets 
    add        rsp, 8
%endmacro

%macro mPrintf 2
    mov     rdi, %1
    mov     rsi, %2
    sub     rsp, 8
    call    printf 
    add     rsp, 8
%endmacro

%macro mPrintfd 2
    mov     rdi, %1
    mov     rsi, %1
    sub     rsp, 8
    call    printf 
    add     rsp, 8
%endmacro

%macro mPuts 0
    sub     rsp, 8
    call    puts
    add     rsp, 8
%endmacro

%macro mRecuperar 3
    mov     rdi, %1
    mov     rsi, %2
    mov     rdx, %3
    sub     rsp, 8
    call    fgets
    add     rsp, 8
%endmacro

%macro mRecuperarMatriz 2
    mov   rsi, %1
    mov   rcx, %2
    rep   movsb
%endmacro

section .data
    msgInicio                   db "Bienvenido al juego del zorro y las ocas", 10, 0
    msgTurnoDelZorro            db "Es el turno del zorro ", 10, 0
    msgTurnoDeLasOcas           db "Es el turno de las ocas", 10, 0

    msgPedirFilYCol             db "Ingrese la fila y columna a la que desea ir (f c), 'q' para salir:", 10, 0
    msgPedirOca                 db "Ingrese la fila y columna de la Oca que desea mover, 'q' para salir", 10, 0

    msgDespedida                db "Gracias por jugar", 10, 0
    msgInputFormatoInvalido     db "El formato no es válido, ingrese la fila y la columna nuevamente", 10, 0
    msgRotacionInvalida         db "La rotacion no es valida, ingrese nuevamente", 10, 0
    msgCaracterInvalido         db "El caracter no es valido, ingrese nuevamente", 10, 0
    msgInputValorFyCInvalido    db "El valor de la fila o la columna no es válido, ingrese nuevamente", 10, 0
    msgCeldaOcupada             db "La celda a la cual desea moverse esta ocupada", 10, 0
    msgNoHayOca                 db "No hay ninguna oca en esa coordenada", 10, 0
    msgInputOcaInvalido         db "Las ocas no pueden hacer ese movimiento", 10, 0
    msgZorroGanador             db "El zorro gana por haber cazado 12 ocas", 10, 0
    msgOcasGanadoras            db "Las ocas ganan por haber encerrado al zorro", 10, 0

    msgRotarMatriz              db "Desea rotar la matriz? (s/n), 'q' para salir", 10, 0
    msgOrientacion              db "Elija la orientación de la matriz (D/I/A), 'q' para salir", 10, 0

    msgPersonalizarCaracteres   db "Desea personalizar los caracteres? (s/n), 'q' para salir", 10, 0
    msgNuevoCaracterOca         db "Ingrese el nuevo caracter para las ocas, 'q' para salir", 10, 0 
    msgNuevoCaracterZorro       db "Ingrese el nuevo caracter para el zorro, 'q' para salir", 10, 0

    msgMovimientosArriba        db "El zorro tuvo %hhi movimientos hacia arriba", 10, 0
    msgMovimientosAbajo         db "El zorro tuvo %hhi movimientos hacia abajo", 10, 0
    msgMovimientosIzquierda     db "El zorro tuvo %hhi movimientos hacia la izquierda", 10, 0
    msgMovimientosDerecha       db "El zorro tuvo %hhi movimientos hacia la derecha", 10, 0
    msgMovimientosDiagonal      db "El zorro tuvo %hhi movimientos en diagonal", 10, 0

    caracterZorro               db "X",0
    caracterOca                 db "O",0
    turnoActual                 db "X",0

    orientacionMatriz           db "N",0

    zorroTieneMovimientosDisponibles db "S",0
    ocasCazadas                 db 0

    filaActual                  db 6
    colActual                   db 5 

    filaZorro                   db 6
    colZorro                    db 5 

    movArriba                   db 0
    movAbajo                    db 0
    movIzq                      db 0
    movDerecha                  db 0
    movDiagonal                 db 0

    longFila                    db 10
    longElemento                db 1    

    matriz                      db " ","1","2","3","4","5","6","7","8","9",10
                                db "1","-","-","-","-","-","-","-","-","-",10 
                                db "2","-","-","-","O","O","O","-","-","-",10
                                db "3","-","-","-","O","O","O","-","-","-",10
                                db "4","-","O","O","O","O","O","O","O","-",10 
                                db "5","-","O"," "," "," "," "," ","O","-",10 
                                db "6","-","O"," "," ","X"," "," ","O","-",10 
                                db "7","-","-","-"," "," "," ","-","-","-",10 
                                db "8","-","-","-"," "," "," ","-","-","-",10 
                                db "9","-","-","-","-","-","-","-","-","-",10,0

    matrizDerecha               db " ","1","2","3","4","5","6","7","8","9",10
                                db "1","-","-","-","-","-","-","-","-","-",10 
                                db "2","-","-","-","O","O","O","-","-","-",10
                                db "3","-","-","-"," "," ","O","-","-","-",10
                                db "4","-"," "," "," "," ","O","O","O","-",10 
                                db "5","-"," "," ","X"," ","O","O","O","-",10 
                                db "6","-"," "," "," "," ","O","O","O","-",10 
                                db "7","-","-","-"," "," ","O","-","-","-",10 
                                db "8","-","-","-","O","O","O","-","-","-",10 
                                db "9","-","-","-","-","-","-","-","-","-",10,0

    matrizIzquierda             db " ","1","2","3","4","5","6","7","8","9",10
                                db "1","-","-","-","-","-","-","-","-","-",10 
                                db "2","-","-","-","O","O","O","-","-","-",10
                                db "3","-","-","-","O"," "," ","-","-","-",10
                                db "4","-","O","O","O"," "," "," "," ","-",10 
                                db "5","-","O","O","O"," ","X"," "," ","-",10 
                                db "6","-","O","O","O"," "," "," "," ","-",10 
                                db "7","-","-","-","O"," "," ","-","-","-",10 
                                db "8","-","-","-","O","O","O","-","-","-",10 
                                db "9","-","-","-","-","-","-","-","-","-",10,0


    matrizAbajo                db " ","1","2","3","4","5","6","7","8","9",10
                                db "1","-","-","-","-","-","-","-","-","-",10 
                                db "2","-","-","-"," "," "," ","-","-","-",10
                                db "3","-","-","-"," "," "," ","-","-","-",10
                                db "4","-","O"," "," ","X"," "," ","O","-",10 
                                db "5","-","O"," "," "," "," "," ","O","-",10 
                                db "6","-","O","O","O","O","O","O","O","-",10 
                                db "7","-","-","-","O","O","O","-","-","-",10 
                                db "8","-","-","-","O","O","O","-","-","-",10 
                                db "9","-","-","-","-","-","-","-","-","-",10,0

    formatoMsg                  db "%s", 0
    formatoMatriz               db "%s", 0
    formatoOcasComidas          db "Ocas comidas: %hhi",10, 0
    formatoFilaYCol             db "%li %li", 0
    formato                     db "%hhi", 0

    cmd_limpiar_pantalla        db "clear", 0
    cmd_borrar_partida          db "rm -rf partida.txt", 0
    nombreArchivo               db "partida.txt", 0
    modoLectura                 db "r", 0
    modoEscritura               db "w+", 0
    saltoDeLinea                db "",10,0
    juegoGanado                 db "N",0
    
section .bss
    inputFilYCol        resb 100
    inputRotarMatriz    resb 10
    inputPersonalizarCaracteres resb 10
    inputNuevoCaracter  resb 1
    fila                resq 1
    columna             resq 1
    iterI               resb 1
    iterJ               resb 1
    esFormatoValido     resb 1 ; S o N
    esMovimientoValido  resb 1 ; S o N
    salir               resb 1 ; S o N
    
    idArchivo           resq 1
    fila1               resb 12
    fila2               resb 12
    fila3               resb 12
    fila4               resb 12
    fila5               resb 12
    fila6               resb 12
    fila7               resb 12
    fila8               resb 12
    fila9               resb 12
    fila10              resb 12

    validar_zorro_puede_comer resb 1 ; S o N
    desplazamiento       resq 1
    desplazamiento_comer resq 1

    buffer               resb 50
    filaZorroStr         resb 3
    colZorroStr          resb 3
    ocasCazadasStr       resb 3
    movArribaStr         resb 3
    movAbajoStr          resb 3
    movIzqStr            resb 3
    movDerechaStr        resb 3
    movDiagonalStr       resb 3

    turnoActualBuffer    resb 2
    caracterZorroBuffer  resb 2
    caracterOcaBuffer    resb 2
    orientacionMatrizBuffer resb 2
section .text
main:
    mPrintf             formatoMsg, msgInicio 

    mov                 rdi, nombreArchivo
    mov                 rsi, modoLectura

    sub                 rsp, 8
    call                fopen
    sub                 rsp, 8
    test                rax, rax ; Comparo si el puntero al archivo es NULL, si es NULL sigo normalmente
    jz                  rotar_matriz
    jge                 openOk

rotar_matriz:
    mPrintf             formatoMsg, msgRotarMatriz

    mGets               inputRotarMatriz

    cmp                 byte[inputRotarMatriz], "q"
    je                  terminar_programa

    cmp                 byte[inputRotarMatriz], "n"
    je                  personalizar_caracteres

    cmp                 byte[inputRotarMatriz], "s"
    je                  pedir_orientacion
    
    mPrintf             formatoMsg, msgInputFormatoInvalido
    jmp                 rotar_matriz


pedir_orientacion:
    mPrintf             formatoMsg, msgOrientacion

    mGets               inputRotarMatriz

    cmp                 byte[inputRotarMatriz], "q"
    je                  terminar_programa

    cmp                 byte[inputRotarMatriz], "n"
    je                  personalizar_caracteres

    cmp                 byte[inputRotarMatriz], "D"
    je                  matriz_derecha

    cmp                 byte[inputRotarMatriz], "I"
    je                  matriz_izquierda

    cmp                 byte[inputRotarMatriz], "A"
    je                  matriz_abajo

    mPrintf             formatoMsg, msgRotacionInvalida
    jmp                 pedir_orientacion

matriz_derecha:
    mov    rdi, matriz
    mov    rsi, matrizDerecha
    mov    rcx, 100
    rep    movsb

    mov    byte[orientacionMatriz], "D"
    mov    byte[colActual], 4
    mov    byte[filaActual], 5
    mov    byte[colZorro], 4
    mov    byte[filaZorro], 5
    jmp    personalizar_caracteres

matriz_izquierda:
    mov    rdi, matriz
    mov    rsi, matrizIzquierda
    mov    rcx, 100
    rep    movsb

    mov    byte[orientacionMatriz], "I"
    mov    byte[colActual], 6
    mov    byte[filaActual], 5
    mov    byte[colZorro], 6
    mov    byte[filaZorro], 5
    jmp    personalizar_caracteres

matriz_abajo:
    mov    rdi, matriz
    mov    rsi, matrizAbajo
    mov    rcx, 100
    rep    movsb

    mov    byte[orientacionMatriz], "A"
    mov    byte[colActual], 5
    mov    byte[filaActual], 4
    mov    byte[colZorro], 5
    mov    byte[filaZorro], 4
    jmp    personalizar_caracteres

personalizar_caracteres:
    mPrintf             formatoMsg, msgPersonalizarCaracteres

    mGets               inputPersonalizarCaracteres

    cmp                 byte[inputPersonalizarCaracteres], "q"
    je                  terminar_programa

    cmp                 byte[inputPersonalizarCaracteres], "n"
    je                  loop_principal

    cmp                 byte[inputPersonalizarCaracteres], "s"
    je                  pedir_caracter_oca

    jmp                 personalizar_caracteres

pedir_caracter_oca:
    mPrintf             formatoMsg, msgNuevoCaracterOca
    mGets               inputNuevoCaracter

    cmp                 byte[inputNuevoCaracter], "q"
    je                  terminar_programa

    cmp                 byte[inputNuevoCaracter], "-"
    je                  pedir_caracter_oca

    cmp                 byte[inputNuevoCaracter], ""
    je                  pedir_caracter_oca

    cmp                 byte[inputNuevoCaracter], " "
    je                  pedir_caracter_oca

    mov                 rsi, inputNuevoCaracter
    mov                 rdi, caracterOca
    mov                 rcx, 1
    rep movsb

pedir_caracter_zorro:
    mPrintf             formatoMsg, msgNuevoCaracterZorro
    mGets               inputNuevoCaracter

    cmp                 byte[inputNuevoCaracter], "q"
    je                  terminar_programa

    cmp                 byte[inputNuevoCaracter], "-"
    je                  pedir_caracter_zorro

    cmp                 byte[inputNuevoCaracter], ""
    je                  pedir_caracter_zorro

    cmp                 byte[inputNuevoCaracter], " "
    je                  pedir_caracter_zorro

    mov                 rsi, inputNuevoCaracter
    mov                 rdi, caracterZorro
    mov                 rcx, 1
    rep movsb


    mov                 rsi, inputNuevoCaracter
    mov                 rdi, turnoActual
    mov                 rcx, 1
    rep movsb
    mov                 rcx, 110
    call                pisar_caracteres
    jmp loop_principal

pisar_caracteres:
    cmp rcx, 0
    jle terminar_pisar_caracteres

    mov al, [matriz + rcx] 
    cmp al, "O" 

    je pisarOca

    cmp al, "X"
    je pisarZorro

    dec rcx
    jmp pisar_caracteres


terminar_pisar_caracteres:
    ret

pisarOca:
    mov al, [caracterOca]
    mov byte[matriz + rcx], al

    dec rcx

    jmp pisar_caracteres

pisarZorro:
    mov al, [caracterZorro]
    mov byte[matriz + rcx], al
    
    dec rcx

    jmp pisar_caracteres

loop_principal:
    mPrintf             formatoOcasComidas, [ocasCazadas]
    mPrintf             formatoMatriz, matriz   

    cmp                 byte[ocasCazadas], 12
    je                  mostrarZorroGandor

    cmp                 byte[zorroTieneMovimientosDisponibles],"N"
    je                  mostrarOcasGanadoras

    mMostrarTurno

    mov                 al, byte[turnoActual]
    cmp                 al, byte[caracterOca]
    je                  turno_oca

turno_zorro:
    mPrintf             formatoMsg, msgPedirFilYCol

    mGets               inputFilYCol
     
    mValidarFormatoFilYCol
    cmp                 byte[salir], "S"
    je                  terminar_programa
    mValidarZorro

    cmp                 byte[salir], "S"
    je                  terminar_programa

    cmp                 byte[esFormatoValido], "N"
    je                  loop_principal
    
    mValidarMovimiento

    cmp                 byte[validar_zorro_puede_comer], 'S'
    je                  comer_oca

    cmp                 byte[esMovimientoValido], "N"
    je                  loop_principal
    mEjecutarMovimiento
    
ejecutar_movimiento_zorro:
    ;limpia  la posicion del zorro
    movzx   rax, byte [filaZorro]
    imul    rax, rax, 11            ; filaActualZorro * 10
    movzx   rbx, byte [colZorro]
    add     rax, rbx               ; filaActualZorro * 10 + colActualZorro
    mov     byte [matriz + rax], " "
    ;actualiza la posicion del zorro
    mov     al, byte [fila]
    mov     byte [filaZorro], al
    mov     al, byte [columna]
    mov     byte [colZorro], al
    ;actualizo en posicion de la matriz caracterZorro
    movzx   rax, byte [filaZorro]
    imul    rax, rax, 11            ; filaActualZorro * 10
    movzx   rbx, byte [colZorro]
    add     rax, rbx               ; filaActualZorro * 10 + colActualZorro
    mov     bl, [caracterZorro]
    mov     byte [matriz + rax], bl

    mLimparConsola      cmd_limpiar_pantalla 

    mov                 rdi, turnoActual
    mov                 rsi, caracterOca
    mov                 rcx, 1
    rep movsb
    jmp                 loop_principal

turno_oca: 
    mPrintf             formatoMsg, msgPedirOca

    mGets               inputFilYCol

    mValidarFormatoFilYCol
    mEleccionOca

    cmp                 byte[salir], "S" 
    je                  terminar_programa

    cmp                 byte[esFormatoValido], "N"
    je                  loop_principal

    mov     al, byte [fila]
    mov     byte [filaActual], al
    mov     al, byte [columna]
    mov     byte [colActual], al

    mPrintf             formatoMsg, msgPedirFilYCol

    mGets               inputFilYCol
    
    mPrintf             formatoMsg, msgPedirFilYCol
    
    mValidarFormatoFilYCol
    mValidarOca

    cmp                 byte[salir], "S"
    je                  terminar_programa

    cmp                 byte[esFormatoValido], "N"
    je                  loop_principal
    
    mValidarMovimiento

    cmp                byte[esMovimientoValido], "N"
    je                 loop_principal

    mEjecutarMovimiento
    mLimparConsola      cmd_limpiar_pantalla 

    mov                 rdi, turnoActual
    mov                 rsi, caracterZorro
    mov                 rcx, 1
    rep movsb

    mValidarZorroEncerrado

    jmp                 loop_principal

validarFormatoFilYCol:
    mov     byte[salir], "S"
    mov     byte[esFormatoValido], "N" ; Lo seteo en no válido por default para hacer el jmp

    cmp     byte[inputFilYCol], "q"
    je      mostrarDespedida
    
    mov     byte[salir], "N"

    mSscanf inputFilYCol, formatoFilaYCol, fila, columna

    cmp     rax,2
    jne     errorFormatoInvalido

    mov     byte[esFormatoValido], "S"
    
    ret
validarMovimiento:
    ; Inicializo q el zorro no puede comer
    mov     byte[validar_zorro_puede_comer], 'N'
    ; Validar los límites de la fila y columna
    mov     al, byte [fila]
    cmp     al, 8
    jg      errorValorInvalido
    cmp     al, 0
    jl      errorValorInvalido

    mov     al, byte [columna]
    cmp     al, 8
    jg      errorValorInvalido
    cmp     al, 0
    jl      errorValorInvalido
    
    ; verificar_si_puede comer
     
    ; Validar que la posición no esté ocupada o pueda comer
    mov     rsi, [desplazamiento]
    mov     al, byte[matriz + rsi]

    cmp     al, [caracterOca]
    je      validar_zorro_comer   

    cmp     al, " " ; espacio en blanco
    jne     errorCeldaOcupada

el_movimiento_es_valido:
    mov     byte[esMovimientoValido], "S"
    ret
validar_zorro_comer:
    mov rax, [desplazamiento]  ; Cargar desplazamiento en rax
    xor rdx, rdx               ; Limpiar rdx (para div)
    mov rcx, 11                ; Establecer el divisor (ancho de la matriz)
    div rcx                    ; Dividir rax por rcx (rax / 11), rax = cociente, rdx = residuo
    mov [fila], rax            ; Guardar cociente (fila) en filaActual
    mov [columna], rdx  

    mov     al, byte[filaZorro]
    cmp     al, byte[fila]
    je      calcular_col; 0
    jg      fila_menor ; -1
    jl      fila_mayor ; +1
calcular_col:
    mov     al, byte[colZorro]
    cmp     al, byte[columna]
    je      calcular_desplazamiento_comer
    jg      col_menor ; -1
    jl      col_mayor ; +1

calcular_desplazamiento_comer:
    movzx   rax, byte [fila]       ; Cargar fila en rax y extender con cero
    imul    rax, rax, 11           ; fila * 9
    
    movzx   rbx, byte [columna]    ; Cargar columna en rbx y extender con cero
    add     rax, rbx               ; fila * 9 + columna

    mov     [desplazamiento_comer], rax  ; guardar el desplazamiento calculado

    mov     al, byte [fila]
    cmp     al, 8
    jg      errorValorInvalido
    cmp     al, 0
    jl      errorValorInvalido

    mov     al, byte [columna]
    cmp     al, 8
    jg      errorValorInvalido
    cmp     al, 0
    jl      errorValorInvalido

    mov     rsi, [desplazamiento_comer]
    mov     al, byte[matriz + rsi]

    cmp     al, " " ; espacio en blanco
    jne     errorCeldaOcupada

    mov     byte[validar_zorro_puede_comer], 'S'
    jmp     el_movimiento_es_valido
fila_menor:
    dec     byte[fila]
    jmp     calcular_col
fila_mayor:
    inc     byte[fila]
    jmp     calcular_col
col_menor:
    dec     byte[columna]
    jmp     calcular_desplazamiento_comer
col_mayor:
    inc     byte[columna]
    jmp     calcular_desplazamiento_comer
comer_oca:
    inc     byte[ocasCazadas]

    mov     rsi, [desplazamiento]
    mov     al, " "
    mov     byte [matriz + rsi], al

    mov     rsi, [desplazamiento_comer]
    mov     al, byte [turnoActual]
    mov     byte [matriz + rsi], al

    jmp ejecutar_movimiento_zorro

validar_eleccion_oca:
    ; Validar que la posición no esté ocupada
    
    mov     rsi, [desplazamiento]
    mov     al, byte[matriz + rsi]
    cmp     al, byte[caracterOca]
    jne     errorEleccionOca
    ret

validar_oca:
    mov     al,byte[filaActual]
    add     al,byte[colActual]
    mov     bl,byte[fila]
    add     bl,byte[columna]
    cmp     al, bl
    je      invalidar_mov_oca

    add     al,1
    sub     bl,1
    cmp     al, bl
    je      invalidar_mov_oca
    sub     al,1
    add     bl,1

    sub     al,1
    add     bl,1
    cmp     al, bl
    je      invalidar_mov_oca

    cmp     byte[orientacionMatriz],"N"
    je      ocaMatrizNormal

    cmp     byte[orientacionMatriz],"D"
    je      ocaMatrizDerecha

    cmp     byte[orientacionMatriz],"I"
    je      ocaMatrizIzq

    cmp     byte[orientacionMatriz],"A"
    je      ocaMatrizAbajo

    ret

ocaMatrizNormal:
    mov     al, byte [columna]
    add     byte[colActual], 1
    mov     bl, byte[colActual]
    dec     byte[colActual]
    cmp     al, bl
    jg      invalidar_mov_oca

    dec     byte[colActual]
    mov     bl, byte[colActual]
    inc     byte[colActual]
    cmp     al, bl
    jl      invalidar_mov_oca

    mov     al, byte [fila]
    add     byte[filaActual], 1
    mov     bl, byte[filaActual]
    dec     byte[filaActual]
    cmp     al, bl
    jg      invalidar_mov_oca

    dec     byte[filaActual]
    mov     bl, byte[filaActual]
    inc     byte[filaActual]
    cmp     al, bl
    jle     invalidar_mov_oca
    
    ret

ocaMatrizDerecha:
    mov     al, byte [columna]
    add     byte[colActual], 1
    mov     bl, byte[colActual]
    dec     byte[colActual]
    cmp     al, bl
    jge     invalidar_mov_oca

    dec     byte[colActual]
    mov     bl, byte[colActual]
    inc     byte[colActual]
    cmp     al, bl
    jl      invalidar_mov_oca

    mov     al, byte [fila]
    add     byte[filaActual], 1
    mov     bl, byte[filaActual]
    dec     byte[filaActual]
    cmp     al, bl
    jg      invalidar_mov_oca

    dec     byte[filaActual]
    mov     bl, byte[filaActual]
    inc     byte[filaActual]
    cmp     al, bl
    jl      invalidar_mov_oca
    ret

ocaMatrizIzq:
    mov     al, byte [columna]
    add     byte[colActual], 1
    mov     bl, byte[colActual]
    dec     byte[colActual]
    cmp     al, bl
    jg      invalidar_mov_oca

    dec     byte[colActual]
    mov     bl, byte[colActual]
    inc     byte[colActual]
    cmp     al, bl
    jle      invalidar_mov_oca

    mov     al, byte [fila]
    add     byte[filaActual], 1
    mov     bl, byte[filaActual]
    dec     byte[filaActual]
    cmp     al, bl
    jg      invalidar_mov_oca

    dec     byte[filaActual]
    mov     bl, byte[filaActual]
    inc     byte[filaActual]
    cmp     al, bl
    jl      invalidar_mov_oca    

    ret

ocaMatrizAbajo:
    mov     al, byte [columna]
    add     byte[colActual], 1
    mov     bl, byte[colActual]
    dec     byte[colActual]
    cmp     al, bl
    jg      invalidar_mov_oca

    dec     byte[colActual]
    mov     bl, byte[colActual]
    inc     byte[colActual]
    cmp     al, bl
    jl      invalidar_mov_oca

    mov     al, byte [fila]
    add     byte[filaActual], 1
    mov     bl, byte[filaActual]
    dec     byte[filaActual]
    cmp     al, bl
    jge     invalidar_mov_oca

    dec     byte[filaActual]
    mov     bl, byte[filaActual]
    inc     byte[filaActual]
    cmp     al, bl
    jl      invalidar_mov_oca

    ret

validar_zorro:
    mov     al, byte [columna]
    add     byte[colZorro], 1
    mov     bl, byte[colZorro]
    dec     byte[colZorro]
    cmp     al, bl
    jg      invalidar_mov

    dec     byte[colZorro]
    mov     bl, byte[colZorro]
    inc     byte[colZorro]
    cmp     al, bl
    jl      invalidar_mov

    mov     al, byte [fila]
    add     byte[filaZorro], 1
    mov     bl, byte[filaZorro]
    dec     byte[filaZorro]
    cmp     al, bl
    jg      invalidar_mov

    dec     byte[filaZorro]
    mov     bl, byte[filaZorro]
    inc     byte[filaZorro]
    cmp     al, bl
    jl      invalidar_mov

    mov     al,byte[filaZorro]
    add     al,byte[colZorro]
    mov     bl,byte[fila]
    add     bl,byte[columna]
    cmp     al, bl
    je      diagonal_derecha
diagonal_derecha:
    mov     al, byte [filaZorro]
    add     al, 2
    cmp     al, byte [fila]
    jle     invalidar_mov
    sub     al, 4
    cmp     al, byte [fila]
    jge     invalidar_mov

    add     al,2
    sub     bl,1
    cmp     al, bl
    je      invalidar_mov
    sub     al,2
    add     bl,1

    sub     al,2
    add     bl,1
    cmp     al, bl
    je      invalidar_mov
   
    mov     al, byte[columna]
    mov     bl,byte[colZorro] 
    cmp     al, bl
    je      columnas_iguales

    mov     al, byte[fila]
    mov     bl,byte[filaZorro] 
    cmp     al, bl
    je      filas_iguales

    inc     byte[movDiagonal]  

    ret

columnas_iguales:
    mov     al, byte [fila]
    cmp     al,byte[filaZorro]
    jl      sumar_arriba
    cmp     al,byte[filaZorro]
    jg      sumar_abajo
    ret

filas_iguales:
    mov     al, byte [columna]
    cmp     al,byte[colZorro]
    jl      sumar_izquierda
    cmp     al,byte[colZorro]
    jg      sumar_derecha
    ret

sumar_abajo:
    inc     byte[movAbajo]
    ret
sumar_arriba:
    inc     byte[movArriba]
    ret
sumar_izquierda:
    inc     byte[movIzq]
    ret
sumar_derecha:
    inc     byte[movDerecha]
    ret

invalidar_mov:
    mov     byte[esFormatoValido], "N"  
    jmp     errorValorInvalido   
    ret

invalidar_mov_oca:
    mov     byte[esFormatoValido], "N"  
    jmp     errorValorInvalidoOca   
    ret

ValidarZorroEncerrado:
    mov     byte[zorroTieneMovimientosDisponibles],'N'

    sub                 rsp,8        
    call                calcularCuadrado
    add                 rsp,8

    sub                 rsp,8        
    call                calcularesquinas
    add                 rsp,8

    ret
calcularCuadrado:
    xor     rcx,rcx
    xor     rax,rax
    mov     byte[iterJ],-1
    mov     cl,3
aux:
    mov     byte[iterI],-1
aux_fil:
    mov     dl,[filaZorro]
    add     dl,[iterI]
    mov     [fila],dl
    mov     dl,[colZorro]
    add     dl,[iterJ]
    mov     [columna],dl

    call    calcular_desplazamiento
    
    mov     rsi, [desplazamiento]
    mov     al, byte[matriz + rsi]

    cmp     al, " " ; espacio en blanco
    je      hayMovimientoDisponible

    inc     byte[iterI]
    cmp     byte[iterI],2
    jl      aux_fil

    inc     byte[iterJ]
    loop    aux
    ret


calcularesquinas:
    xor     rcx,rcx
    xor     rax,rax
    mov     byte[iterJ],-2
    mov     cl,3
auxEsq:
    mov     byte[iterI],-2
aux_filEsq:
    mov     dl,[filaZorro]
    add     dl,[iterI]
    mov     [fila],dl
    mov     dl,[colZorro]
    add     dl,[iterJ]
    mov     [columna],dl

    call    calcular_desplazamiento
    
    mov     rsi, [desplazamiento]
    mov     al, byte[matriz + rsi]

    cmp     al, " " ; espacio en blanco
    je      hayMovimientoDisponible

    add     byte[iterI],2
    cmp     byte[iterI],3
    jl      aux_filEsq

    add     byte[iterJ],2
    loop    auxEsq
    ret

hayMovimientoDisponible:
    mov     byte[zorroTieneMovimientosDisponibles],'S'
    jmp     loop_principal
calcular_desplazamiento:
    ; Fórmula: (fila * longFila) + columna
    ; longFila = 9 columnas por fila
    movzx   rax, byte [fila]       ; Cargar fila en rax y extender con cero
    imul    rax, rax, 11           ; fila * 9
    
    movzx   rbx, byte [columna]    ; Cargar columna en rbx y extender con cero
    add     rax, rbx               ; fila * 9 + columna

    mov     [desplazamiento], rax  ; guardar el desplazamiento calculado
    ret

ejecutar_movimiento:
    ; Actualizar la matriz con el nuevo movimiento
    mov     rsi, [desplazamiento]
    mov     al, byte [turnoActual]
    mov     byte [matriz + rsi], al

    ; Limpiar la posición anterior 
    movzx   rax, byte [filaActual]
    imul    rax, rax, 11            ; filaActual * 10
    movzx   rbx, byte [colActual]
    add     rax, rbx               ; filaActual * 10 + colActual
    mov     byte [matriz + rax], " "

    ret

errorFormatoInvalido:
    mLimparConsola      cmd_limpiar_pantalla
    mPrintf formatoMsg, msgInputFormatoInvalido
    ret

errorValorInvalido:
    mLimparConsola      cmd_limpiar_pantalla
    mPrintf formatoMsg, msgInputValorFyCInvalido
    ret

errorValorInvalidoOca:
    mLimparConsola      cmd_limpiar_pantalla
    mPrintf formatoMsg, msgInputOcaInvalido
    ret    

errorCeldaOcupada:
    mov     byte[esMovimientoValido], "N"
    mLimparConsola      cmd_limpiar_pantalla
    mPrintf formatoMsg, msgCeldaOcupada
    ret

errorEleccionOca:
    mov     byte[esFormatoValido], "N"
    mLimparConsola      cmd_limpiar_pantalla
    mPrintf formatoMsg, msgNoHayOca
    ret

mostrarDespedida:
    mPrintf formatoMsg, msgDespedida
    ret

mostrarTurno:
    mov     al, byte[turnoActual]
    mov     bl, byte[caracterZorro]
    cmp     ax, bx
    je      mostrarTurnoZorro
    jmp     mostrarTurnoOcas

mostrarTurnoZorro:
    mPrintf    formatoMsg, msgTurnoDelZorro ;Esta bueno mezclar los jmps con los ret? Porque el ret te hace volver al main loop ¿?
    ret
    
mostrarTurnoOcas:
    mPrintf    formatoMsg, msgTurnoDeLasOcas
    ret

mostrarZorroGandor:
    mov     byte[salir],"S"
    mPrintf formatoMsg, msgZorroGanador
    mov     byte[juegoGanado], "S"

    sub     rsp, 8 
    call    mostrarDespedida
    add     rsp, 8

    jmp     terminar_programa


mostrarOcasGanadoras:
    mov     byte[salir], "S"
    mPrintf formatoMsg, msgOcasGanadoras
    mov     byte[juegoGanado], "S"

    sub     rsp, 8 
    call    mostrarDespedida
    add     rsp, 8
    jmp     terminar_programa

openOk:
    mov     [idArchivo], rax

    sub     rsp, 8
    call    recuperarPartida
    add     rsp, 8
    jmp     loop_principal

recuperarPartida:
    mRecuperar fila1, 13, [idArchivo]
    mRecuperar fila2, 13, [idArchivo]
    mRecuperar fila3, 13, [idArchivo]
    mRecuperar fila4, 13, [idArchivo]
    mRecuperar fila5, 13, [idArchivo]
    mRecuperar fila6, 13, [idArchivo]
    mRecuperar fila7, 13, [idArchivo]
    mRecuperar fila8, 13, [idArchivo]
    mRecuperar fila9, 13, [idArchivo]
    mRecuperar fila10, 13, [idArchivo]

    mRecuperar filaZorroStr,    4, [idArchivo]
    mRecuperar colZorroStr,     4, [idArchivo]
    mRecuperar ocasCazadasStr,  4, [idArchivo]
    mRecuperar movArribaStr,    4, [idArchivo]
    mRecuperar movAbajoStr,     4, [idArchivo]
    mRecuperar movIzqStr,       4, [idArchivo]
    mRecuperar movDerechaStr,   4, [idArchivo]
    mRecuperar movDiagonalStr,  4, [idArchivo]

    mRecuperar turnoActualBuffer,     3, [idArchivo]
    mRecuperar caracterZorroBuffer,   3, [idArchivo]
    mRecuperar caracterOcaBuffer,     3, [idArchivo]
    mRecuperar orientacionMatrizBuffer,     3, [idArchivo]

    mov rsi, turnoActualBuffer
    mov rdi, turnoActual
    mov rcx, 1
    rep movsb

    mov rsi, caracterZorroBuffer
    mov rdi, caracterZorro
    mov rcx, 1
    rep movsb

    mov rsi, caracterOcaBuffer
    mov rdi, caracterOca
    mov rcx, 1
    rep movsb

    mov rsi, orientacionMatrizBuffer
    mov rdi, orientacionMatriz
    mov rcx, 1
    rep movsb

    mov   rdi, matriz 

    mRecuperarMatriz fila1, 11
    mRecuperarMatriz fila2, 11
    mRecuperarMatriz fila3, 11
    mRecuperarMatriz fila4, 11
    mRecuperarMatriz fila5, 11
    mRecuperarMatriz fila6, 11
    mRecuperarMatriz fila7, 11
    mRecuperarMatriz fila8, 11
    mRecuperarMatriz fila9, 11
    mRecuperarMatriz fila10, 11
    
    mStrAInt filaZorroStr, formato, filaZorro
    mStrAInt colZorroStr, formato, colZorro
    mStrAInt ocasCazadasStr, formato, ocasCazadas
    mStrAInt movArribaStr, formato, movArriba
    mStrAInt movAbajoStr, formato, movAbajo
    mStrAInt movIzqStr, formato, movIzq
    mStrAInt movDerechaStr, formato, movDerecha
    mStrAInt movDiagonalStr, formato, movDiagonal
    ret

terminar_programa:
    mPrintf msgMovimientosArriba, [movArriba]
    mPrintf msgMovimientosAbajo, [movAbajo]
    mPrintf msgMovimientosIzquierda, [movIzq]
    mPrintf msgMovimientosDerecha, [movDerecha]
    mPrintf msgMovimientosDiagonal, [movDiagonal]
    mov                 rdi, nombreArchivo
    mov                 rsi, modoEscritura

    sub                 rsp, 8
    call                fopen
    mov                 [idArchivo], rax
    
    mEscribirArchivo matriz, [idArchivo] 

    mCastearAString buffer, formato, [filaZorro]
    mEscribirArchivo buffer, [idArchivo]

    mEscribirArchivo saltoDeLinea, [idArchivo]

    mCastearAString buffer, formato, [colZorro]
    mEscribirArchivo buffer, [idArchivo]

    mEscribirArchivo saltoDeLinea, [idArchivo]

    mCastearAString buffer, formato, [ocasCazadas]
    mEscribirArchivo buffer, [idArchivo]

    mEscribirArchivo saltoDeLinea, [idArchivo]

    mCastearAString buffer, formato, [movArriba]
    mEscribirArchivo buffer, [idArchivo]
    
    mEscribirArchivo saltoDeLinea, [idArchivo]

    mCastearAString buffer, formato, [movAbajo]
    mEscribirArchivo buffer, [idArchivo]

    mEscribirArchivo saltoDeLinea, [idArchivo]

    mCastearAString buffer, formato, [movIzq]
    mEscribirArchivo buffer, [idArchivo]

    mEscribirArchivo saltoDeLinea, [idArchivo]

    mCastearAString buffer, formato, [movDerecha]
    mEscribirArchivo buffer, [idArchivo]

    mEscribirArchivo saltoDeLinea, [idArchivo]
    
    mCastearAString buffer, formato, [movDiagonal]
    mEscribirArchivo buffer, [idArchivo]

    mEscribirArchivo saltoDeLinea, [idArchivo]
    mEscribirArchivo turnoActual, [idArchivo]

    mEscribirArchivo saltoDeLinea, [idArchivo]

    mEscribirArchivo caracterZorro, [idArchivo]
    mEscribirArchivo saltoDeLinea, [idArchivo]

    mEscribirArchivo caracterOca, [idArchivo]
    mEscribirArchivo saltoDeLinea, [idArchivo]

    mEscribirArchivo orientacionMatriz, [idArchivo]


    mov     rdi, [idArchivo]
    call    fclose
    add     rsp, 8
    cmp     byte[juegoGanado], "S"
    je      borrarPartida
    mov     rdi, 0
    mov     rax, 60
    syscall

borrarPartida:
    mBorrarPartida cmd_borrar_partida
    mov     rdi, 0
    mov     rax, 60
    syscall