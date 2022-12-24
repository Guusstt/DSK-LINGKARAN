Assign macro g, h
    mov ax, [h]
    mov [g], ax    
endm


Negate macro g
    mov ax, [g]
    neg ax
    mov [g], ax    
endm

IncVar macro g
    mov ax, [g]
    inc ax
    mov [g], ax    
endm

DecVar macro g
    mov ax, [g]
    dec ax
    mov [g], ax    
endm

Compare2Variables macro g, h
    mov cx, [g]
    cmp cx, [h]
endm

CompareVariableAndNumber macro g, h
    mov cx, [g]
    cmp cx, h
endm

AddAndAssign macro i, g, h
    mov ax, [g]
    add ax, [h]
    mov [i], ax
endm 

SubAndAssign macro i, g, h
    mov ax, [g]
    sub ax, [h]
    mov [i], ax
endm

Add3NumbersAndAssign macro j, g, h, i
    mov ax, [g]
    add ax, [h]
    add ax, [i]
    mov [j], ax
endm 

Sub3NumbersAndAssign macro j, g, h, i
    mov ax, [g]
    sub ax, [h]
    sub ax, [i]
    mov [j], ax
endm

DrawPixel macro x, y
    
    mov cx, [x]   
    mov dx, [y]  
     
    mov al, 10  
    mov ah, 0ch 
    int 10h     
endm

DrawCircle macro circleCenterX, circleCenterY, radius

    balance dw 0
    xoff dw 0
    yoff dw 0 
    
    xplusx dw 0
    xminusx dw 0
    yplusy dw 0
    yminusy dw 0
    
    xplusy dw 0
    xminusy dw 0
    yplusx dw 0
    yminusx dw 0
    
    Assign yoff, radius
    
    Assign balance, radius
    Negate balance
    
    draw_circle_loop:
     
     AddAndAssign xplusx, circleCenterX, xoff
     SubAndAssign xminusx, circleCenterX, xoff
     AddAndAssign yplusy, circleCenterY, yoff
     SubAndAssign yminusy, circleCenterY, yoff
     
     AddAndAssign xplusy, circleCenterX, yoff
     SubAndAssign xminusy, circleCenterX, yoff
     AddAndAssign yplusx, circleCenterY, xoff
     SubAndAssign yminusx, circleCenterY, xoff
   
    DrawPixel xplusy, yminusx
  
    DrawPixel xplusx, yminusy
      
    DrawPixel xminusx, yminusy
       
    DrawPixel xminusy, yminusx
       
    DrawPixel xminusy, yplusx
      
    DrawPixel xminusx, yplusy
           
    DrawPixel xplusx, yplusy
        
    DrawPixel xplusy, yplusx
   
    Add3NumbersAndAssign balance, balance, xoff, xoff
       
    CompareVariableAndNumber balance, 0
    jl balance_negative
   
    DecVar yoff
    
    Sub3NumbersAndAssign balance, balance, yoff, yoff
    
    balance_negative:
    IncVar xoff
    
    Compare2Variables xoff, yoff
    jg end_drawing
    jmp draw_circle_loop
    
    end_drawing:
        
endm

org  100h

mov ah, 0   
mov al, 13h 
int 10h     
         
x dw 80 
y dw 80 
r dw 20 

DrawCircle x, y, r

  mov ah,00
  int 16h			

  mov ah,00 
  mov al,03 
  int 10h   

ret
