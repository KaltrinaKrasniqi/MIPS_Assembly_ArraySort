.data
vektori: .space 20
msg1: .asciiz "Jep numrin e antareve te vektorit (max.5): "
msg2: .asciiz "\nShtyp elementet nje nga nje:\n"
msg3: .asciiz "\nVlerat e vektorit ne fund:\n"
newline: .asciiz "\n"
msg4: .asciiz "\nNumri max i anetareve duhet te jete 5!"
msg5: .asciiz "\nNumri i anetareve nuk mund te jete negativ!"
msg6: .asciiz "\nFundi i programit!"



.text
.globl main
main:

jal populloVektorin
#li $v0,1                #per ta printuar vlerën e n pas mbushjes së vektorit, por spo e ekzekutoj pasi mos te perzihet per sy me vlerat e anetareve gjate sortimit
#move $a0,$v1
#syscall
jal unazaKalimit



li $v0,4
la $a0,msg6
syscall
addi $sp,$sp,4           #e kthejm stekun ne poziten paraprake
                         # pasi qe e kemi zvogluar per 4 kur 
                         #kemi ruajtur return adresen ne stek


li $v0,10
syscall



populloVektorin:

addi $t0,$zero,5          #e leme nje vlere fillestare te n=5 per ta shprehur kushtin per max. anetare
li $v0,4        
la $a0,msg1               #printojme msg1
syscall

li $v0,5                  #kerkojm input integer
syscall

bgt $v0,$zero,Good        #kushti per mospranim te antareve negativ
li $v0,4                 
la $a0,msg5
syscall

li $v0,4
la $a0,newline
syscall
j populloVektorin         #bejm kercim te pakushtezuar te funksioni serish per te kerkuar input




Good:
bgt $v0,$t0,notGood
move $t0,$v0              #t0=n=5, arrijme ketu nese n<=5 dhe jo negativ
li $v0,4
la $a0,msg2
syscall

addi $t1,$zero,1          #i=1
j forloop1

#li $v0,4
#la $a0,msg4
#syscall
#j populloVektorin
   
notGood:                 #arrijme te kjo etikete nese n>5
li $v0,4
la $a0,msg4
syscall  

li $v0,4
la $a0,newline
syscall                  #serish bejme kercim te pakushtezuar ne funksion
j populloVektorin        #per te kerkuar serish input per n
                       

forloop1:

bgt $t1,$t0,exitloop1    #kushti vec nese i>n del nga loop1
li $v0, 5
syscall                  #kemi perdor instruksionin shift left logical per te kryer shumezim me 4,
sll $t2,$t1,2            #e kemi shenuar 2 sepse shiqohet si fuqi e numrit 2
sw $v0,vektori($t2)      #vleren e futur si input e dergojme ne memorie ku shihet se manipuli me vektor
                         #eshte bere duke perdor emrin e vektorit dhe duke kaluar neper secilen pozite te vektorit
                         

addi $t1,$t1,1     #i++
j forloop1

exitloop1:

addi $t2,$zero,0         #pastrimi i iteratorit per ta riperdorur regjistrin
addi $t1,$zero,0         #pastrimi i regjistrit t1 per ta riperdorur regjistrin
                         #edhe pse mund vetem ti mbishkruajme, por vec per ta bere 
                         #te qarte se nuk na duhen me vlerat e ruajtura ne to
#move $v1,$t0            #rezultatet e funskioneve zakonisht i ruajme ne $v1 por 
                         #ne kete rast seshte shume e rendesishme pasi vecse e kemi vleren e n ne $t0   
jr $ra                   #kthehemi serish ne main

unazaKalimit:

addi $sp,$sp,-4           
sw $ra,0($sp)             #return adresa per n'main u rujt nstek

addi $t1,$zero,1          #p=1
addi $t2,$t0,-1           #n-1

forloop2:

bgt $t1,$t2,exitloop2      #vec nese p>n-1 del nga loop2
sll $t3,$t1,2              #shumezojme iteratorin p per 4 per te kaluar neper qdo pozite te vektorit me rradhe
lw $t4,vektori($t3)        #min=a[p]
move $t5,$t1               #loc=p

jal unazaVlerave           # a nested function, dijme se na mbishkruhet return adresa
                           #prandaj e kemi ruajtur pararakisht ne stack

lw $ra,0($sp)              #marrim return adresen per tu kthyer ne main nga stack-pointeri


lw $t7,vektori($t3)        #tmp=a[p]
sll $t8,$t5,2
lw $t9,vektori($t8)        #a[loc]=t9
sw $t9,vektori($t3)        # a[p]=a[loc]
sw $t7,vektori($t8)        #a[loc]=tmp

addi $t1,$t1,1             #p=1
j forloop2

exitloop2:
addi $t7,$zero,0           #lirojme regjistrat
addi $t8,$zero,0      
addi $t1,$zero,0     

li $v0,4
la $a0,msg3               #printojme vlerat e vektorit ne fund
syscall

addi $t1,$zero,1          #i=1

forloop4:
bgt $t1,$t0,exitloop4     #vec nese i>n del nga loop4

sll $t7,$t1,2             #shumezojme i me 4 ruajme ne $t7
lw $t8,vektori($t7)       #ne $t8 ruajme vektorin ne ate pozite

li $v0,1
move $a0,$t8              #e printojme antarin ne ate pozite
syscall

li $v0,4
la $a0,newline            #qe anetaret te shfaqen ne newline
syscall

addi $t1,$t1,1            #i++
j forloop4

exitloop4:
jr $ra                    #kthehemi ne main per ta perfunduar programin


unazaVlerave:
addi $t6,$t1,1            #k=p+1
forloop3:
bgt $t6,$t0,exitloop3     #vec nese k>n del nga loop3
sll $t7,$t6,2             #shumezojme me 4 k per te kaluar ne qdo pozite te vektorit
lw $t8,vektori($t7)       #a[k] e kemi ruajtur ne $t8
bgt $t4,$t8,vazhdo        #nese min>a[k] hyn ne if dhe kryej ato operacione
                          #duke kaluar ne etiketen vazhdo

addi $t6,$t6,1  #k++
j forloop3


vazhdo:

lw $t4,vektori($t7)        #min=a[k]
move $t5,$t6               #loc=k
addi $t6,$t6,1  #k++
j forloop3



exitloop3:
addi $t7,$zero,0           #per ti riperdorur $t7 dhe $t8
addi $t8,$zero,0      
jr $ra                     #kthehemi ne instruksionin e ardhshem te funksionit unazaKalimit
                           #menjehere pas thirrjes se funksionit unazaVlerave





