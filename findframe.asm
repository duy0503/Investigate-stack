;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
;Author information
;  Author name: Floyd Holliday
;  Author email: holliday@fullerton.edu or activeprofessor@yahoo.com
;  Author location: Barstow, California
;Course information
;  Course number: CPSC240
;  Assignment number: 8
;  Due date: 2015-Aug-25
;Project information
;  Project title: Hack the stack
;  Purpose: This is a reverse engineering experiment.  The purpose of this suite of programs is to help investigate how C and C++ use the system stack.
;  Status: No known errors
;  Project files: program-p0.c, program-p1.c, program-p2.asm, program-p3.c, program-p4.asm
;  Project references: Intel Processor Identification and the CPUID Instruction, Application Note 485, revised May 2012 (App-Note 485).
;Module information
;  This module's call name: program-p4.asm
;  Language: X86-64
;  Syntax: Intel
;  History: 
;  Date last modified: 2015-April-15 (source code).
;  Purpose: This program serves to call dumpstack.  It also shows the importance of "mov rbp, rsp" during backup of GPRs.  
;  File name: program-p4.asm
;  Status: This program works correctly.  It is very simple
;  Future enhancements: Nothing more to do.
;Translator information
;  Linux: nasm -f elf64 -l findframe.lis -o findframe.o findframe.asm
;References and credits
;  http://www.drpaulcarter.com/pcasm/index.php
;Format information
;  Page width: 172 columns
;  Begin comments: 61
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;Permissions
;  The source code is free for use by members of the 240 programming course.  You should credit this source if you borrow executable statements from this program.  The
;  instructions are free to use, but the borrower must create his or her own comments.  The comments belong to the author.

;===== Begin area for source code ==========================================================================================================================================
%include "debug.inc"                                        ;This statement makes the debugger available to this program.  However, the debugger is not currently in use.
                                                            ;Therefore, the statement is commented out.  The include is an example of an assembler directive.  Here the
                                                            ;assembler will insert the source code of the debugger.

extern printf                                               ;This function will be linked into the executable by the linker

global findframe                                                   ;Make this program callable by modules outside this file

segment .data                                               ;Place initialized data in this segment

welcome db "Welcome to an investigation of the use of the stack by C language.  This message outputted by program p4", 10, 0
specifierforstringdata db "%s", 0
newline db 10, 0
rbpmessage db "Addresses of rbp.", 10, 0
rbpoutput db "rbp =  %016lx ", 10, 0
purpose db "This program will show the stack to allow the user to see the stack frames, which are also known as activation records.", 10, 0

segment .bss                                                ;Place uninitialized data in this segment

align 64                                                    ;Ask that the next data declaration start on a 64-byte boundary.
backuparea resb 832                                         ;Create an array for backup storage having 832 bytes.

segment .text                                               ;Place executable statements in this segment

findframe:                                                         ;Entry point: execution will begin here.

;=========== Back up all the GPR registers except rax, rsp, and rip.  That means 15 GPRs are backed up. ===================================================================

push       rbp                                              ;Save a copy of the stack base pointer
mov        rbp, rsp                                         ;We do this in order to be 100% compatible with C and C++.
push       rbx                                              ;Back up rbx
push       rcx                                              ;Back up rcx
push       rdx                                              ;Back up rdx
push       rsi                                              ;Back up rsi
push       rdi                                              ;Back up rdi
push       r8                                               ;Back up r8
push       r9                                               ;Back up r9
push       r10                                              ;Back up r10
push       r11                                              ;Back up r11
push       r12                                              ;Back up r12
push       r13                                              ;Back up r13
push       r14                                              ;Back up r14
push       r15                                              ;Back up r15
pushf                                                       ;Back up rflags


;===========================================================================================================================================================================
;===== Begin State Component Backup =======================================================================================================================================
;===========================================================================================================================================================================

mov       rdx, 0
mov       rax, 6
xsave     [backuparea]

;==========================================================================================================================================================================
;===== End of State Component Backup ======================================================================================================================================
;==========================================================================================================================================================================


;==========================================================================================================================================================================
startapplication: ;===== Begin the application here: Hack the stack =======================================================================================================
;==========================================================================================================================================================================

;===== Show the welcome message followed by the purpose message ===========================================================================================================

mov qword rax, 0                                            ;A zero in rax means printf accepts no data from xmm registers
mov       rdi, specifierforstringdata                       ;"%s"
mov       rsi, welcome                                      ;"This program will show the stack to allow the user . . ."
call      printf                                            ;Use external function to handle the output

;Visually inspect the stack.
mov       r11, rbp                                          ;Copy the original value of rbp to a safe place for a short time
mov       rbp, rsp                                          ;The starting address for dumpstack must be in rbp
dumpstack 45,0,50                                           ;View 60 quadwords of stack
mov       rbp, r11                                          ;Restore original value to rbp


mov r10,  0x401EC0;

mov rax, 0
mov rdi, specifierforstringdata
mov rsi, rbpmessage
call printf

;While loop
startloop:

  cmp [rbp], r10
  je endloop

  mov rax, 0
  mov rdi, rbpoutput
  mov rsi, rbp
  call printf

  mov rbp, [rbp]
  jmp startloop

endloop:
;After inspecting the stack, change the value 8 to 16383

mov qword [rsp + 368], 16383

;Print out the stack to verify that 8 has been changed to 16383

mov       r11, rbp                                          ;Copy the original value of rbp to a safe place for a short time
mov       rbp, rsp                                          ;The starting address for dumpstack must be in rbp
dumpstack 45,0, 50                                           ;View 60 quadwords of stack
mov       rbp, r11                                          ;Restore original value to rbp

;==========================================================================================================================================================================
;===== Begin State Component Restore ======================================================================================================================================
;==========================================================================================================================================================================

mov       rdx, 0
mov       rax, 6
xrstor    [backuparea]

;==========================================================================================================================================================================
;===== End State Component Restore ========================================================================================================================================
;==========================================================================================================================================================================


;=========== Restore GPR values and return to the caller ==================================================================================================================

popf                                                        ;Restore rflags
pop        r15                                              ;Restore r15
pop        r14                                              ;Restore r14
pop        r13                                              ;Restore r13
pop        r12                                              ;Restore r12
pop        r11                                              ;Restore r11
pop        r10                                              ;Restore r10
pop        r9                                               ;Restore r9
pop        r8                                               ;Restore r8
pop        rdi                                              ;Restore rdi
pop        rsi                                              ;Restore rsi
pop        rdx                                              ;Restore rdx
pop        rcx                                              ;Restore rcx
pop        rbx                                              ;Restore rbx
pop        rbp                                              ;Restore rbp


;===== Send a return value to the caller ===================================================================================================================================
;No special value is required for this program, therefore, we'll simply send negative one to the caller program.

mov        rax, -2                                          ;send -2 back

ret                                                         ;ret pops the stack into rip.  The correct number must be on top of stack.

;===== End of function finalassembly =======================================================================================================================================
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
