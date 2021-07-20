org 0000h
init_serial:    mov scon,#50h
				mov tmod,#21h
				mov tl1,#0fdh
				mov th1,#0fdh
				setb tr1	

main:       mov p0,#00h
            clr p0.1
            acall lcdi
            acall init_gsm
display1:   mov dptr,#table
            mov r7,#05h
			mov r0,#00h
backdis1:   mov a,r0
            movc a,@a+dptr
			acall lcddata
			inc r0
			djnz r7,backdis1
            acall send_gsm1
            acall recieve
display2:   mov a,#0c0h
            acall lcdcmd
            mov dptr,#table1
            mov r7,#05h
			mov r0,#00h
backdis2:   mov a,r0
            movc a,@a+dptr
			acall lcddata
			inc r0
			djnz r7,backdis2
			setb p0.1
hereyo:     sjmp hereyo

send:    	mov sbuf,a
waits:      jnb ti,waits
			clr ti 
			ret
			
recieve:    acall init_gsmr
            acall delay
waitr:      jnb ri,waitr
			mov a,sbuf
			clr ri
			ret

timer0:     mov tl0,#00h
			mov th0,#00h
			setb tr0
waitt0:		jnb tf0,waitt0
			clr tr0
			clr tf0
			ret
			
delay:		mov r1,#7h
backd:      acall timer0
			djnz r1,backd
			ret

lcdi:       mov a,#38h
            acall lcdcmd
			acall delay
			mov a,#0eh
			acall lcdcmd
			acall delay
			mov a,#01h
            acall lcdcmd
			acall delay
			mov a,#06h
			acall lcdcmd
			acall delay
			mov a,#80h
			acall lcdcmd
			acall delay
			ret
			
lcdcmd:	    mov p2,a
            clr p3.7
			clr p3.6
			setb p3.5
			acall delay
			clr  p3.5
			acall delay
			ret

lcddata:	mov p2,a
            setb p3.7
			clr p3.6
			setb p3.5
			acall delay
			clr p3.5
			acall delay
			ret
			
init_gsm: 	MOV A,#"A"
            ACALL SEND
			MOV A,#"T"
			ACALL SEND
			MOV A,#0DH
			ACALL SEND
			
			ACALL DELAY

			MOV A,#"A"
			ACALL SEND
			MOV A,#"T"
			ACALL SEND
			MOV A,#"+"
			ACALL SEND
			MOV A,#"C"
			ACALL SEND
			MOV A,#"M"
			ACALL SEND
			MOV A,#"G"
			ACALL SEND
			MOV A,#"F"
			ACALL SEND
			MOV A,#"="
			ACALL SEND
			MOV A,#"1"
			ACALL SEND
			MOV A,#0DH
			ACALL SEND
			ACALL DELAY

			MOV A,#"A"
			ACALL SEND
			MOV A,#"T"
			ACALL SEND
			MOV A,#"+"
			ACALL SEND
			MOV A,#"C"
			ACALL SEND
			MOV A,#"M"
			ACALL SEND
			MOV A,#"G"
			ACALL SEND
			MOV A,#"S"
			ACALL SEND
			MOV A,#"="
			ACALL SEND
			MOV A,#34D
			ACALL SEND
			MOV A,#"+"
			ACALL SEND
			MOV A,#"9"
			ACALL SEND
			MOV A,#"1"
			ACALL SEND
			MOV A,#"8"
			ACALL SEND
			MOV A,#"2"
			ACALL SEND
			MOV A,#"9"
			ACALL SEND
			MOV A,#"9"
			ACALL SEND
			MOV A,#"0"
			ACALL SEND
			MOV A,#"7"
			ACALL SEND
			MOV A,#"6"
			ACALL SEND
			MOV A,#"7"
			ACALL SEND
			MOV A,#"5"
			ACALL SEND
			MOV A,#"7"
			ACALL SEND
			MOV A,#34D
			ACALL SEND
			MOV A,#0DH
			ACALL SEND
			ACALL DELAY
			ret

init_gsmr:	mov a,"A"
            ACALL SEND
			MOV A,#"T"
			ACALL SEND
			MOV A,#"+"
			ACALL SEND
			MOV A,#"C"
			ACALL SEND
			MOV A,#"N"
			ACALL SEND
			MOV A,#"M"
			ACALL SEND
			MOV A,#"I"
			ACALL SEND
			MOV A,#"="
			ACALL SEND
			MOV A,#"2"
			ACALL SEND
			MOV A,#","
			ACALL SEND
			MOV A,#"2"
			ACALL SEND
			MOV A,#","
			ACALL SEND
			MOV A,#"0"
			ACALL SEND
			MOV A,#","
			ACALL SEND
			MOV A,#"0"
			ACALL SEND
			MOV A,#","
			ACALL SEND
			MOV A,#"0"
			ACALL SEND
			ACALL DELAY
			RET

SEND_GSM1:  MOV A,#"T"
			ACALL SEND
			MOV A,#"H"
			ACALL SEND
			MOV A,#"E"
			ACALL SEND
			MOV A,#"F"
			ACALL SEND
			MOV A,#"T"
			ACALL SEND
			ACALL DELAY
			MOV A,#1AH
			ACALL SEND
            ret			

      		org 0400h
table:	    db 'Theft',0
table1:		db 'stopp',0
			
endhere:   	sjmp endhere
            end


