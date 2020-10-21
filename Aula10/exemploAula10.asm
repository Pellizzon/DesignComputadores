#====================================================================
# Nome:
#
# Função do programa:   Soma de Vetores
#
#====================================================================

#====================================================================
#       Inicialização dos dados de alocação estática
#====================================================================

# Suas definições dos dados estão após a diretiva ".data".
.data
vetor1:   .word     1 2 3 4 5 6 7 8 9 10
vetor2:   .word     1 2 3 4 5 6 7 8 9 10
vetor3:   .word     21 22 23 24 25 26 27 28 29 30
#
#====================================================================
#       Programa
#====================================================================
.text
.globl main       # A etiqueta "main" tem acesso global. Pode usar o nome dela no QtSPIM.
.ent   main       # Define que o ponto de entrada no programa é a rotina "main" (opcional).

main:
# Inicializa contador e ponteiros:
li      $t0, 10;                  # contador
la     $t1, vetor1;             # endereco vetor
la     $t2, vetor2;
la     $t3, vetor3;

inicio:
# Carrega Valores:
lw     $t4, 0($t1);
lw     $t5, 0($t2);

# Soma:
add    $t6, $t5, $t4;

# Armazena no vetor3:
sw     $t6, 0($t3);

li $v0, 1;
lw $a0, 0($t3);
syscall;

#incrementa ponteiros:
addi   $t1, $t1, 4;
addi   $t2, $t2, 4;
addi   $t3, $t3, 4;

#decrementa contador:
addi   $t0, $t0, -1;


# desvia:
beq    $t0, $0, fim;
j        inicio;

fim:
li        $v0,10;         # Fim da execução: código 10.
syscall

.end main