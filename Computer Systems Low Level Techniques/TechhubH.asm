.model small
.stack 1000h ; Increased stack size to 4KB (from 100h)
.386
.data

    ; Syntax
    CRLF DB 13,10,'$'
    t
    ;Validations
    InvalidMsg DB 13,10, 'Invalid input. Please try again.', 13,10,10,10,10,'$'
    CannotSell DB 13,10,'Cannot Sell More than the Available Quantity. $'
    MaximumStock DB 13,10,'The Item will Exceed Maximum Stock (9)! $'

    ; Strings for Main Menu Display, Exit & UserInput - Store name reverted
    ; Added option 6 for Export
    Mheader DB 13, '---------------------<Hemanth''s Techhub Inventory System>-------------------'
            DB 13, 10, 9,'------------------MAIN MENU-----------------'
            DB 13, 10, 10 ,'1.View Storage Inventory'
            DB 13, 10, '2.View Items By ... Category'
            DB 13, 10, '3.Sell Electronic Devices or Accessories'
            DB 13, 10, '4.Items Restock'
            DB 13, 10, '5.Export Inventory' ; SWAPPED: Old was '5.Exit the Program'
            DB 13, 10, '6.Exit the Program', 13, 10, '$' ; SWAPPED: Old was '6.Export Inventory'
    user_input DB 13,10, 'Select an Option: $'
    EnterRet DB 13,10, 'Press Enter to Return to Menu$',13,10
    Exit DB 13,10,'Are you sure you want to exit (y/n): $',13,10
    TyMsg DB 13,10,9,'-------------------------------------------------------------------'
          DB 13,10,9,9,'Thank You for Using Hemanth''s Techhub Inventory System !'
          DB 13,10,9,'-------------------------------------------------------------------','$'

    ; View Inventory Header - Alignment tabs reverted to old code
    INVTheader DB 13,10,'-----------------<Hemanth''s Techhub Inventory System>-----------------'
               DB 13,10,9,'-------------------<INVENTORY>-----------------'
               DB 13,10,'ID',9,'Name',9,9,9,9,'Price',9,9,'Quantity',13,10,'$'
    
    ;Sell Items Strings
    SellOption DB 13,10,'Select an Item to Sell (e to Exit to Main Menu): $'
    SellQuantity DB 13,10,'How many do you want to sell?: $'
    Remain_Qty DB 13,10,'Remaining Quantity for $'

    ;Restock Items Strings
    RestockQuantity DB 13,10,'How many do you want to restock?: $'
    RestockOption DB 13,10,'Select an Item to Restock (e to Exit to Main Menu): $'

    ;Categories Strings - Store name reverted and alignment tabs reverted to old code
    CatHeader DB 13,'-----------------<Hemanth''s Techhub Inventory System>-----------------'
              DB 13,10,9,'---------------<View By Categories>---------------'
              DB 13,10,'1. Tablets'
              DB 13,10,'2. Mobile Phones'
              DB 13,10,'3. TVs'
              DB 13,10,'4. Exit to Main Menu',13,10,'$'
    CatOption DB 13,'Select a Category: $'
    TabletHeader DB 13,'-----------------<Hemanth''s Techhub Inventory System>-----------------'
                 DB 13,10,9,'----------------<   Tablets   >----------------'
                 DB 13,10,'ID',9,'Name',9,9,9,9,'Price',9,9,'Quantity',13,10,'$'
    PhoneHeader DB 13,'-----------------<Hemanth''s Techhub Inventory System>-----------------'
                DB 13,10,9,'----------------<   Mobile Phones   >----------------'
                DB 13,10,'ID',9,'Name',9,9,9,9,'Price',9,9,'Quantity',13,10,'$'
    TVHeader DB 13,'-----------------<Hemanth''s Techhub Inventory System>-----------------'
             DB 13,10,9,'----------------<   TVs   >----------------'
             DB 13,10,'ID',9,'Name',9,9,9,9,'Price',9,9,'Quantity',13,10,'$'

    ; Inventory
    item0 DB '1',9,'Samsung Galaxy Tab S9',9,9,'RM4999',9,9,'$' ; Tablet 
    item1 DB '2',9,'iPhone 16 Pro Max',9,9,'RM7999',9,9,'$' ; Mobile Phone 
    item2 DB '3',9,'iPad Air 6th Gen',9,9,'RM3899',9,9,'$' ; Tablet 
    item3 DB '4',9,'Sony Bravia XR A95L',9,9,'RM15999',9,9,'$' ; TV 
    item4 DB '5',9,'Google Pixel 9 Pro',9,9,'RM4799',9,9,'$' ; Mobile Phone 
    item5 DB '6',9,'Apple Watch Series X',9,9,'RM1899',9,9,'$' ; Mobile Phone accessory (Smartwatch) 
    item6 DB '7',9,'Samsung Soundbar Q990D',9,9,'RM3299',9,9,'$' ; TV accessory (Soundbar) 
    item7 DB '8',9,'Xiaomi Pad 7',9,9,9,'RM1699',9,9,'$' ; Tablet (Mini Tablet) 
    item8 DB '9',9,'Samsung Galaxy Z Fold 6',9,9,'RM7899',9,9,'$' ; Mobile Phone (Fold Phone)
    
    ;Items Name for display (used in Sell/Restock confirmation)
    itemn0 DB 'Samsung Galaxy Tab S9 :$'
    itemn1 DB 'iPhone 16 Pro Max :$'
    itemn2 DB 'iPad Air 6th Gen :$'
    itemn3 DB 'Sony Bravia XR A95L :$'
    itemn4 DB 'Google Pixel 9 Pro :$'
    itemn5 DB 'Apple Watch Series X :$'
    itemn6 DB 'Samsung Soundbar Q990D :$'
    itemn7 DB 'Xiaomi Pad 7 :$'
    itemn8 DB 'Samsung Galaxy Z Fold 6 :$'

    ; Items' Quantity
    q_Item0 DB 4
    q_Item1 DB 6
    q_Item2 DB 1 
    q_Item3 DB 8 
    q_Item4 DB 3 
    q_Item5 DB 7 
    q_Item6 DB 2 
    q_Item7 DB 5 
    q_Item8 DB 4 

    ; --- New for Export Feature ---
    export_filename DB 'INVENTRY.CSV',0 ; Filename for export, null-terminated
    export_header DB 'ID,Name,Price,Quantity',13,10,'$' ; CSV header line
    export_success DB 13,10,'Inventory exported to INVENTRY.CSV successfully.$'
    export_fail DB 13,10,'Error exporting inventory.$'
    
    ; Explicitly define the export message as a variable
    export_processing_msg DB 'Exporting inventory to INVENTRY.CSV...$' 
    
    file_handle DW ? ; Variable to store the file handle

    ; Separate strings for item names and prices for easier CSV export
    itemn0_export DB 'Samsung Galaxy Tab S9$'
    itemp0_export DB 'RM4999$'
    itemn1_export DB 'iPhone 16 Pro Max$'
    itemp1_export DB 'RM7999$'
    itemn2_export DB 'iPad Air 6th Gen$'
    itemp2_export DB 'RM3899$'
    itemn3_export DB 'Sony Bravia XR A95L$'
    itemp3_export DB 'RM15999$'
    itemn4_export DB 'Google Pixel 9 Pro$'
    itemp4_export DB 'RM4799$'
    itemn5_export DB 'Apple Watch Series X$'
    itemp5_export DB 'RM1899$'
    itemn6_export DB 'Samsung Soundbar Q990D$'
    itemp6_export DB 'RM3299$'
    itemn7_export DB 'Xiaomi Pad 7$'
    itemp7_export DB 'RM1699$'
    itemn8_export DB 'Samsung Galaxy Z Fold 6$'
    itemp8_export DB 'RM7899$'

    ; Tables of addresses for item names and prices for easy iteration
    item_names_table DW itemn0_export, itemn1_export, itemn2_export, itemn3_export, itemn4_export, itemn5_export, itemn6_export, itemn7_export, itemn8_export
    item_prices_table DW itemp0_export, itemp1_export, itemp2_export, itemp3_export, itemp4_export, itemp5_export, itemp6_export, itemp7_export, itemp8_export

    ; Temporary buffer for single character writes to file (Fix for Illegal indexing mode)
    temp_char_buffer DB ?, '$' 
    ; --- End New for Export Feature ---

    ; --- Authentication Variables ---
    
    ; The correct hash value (calculated by your program)
    hashed_correct_password DB 143 ; Set to 143 as determined by your testing.

    ; Username
    correct_username_str DB 'Hemanth',0 ; The correct username, null-terminated
    correct_username_len EQU ($ - correct_username_str - 1) ; Length of the actual username (7)
    username_prompt DB 13,10,'Enter Username: $'
    no_user_found_msg DB 13,10,'No user found. Exiting.$'
    username_input_buffer DB 15         ; Max characters for username
                          DB ?          ; Actual number of characters read
    entered_username DB 15 DUP (?) ; Buffer to store the entered username string

    ; Password
    correct_password_str DB 'Hemanth1234',0 ; The actual password, null-terminated (for reference, not used in hash)
    correct_password_len EQU ($ - correct_password_str - 1) ; Length of the actual password (11)
    password_prompt DB 13,10,'Password for Hemanth''s Techhub Inventory System : $'
    incorrect_password_msg DB 13,10,'Incorrect Password. Exiting.$'

    password_input_buffer DB 15         ; Max characters for password
                          DB ?          ; Actual number of characters read
    entered_password DB 15 DUP (?) ; Buffer to store the entered password string (will be null-terminated)

    ; --- Debugging Variables ---
    debug_al_before_cmp_label DB 13,10,'Calculated Hash: $'
    debug_num_buffer DB 5 DUP(?), '$' ; Buffer for converting byte to ASCII (e.g., "243")
    ; --- End Debugging Variables ---
    
.code

;Display Messages
DisplayMsg Macro Msg
    lea  dx, Msg      ; load message address
    mov  ah, 09h       ; function to display string
    int  21h          ; call DOS
EndM

;Display Items and Quantity
DisplayQty Macro Qty, Color
    LOCAL LessThanFiveQty, DisplayNormal, EndQty

    mov dl, Qty
    cmp dl, 5          ; Compare the quantity with 5
    jl LessThanFiveQty ; Jump to LessThanFiveQty if quantity is less than 5
    jge DisplayNormal

    DisplayNormal:
        ; Display the quantity normally (non-blinking)
        mov dl, Qty    ; Move the quantity back to DL
        add dl, '0'    ; Convert numerical value to ASCII character
        mov ah, 02h    ; Display character using DOS INT 21h (doesn't support blinking color)
        int 21h        ; Call DOS
        jmp EndQty     ; Jump to the end of the macro

    LessThanFiveQty:
        ; Display the quantity in red color with blinking attribute
        mov al, Qty    ; Move the quantity to AL
        add al, '0'    ; Convert numerical value to character
        mov ah, 09h    ; Display character using BIOS INT 10h (supports color attributes)
        mov bh, 0      ; Page number (0 for current page)
        
        ; Calculate the blinking attribute: Color (e.g., 4 for red) OR'd with 80h for blinking
        mov bl, Color  ; Load original color (e.g., 4 for red)
        or bl, 80h     ; Set the blinking bit (bit 7)
        
        mov cx, 1      ; Set to print only 1 char
        int 10h        ; Call BIOS
        jmp EndQty

    EndQty:
EndM

; Selling an item
SellItem MACRO item,quantityitem
    LOCAL CantSell
    DisplayMsg SellQuantity
    mov ah, 01h
    int 21h

    sub al, '0'
    cmp [quantityitem],al ; FIX: Dereference quantityitem
    jl CantSell ; if input > quantity, cant sell

    sub [quantityitem], al ; FIX: Dereference quantityitem ; Subtract the quantity from the corresponding item

    ;Display the remaing quantity
    DisplayMsg CRLF
    DisplayMsg Remain_Qty
    DisplayMsg item
    mov dl, [quantityitem] ; FIX: Dereference quantityitem
    DisplayQty dl, 4

    DisplayMsg CRLF
    call ReturnToMenu
    jmp sell_items ; Ensure a jump back after macro, so it always returns to sell selection.

CantSell:
    DisplayMsg CRLF
    DisplayMsg CannotSell
    DisplayMsg CRLF
    call ReturnToMenu
    jmp sell_items ; Ensure a jump back after macro, so it always returns to sell selection.
ENDM

;Restocking an item (Reverted to previous, problematic version based on user's input)
RestockItem MACRO item_name_msg, quantity_var_address
    LOCAL CheckQuantity, RestockContinue, RestockExitMacro

    DisplayMsg RestockQuantity
    mov ah, 01h
    int 21h

    sub al, '0' ; AL now holds the numerical quantity to restock (e.g., 2)

    ; Get current quantity VALUE and calculate potential new quantity
    mov bl, [quantity_var_address] ; FIX: Load current quantity VALUE from memory into BL
    add bl, al                     ; Add input quantity (AL) to current quantity (BL) -> sum in BL

    cmp bl, 9                      ; Compare the potential new quantity (in BL) with max stock (9)
    jg CheckQuantity               ; If sum > 9, jump to error message

    ; If not exceeding max stock, update the quantity
    mov [quantity_var_address], bl ; FIX: Store the new sum (in BL) back into memory

RestockContinue: ; Label for normal flow after quantity update
    DisplayMsg CRLF
    DisplayMsg Remain_Qty
    DisplayMsg item_name_msg ; Use the item's name string for display
    mov dl, [quantity_var_address] ; FIX: Display the UPDATED quantity VALUE from memory
    DisplayQty dl, 4

    DisplayMsg CRLF
    call ReturnToMenu ; This will wait for Enter and then return to the point after the macro call.
    jmp RestockExitMacro ; Jump to end of macro to bypass error path

CheckQuantity: ; Label for exceeding max stock
    DisplayMsg CRLF
    DisplayMsg MaximumStock
    DisplayMsg CRLF
    call ReturnToMenu ; This will wait for Enter and then return to the point after the macro call.

RestockExitMacro: ; End of macro's internal flow, allows control to pass back
ENDM

;Main Function
MAIN PROC
    mov ax, @Data     ; Set data segment
    mov ds, ax        ; Data register

    ; --- Username Protection Start ---
    call clear_screen
    DisplayMsg username_prompt

    ; Read username using buffered input (INT 21h, AH=0Ah)
    mov ah, 0Ah           ; Function: Buffered input
    lea dx, username_input_buffer ; DX points to the buffer structure
    int 21h               ; Call DOS

    ; Get the actual length of the entered username
    mov bl, [username_input_buffer + 1] ; Actual length (excluding CR/LF) into BL
    mov bh, 0 ; Clear BH (makes BX = length for CX later)

    ; Copy the entered username from the input buffer to our 'entered_username' variable
    mov si, offset username_input_buffer + 2 ; Source: actual entered characters
    mov di, offset entered_username       ; Destination: our dedicated buffer
    mov cx, bx ; CX = actual length for REP MOVSB

    rep movsb ; Copy string byte by byte

    ; Add null terminator to the copied entered_username string
    mov byte ptr [di], 0 ; DI is already at the end of the copied string

    ; Compare entered username with correct_username_str
    ; First, compare lengths
    mov cl, correct_username_len ; Length of correct username (into CL)
    cmp bl, cl               ; Compare lengths (BL vs CL)
    jne incorrect_username_exit ; If lengths don't match, it's incorrect

    ; If lengths match, compare content byte by byte
    mov si, offset correct_username_str ; Source: correct username string
    mov di, offset entered_username   ; Destination: entered username string
    mov cx, bx                        ; CX = length for comparison (restore actual length into CX)
    repe cmpsb                      ; Compare strings (repeating while bytes are equal)
    jne incorrect_username_exit     ; If not equal (ZF=0), username is incorrect

    ; Username is correct, proceed to password check
    jmp username_correct

incorrect_username_exit:
    DisplayMsg CRLF
    DisplayMsg no_user_found_msg
    call exit_main ; Exit program
    ; --- Username Protection End ---

username_correct:
    call clear_screen
    DisplayMsg password_prompt

    ; Use DI as the current pointer for entered_password
    mov di, offset entered_password
    xor cx, cx           ; CX will count password length

read_password_loop:
    mov ah, 08h          ; Read char without echo
    int 21h
    cmp al, 13           ; Check for Enter key (Carriage Return)
    je password_done

    mov [di], al         ; Store character
    inc di               ; Move to next byte in buffer
    inc cx               ; Increment password length

    ; Print asterisk for masked input
    mov dl, '*'
    mov ah, 02h
    int 21h

    jmp read_password_loop

password_done:
    mov byte ptr [di], 0     ; Null-terminate entered_password

    call hash_password       ; Calculated hash is in AL. Should be 143.
    
    ; --- DEBUG PRINT THE VALUE DIRECTLY FROM AL ---
    push ax                 ; Save AX before potentially clobbering it for printing
    push cx
    push dx
    push si
    
    ; Print label
    lea dx, debug_al_before_cmp_label
    mov ah, 09h
    int 21h

    ; Convert AL to ASCII and print
    ; IMPORTANT: AL will be modified by the division.
    xor ch, ch ; Clear CH for a clean CX
    mov cl, al ; Copy hash from AL to CL for conversion (so AL can be restored later)
    mov si, offset debug_num_buffer + 4 ; Point to end of buffer
    mov byte ptr [si], '$' ; Null terminate
    dec si ; Move pointer back for first digit

    ; Handle 0 separately
    cmp cl, 0
    jne not_zero_hash_print_direct
    mov byte ptr [si], '0'
    jmp print_converted_hash_direct

not_zero_hash_print_direct:
    mov bh, 10 ; Divisor for conversion

convert_byte_to_ascii_loop_direct:
    xor ax, ax      ; Clear AX (AH=0, AL=value)
    mov al, cl      ; Move current number to AL for division
    div bh          ; AL = quotient, AH = remainder
    add ah, '0'     ; Convert remainder to ASCII
    mov [si], ah    ; Store digit
    dec si          ; Move to next position
    mov cl, al      ; Quotient becomes new number for next iteration
    cmp cl, 0       ; Loop until quotient is 0
    jnz convert_byte_to_ascii_loop_direct

print_converted_hash_direct:
    lea dx, [si + 1] ; Point DX to the start of the ASCII number string
    mov ah, 09h
    int 21h
    DisplayMsg CRLF ; New line

    pop si                  ; Restore registers
    pop dx
    pop cx
    pop ax                  ; Restore AX (and thus AL) to its value before the print routine
                            ; This means AL should contain the hash value (143) after this pop.
    ; --- END DEBUG PRINT ---

    ; Now, AL *should* hold 143. Let's compare it.
    cmp al, hashed_correct_password ; Compare calculated hash (now in AL) with stored hash
    jne incorrect_password_exit     ; If not equal, password is incorrect

    jmp main_loop ; Password correct, proceed to main menu

incorrect_password_exit:
    DisplayMsg CRLF
    DisplayMsg incorrect_password_msg
    call exit_main ; Exit program
    ; --- Password Protection End ---

    main_loop:

    call display_menu
    mov ah, 01h       ; Read user character input
    int 21h
    
    ; Compare user_input and direct to selected option
    cmp al,'1'
    je inventory_menu
    cmp al, '2'
    je category_menu
    cmp al, '3'
    je sell_items
    cmp al,'4'
    je restock_items
    cmp al, '5'
    je export_inventory
    cmp al, '6' 
    je exit_confirmed

    ;Invalid Input
    DisplayMsg CRLF
    DisplayMsg InvalidMsg
    DisplayMsg CRLF
    jmp main_loop

    
;Loops
;Display Main Menu and UserInput String
display_menu:
    call clear_screen ; Clear screen before displaying menu
    DisplayMsg Mheader
    DisplayMsg user_input
    ret

;Option 2: View Inventory
inventory_menu:
    call view_inventory
    call ReturnToMenu
    jmp main_loop

view_inventory:
    call clear_screen ; Clear screen before displaying inventory
    DisplayMsg INVTheader

    ; Display All Items
    DisplayMsg item0
    DisplayQty q_Item0, 4
    DisplayMsg CRLF
    
    DisplayMsg item1 
    DisplayQty q_Item1, 4
    DisplayMsg CRLF

    DisplayMsg item2
    DisplayQty q_Item2, 4
    DisplayMsg CRLF
    
    DisplayMsg item3
    DisplayQty q_Item3, 4
    DisplayMsg CRLF
    
    DisplayMsg item4
    DisplayQty q_Item4, 4
    DisplayMsg CRLF

    DisplayMsg item5
    DisplayQty q_Item5, 4
    DisplayMsg CRLF

    DisplayMsg item6
    DisplayQty q_Item6, 4
    DisplayMsg CRLF

    DisplayMsg item7
    DisplayQty q_Item7, 4
    DisplayMsg CRLF

    DisplayMsg item8
    DisplayQty q_Item8, 4
    DisplayMsg CRLF
    ret

;Sell Menu
sell_items:

    DisplayMsg CRLF
    call view_inventory

    ; Read user's input for item selection
    DisplayMsg SellOption
    mov ah, 01h       ; Read user character input
    int 21h
    cmp al,'1'
    je sellitem0
    cmp al, '2'
    je sellitem1
    cmp al, '3'
    je sellitem2
    cmp al, '4'
    je sellitem3
    cmp al, '5'
    je sellitem4
    cmp al, '6' 
    je sellitem5
    cmp al, '7' 
    je sellitem6
    cmp al, '8' 
    je sellitem7
    cmp al, '9' 
    je sellitem8
    cmp al,'e'
    je main_loop
    cmp al,'E'
    je main_loop

    ;Invalid Input
    DisplayMsg CRLF
    DisplayMsg InvalidMsg
    DisplayMsg CRLF
    jmp sell_items

sellitem0:
    DisplayMsg CRLF
    SellItem itemn0,q_Item0
    jmp sell_items ; This jump is correct, sends back to sell selection.
sellitem1:
    DisplayMsg CRLF
    SellItem itemn1,q_Item1
    jmp sell_items ; This jump is correct, sends back to sell selection.
sellitem2:
    DisplayMsg CRLF
    SellItem itemn2,q_Item2
    jmp sell_items ; This jump is correct, sends back to sell selection.
sellitem3:
    DisplayMsg CRLF
    SellItem itemn3,q_Item3
    jmp sell_items ; This jump is correct, sends back to sell selection.
sellitem4:
    DisplayMsg CRLF
    SellItem itemn4,q_Item4
    jmp sell_items ; This jump is correct, sends back to sell selection.
sellitem5: ; New item sell handler
    DisplayMsg CRLF
    SellItem itemn5,q_Item5
    jmp sell_items ; This jump is correct, sends back to sell selection.
sellitem6:
    DisplayMsg CRLF
    SellItem itemn6,q_Item6
    jmp sell_items ; This jump is correct, sends back to sell selection.
sellitem7:
    DisplayMsg CRLF
    SellItem itemn7,q_Item7
    jmp sell_items ; This jump is correct, sends back to sell selection.
sellitem8:
    DisplayMsg CRLF
    SellItem itemn8,q_Item8
    jmp sell_items ; This jump is correct, sends back to sell selection.
    
;Restock Menu
restock_items:
    DisplayMsg CRLF
    call view_inventory

    ; Read user's input for item selection
    DisplayMsg RestockOption
    mov ah, 01h  
    int 21h
    cmp al,'1'
    je restock0
    cmp al,'2'
    je restock1
    cmp al,'3'
    je restock2
    cmp al,'4'
    je restock3
    cmp al,'5'
    je restock4
    cmp al,'6' 
    je restock5
    cmp al,'7'
    je restock6
    cmp al,'8'
    je restock7
    cmp al,'9'
    je restock8
    cmp al,'e'
    je main_loop
    cmp al,'E'
    je main_loop

    ;Invalid Input
    DisplayMsg CRLF
    DisplayMsg InvalidMsg
    DisplayMsg CRLF
    jmp restock_items

restock0:
    DisplayMsg CRLF
    RestockItem itemn0,q_Item0
    jmp restock_items ; This jump is correct, sends back to restock selection.
restock1:
    DisplayMsg CRLF
    RestockItem itemn1,q_Item1
    jmp restock_items ; This jump is correct, sends back to restock selection.
restock2:
    DisplayMsg CRLF
    RestockItem itemn2,q_Item2
    jmp restock_items ; This jump is correct, sends back to restock selection.
restock3:
    DisplayMsg CRLF
    RestockItem itemn3,q_Item3
    jmp restock_items ; This jump is correct, sends back to restock selection.
restock4:
    DisplayMsg CRLF
    RestockItem itemn4,q_Item4
    jmp restock_items ; This jump is correct, sends back to restock selection.
restock5: ; New item restock handler
    DisplayMsg CRLF
    RestockItem itemn5,q_Item5
    jmp restock_items ; This jump is correct, sends back to restock selection.
restock6:
    DisplayMsg CRLF
    RestockItem itemn6,q_Item6
    jmp restock_items ; This jump is correct, sends back to restock selection.
restock7:
    DisplayMsg CRLF
    RestockItem itemn7,q_Item7
    jmp restock_items ; This jump is correct, sends back to restock selection.
restock8:
    DisplayMsg CRLF
    RestockItem itemn8,q_Item8
    jmp restock_items ; This jump is correct, sends back to restock selection.
    
;Sort By Category Menu
category_menu:
    call clear_screen ; Clear screen before displaying category menu
    DisplayMsg CatHeader
    DisplayMsg CatOption
    mov ah,01h
    int 21h
    cmp al,'1'
    je tablets
    cmp al,'2'
    je phones
    cmp al,'3'
    je tvs 
    cmp al,'4'
    je main_loop

    ;Invalid Input
    DisplayMsg CRLF
    DisplayMsg InvalidMsg
    DisplayMsg CRLF
    jmp category_menu

tablets:
    call clear_screen ; Clear screen before displaying tablets
    DisplayMsg TabletHeader
    DisplayMsg CRLF
    DisplayMsg item0
    DisplayQty q_Item0, 4
    DisplayMsg CRLF

    DisplayMsg item2
    DisplayQty q_Item2, 4
    DisplayMsg CRLF

    DisplayMsg item7 ; New tablet
    DisplayQty q_Item7, 4
    DisplayMsg CRLF
    call ReturnToMenu
    jmp category_menu

phones:
    call clear_screen ; Clear screen before displaying phones
    DisplayMsg PhoneHeader
    DisplayMsg CRLF
    DisplayMsg item1
    DisplayQty q_Item1, 4
    DisplayMsg CRLF

    DisplayMsg item4
    DisplayQty q_Item4, 4
    DisplayMsg CRLF

    DisplayMsg item5 ; New mobile phone accessory (smartwatch)
    DisplayQty q_Item5, 4
    DisplayMsg CRLF

    DisplayMsg item8 ; New mobile phone
    DisplayQty q_Item8, 4
    DisplayMsg CRLF
    call ReturnToMenu
    jmp category_menu

tvs:
    call clear_screen ; Clear screen before displaying TVs
    DisplayMsg TVHeader
    DisplayMsg CRLF
    DisplayMsg item3
    DisplayQty q_Item3, 4
    DisplayMsg CRLF

    DisplayMsg item6 ; New TV accessory (soundbar)
    DisplayQty q_Item6, 4
    DisplayMsg CRLF
    call ReturnToMenu
    jmp category_menu

; --- New Export Inventory Procedure ---
export_inventory PROC
    call clear_screen
    DisplayMsg CRLF
    DisplayMsg export_processing_msg 
    DisplayMsg CRLF

    ; Create file (INT 21h, AH=3Ch)
    mov ah, 3Ch
    xor cx, cx ; Normal file attributes
    lea dx, export_filename ; Address of filename
    int 21h
    jc  export_error_exit_handling ; If CF is set, error creating file (e.g., disk full, invalid path)

    mov [file_handle], ax ; Save returned file handle in AX

    ; Write header to file (INT 21h, AH=40h)
    mov bx, [file_handle] ; File handle in BX
    lea dx, export_header ; Address of header string
    mov cx, 23 ; Length of 'ID,Name,Price,Quantity\r\n'
    mov ah, 40h ; Write to file
    int 21h
    jc  export_error_exit_handling ; Check for write error

    ; Loop through each item (0 to 8) to write its data
    mov si, 0   ; Loop counter/index (0-based) for both byte and word tables
    mov cx, 9   ; Number of items to process

    export_loop:
        ; Get item ID (loop index + 1) and write
        mov ax, si      ; Copy SI (16-bit) to AX (16-bit). AL now holds the lower byte of SI.
        add al, '1'     ; Convert 0-8 to '1'-'9' ASCII
        call write_char_to_file_internal ; Helper to write char to file handle

        ; Write comma
        mov al, ','
        call write_char_to_file_internal

        ; Get item Name from item_names_table and write
        push si         ; Save SI (loop counter)
        mov di, si      ; Copy loop counter to DI
        shl di, 1       ; Scale DI by 2 (for word array: 0, 2, 4...)
        
        lea bx, item_names_table ; BX gets the base address of the table
        mov dx, WORD PTR [bx + di] ; Get the WORD (address) from item_names_table[bx+di] into DX
        pop si          ; Restore SI
        call write_string_to_file_internal

        ; Write comma
        mov al, ','
        call write_char_to_file_internal

        ; Get item Price from item_prices_table and write
        push si         ; Save SI (loop counter)
        mov di, si      ; Copy loop counter to DI
        shl di, 1       ; Scale DI by 2
        
        lea bx, item_prices_table ; BX gets the base address of the table
        mov dx, WORD PTR [bx + di] ; Get the WORD (address) from item_prices_table[bx+di] into DX
        pop si          ; Restore SI
        call write_string_to_file_internal

        ; Write comma
        mov al, ','
        call write_char_to_file_internal

        ; Get quantity from q_ItemX (direct access using si index) and write
        mov bl, [q_Item0 + si] ; q_Item0 is a byte array, si is 0, 1, ..., 8. This is correct.
        call write_byte_as_ascii_to_file_internal ; Helper to convert byte to ASCII and write

        ; Write CRLF
        mov al, 13 ; Carriage Return
        call write_char_to_file_internal
        mov al, 10 ; Line Feed
        call write_char_to_file_internal

        inc si ; Move to next item index (0-8)
        loop export_loop ; Decrement CX and loop if CX > 0

    ; Close file (INT 21h, AH=3Eh)
    mov bx, [file_handle]
    mov ah, 3Eh
    int 21h
    jc  export_error_exit_handling ; Check for close error (unlikely)

    ; Success path: Display message and return to menu
    DisplayMsg export_success ; Display success message
    call ReturnToMenu         ; Call ReturnToMenu as requested
    jmp main_loop             ; Jump directly to the main menu loop

export_error_exit_handling: ; Combined error handling for create, write, close
    ; Attempt to close file if handle exists and an error occurred during creation/write
    mov bx, [file_handle]
    cmp bx, 0 ; Check if file_handle was successfully obtained (0 means invalid or not yet opened)
    je skip_close_on_error ; If not, skip closing
    mov ah, 3Eh ; Close file
    int 21h
    skip_close_on_error:
    DisplayMsg export_fail ; Display generic failure message
    
    ; On error, also return to menu
    call ReturnToMenu
    jmp main_loop             ; Jump directly to the main menu loop
    
export_inventory ENDP

; Internal helper for writing a single character to the currently open file handle
; AL should contain the character to write
write_char_to_file_internal PROC
    push ax
    push bx
    push cx
    push dx
    ; AL already contains the character to write

    mov [temp_char_buffer], al ; Store AL into the temporary buffer

    mov bx, [file_handle]      ; Get the file handle
    mov ah, 40h                ; Write to file
    mov cx, 1                  ; Write 1 byte
    lea dx, temp_char_buffer   ; DX points to the temporary buffer
    int 21h
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
write_char_to_file_internal ENDP

; Internal helper for writing a '$' terminated string to the currently open file handle
; DX should already contain the string address
write_string_to_file_internal PROC
    push ax
    push bx
    push cx
    push dx
    push si ; Preserve SI

    mov bx, [file_handle] ; Get the file handle
    ; Calculate string length
    mov si, dx ; Copy string address to SI for length calculation
    xor cx, cx ; Counter for length
    string_length_loop:
        cmp byte ptr [si], '$' ; Check for '$' terminator
        je end_string_length
        inc cx ; Increment length
        inc si ; Move to next character
        jmp string_length_loop
    end_string_length:

    mov ah, 40h ; Write to file
    ; DX already holds the string pointer (original input DX)
    int 21h ; Call DOS

    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
write_string_to_file_internal ENDP

; Internal helper to convert a byte to ASCII string and write to file
; BL should contain the byte (0-9)
write_byte_as_ascii_to_file_internal PROC
    push ax
    push bx
    push cx
    push dx

    ; Handle single digit conversion easily (quantity is 0-9)
    xor ah, ah      ; Clear AH for division
    mov al, bl      ; Byte to AL (e.g., 4)
    mov cl, 10      ; Divisor (for converting to digits)
    div cl          ; AL = quotient, AH = remainder (units digit)

    ; If quotient is not zero, write it (tens digit)
    cmp al, 0
    je skip_tens_digit
    add al, '0'     ; Convert quotient to ASCII
    call write_char_to_file_internal
skip_tens_digit:
    ; Write remainder (units digit)
    mov al, ah      ; Remainder in AL
    add al, '0'     ; Convert to ASCII
    call write_char_to_file_internal

    pop dx
    pop cx
    pop bx
    pop ax
    ret
write_byte_as_ascii_to_file_internal ENDP


;Confirmation for Exit
exit_confirmed:
    
    DisplayMsg Exit
    mov ah,01h
    int 21h

    cmp al,'n'
    je main_loop

    cmp al,'y'
    call clear_screen
    DisplayMsg TyMsg
    je exit_main

;Prompt User to enter Menu
ReturnToMenu:
    DisplayMsg EnterRet
    mov ah, 01h       ; Read user character input
    int 21h
    ;Check if the Enter key pressed
    cmp al, 0Dh 
    ;If not, prompt again
    jne ReturnToMenu 
    
    ;If yes, return to the main loop
    ret

;Clear Screen
clear_screen:
    mov ah, 06h
    mov al, 0
    mov bh, 07h
    mov cx, 0
    mov dx, 184Fh
    int 10h
    ret
    
; --- Simple Hash Subroutine ---
; Input: entered_password (null-terminated string in 'entered_password' buffer)
; Output: AL = hash value (sum of ASCII % 256)

hash_password:
    push cx ; Save CX
    push si ; Save SI
    push bx ; Save BX 

    xor al, al           ; Clear AL (accumulator for sum)
    mov si, offset entered_password ; SI points to the start of the entered password string

hash_loop:
    mov bl, [si]         ; Read character into BL
    cmp bl, 0            ; Check for null terminator
    je hash_done_calc    ; If null, finish hashing

    add al, bl           ; Add character's ASCII value to AL (sum will be in AL, automatically mod 256 if it overflows)
    inc si               ; Move to next character
    jmp hash_loop

hash_done_calc:
    ; The sum is already in AL, and due to 8-bit addition, it's effectively (sum % 256).
    ; No explicit modulo 256 is needed as AL handles the overflow naturally.
    
    pop bx ; Restore BX
    pop si ; Restore SI
    pop cx ; Restore CX
    ; Do NOT pop AX here, as AL contains your result and needs to be preserved for the caller.
    ret

;End Program
exit_main:
    mov ah,4Ch
    int 21h

MAIN ENDP
END MAIN