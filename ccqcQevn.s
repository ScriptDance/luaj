	.arch armv5te
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 4
	.eabi_attribute 18, 4
	.code	16
	.file	"xml.c"
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.section	.text.Tokenizer_append,"ax",%progbits
	.align	1
	.code	16
	.thumb_func
	.type	Tokenizer_append, %function
Tokenizer_append:
	.fnstart
.LFB37:
	.file 1 "jni/xml/xml.c"
	.loc 1 117 0
	.cfi_startproc
	.save	{r3, r4, r5, lr}
	push	{r3, r4, r5, lr}
.LCFI0:
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	.cfi_offset 4, -12
	.cfi_offset 5, -8
	.cfi_offset 14, -4
.LVL0:
	.loc 1 118 0
	ldr	r2, [r0, #28]
	ldr	r3, [r0, #32]
	.loc 1 117 0
	mov	r4, r0
	.loc 1 118 0
	add	r2, r2, #1
	.loc 1 117 0
	mov	r5, r1
	.loc 1 118 0
	cmp	r2, r3
	bcc	.L2
	.loc 1 119 0 discriminator 2
	mov	r1, #16
.LVL1:
	.loc 1 119 0 is_stmt 0
	cmp	r3, #0
	beq	.L3
	.loc 1 119 0 discriminator 1
	lsl	r1, r3, #1
.L3:
	.loc 1 119 0 discriminator 3
	str	r1, [r4, #32]
	.loc 1 120 0 is_stmt 1
	ldr	r0, [r4, #24]
.LVL2:
	bl	realloc
	str	r0, [r4, #24]
.L2:
	.loc 1 122 0
	ldr	r3, [r4, #28]
	ldr	r2, [r4, #24]
	.loc 1 123 0
	mov	r1, #0
	.loc 1 124 0
	@ sp needed for prologue
	.loc 1 122 0
	strb	r5, [r2, r3]
	.loc 1 123 0
	ldr	r3, [r4, #28]
	ldr	r2, [r4, #24]
	add	r3, r3, #1
	str	r3, [r4, #28]
	strb	r1, [r2, r3]
.LVL3:
	.loc 1 124 0
	pop	{r3, r4, r5, pc}
	.cfi_endproc
.LFE37:
	.fnend
	.size	Tokenizer_append, .-Tokenizer_append
	.section	.text.Xml_registerCode,"ax",%progbits
	.align	1
	.global	Xml_registerCode
	.code	16
	.thumb_func
	.type	Xml_registerCode, %function
Xml_registerCode:
	.fnstart
.LFB42:
	.loc 1 362 0
	.cfi_startproc
	.save	{r0, r1, r2, r4, r5, r6, r7, lr}
	push	{r0, r1, r2, r4, r5, r6, r7, lr}
.LCFI1:
	.cfi_def_cfa_offset 32
	.cfi_offset 0, -32
	.cfi_offset 1, -28
	.cfi_offset 2, -24
	.cfi_offset 4, -20
	.cfi_offset 5, -16
	.cfi_offset 6, -12
	.cfi_offset 7, -8
	.cfi_offset 14, -4
.LVL4:
	.loc 1 363 0
	mov	r1, #1
	mov	r2, #0
	.loc 1 362 0
	mov	r7, r0
	.loc 1 363 0
	bl	luaL_checklstring
.LVL5:
	.loc 1 364 0
	mov	r1, #2
	.loc 1 363 0
	str	r0, [sp]
.LVL6:
	.loc 1 364 0
	mov	r2, #0
	mov	r0, r7
.LVL7:
	bl	luaL_checklstring
	.loc 1 367 0 discriminator 1
	ldr	r4, .L11
	.loc 1 364 0
	str	r0, [sp, #4]
.LVL8:
	.loc 1 367 0
	mov	r5, #0
	.loc 1 367 0 is_stmt 0 discriminator 1
.LPIC2:
	add	r4, pc
	.loc 1 367 0
	b	.L6
.LVL9:
.L9:
	.loc 1 368 0 is_stmt 1
	ldr	r3, [r4]
	lsl	r2, r5, #2
	ldr	r1, [sp]
	ldr	r0, [r2, r3]
	bl	strcmp
	cmp	r0, #0
	bne	.L7
	.loc 1 369 0
	ldr	r1, .L11+4
	mov	r0, r7
.LPIC1:
	add	r1, pc
	bl	luaL_error
	b	.L8
.L7:
	.loc 1 367 0
	add	r5, r5, #2
.LVL10:
.L6:
	.loc 1 367 0 is_stmt 0 discriminator 1
	ldr	r6, [r4, #4]
	cmp	r5, r6
	bcc	.L9
	.loc 1 370 0 is_stmt 1
	ldr	r3, .L11+8
	add	r7, r6, #2
.LVL11:
.LPIC3:
	add	r3, pc
	ldr	r1, [r3]
	cmp	r7, r1
	bls	.L10
	.loc 1 371 0
	lsl	r2, r1, #1
	str	r2, [r3]
	.loc 1 372 0
	ldr	r0, [r4]
	lsl	r1, r1, #3
	bl	realloc
	str	r0, [r4]
.L10:
	.loc 1 374 0
	ldr	r0, [sp]
	bl	strlen
	ldr	r4, .L11+12
	add	r0, r0, #1
.LPIC7:
	add	r4, pc
	ldr	r5, [r4]
.LVL12:
	bl	malloc
	lsl	r3, r6, #2
	str	r0, [r3, r5]
	.loc 1 375 0
	ldr	r1, [sp]
	bl	strcpy
	.loc 1 376 0
	ldr	r0, [sp, #4]
	bl	strlen
	add	r0, r0, #1
	bl	malloc
	add	r6, r6, #1
	lsl	r6, r6, #2
	str	r0, [r6, r5]
	.loc 1 377 0
	str	r7, [r4, #4]
	ldr	r1, [sp, #4]
	bl	strcpy
	.loc 1 378 0
	mov	r0, #0
.L8:
	.loc 1 379 0
	@ sp needed for prologue
	pop	{r1, r2, r3, r4, r5, r6, r7, pc}
.L12:
	.align	2
.L11:
	.word	.LANCHOR0-(.LPIC2+4)
	.word	.LC0-(.LPIC1+4)
	.word	.LANCHOR1-(.LPIC3+4)
	.word	.LANCHOR0-(.LPIC7+4)
	.cfi_endproc
.LFE42:
	.fnend
	.size	Xml_registerCode, .-Xml_registerCode
	.section	.text.find,"ax",%progbits
	.align	1
	.code	16
	.thumb_func
	.type	find, %function
find:
	.fnstart
.LFB33:
	.loc 1 63 0
	.cfi_startproc
	.save	{r4, lr}
	push	{r4, lr}
.LCFI2:
	.cfi_def_cfa_offset 8
	.cfi_offset 4, -8
	.cfi_offset 14, -4
.LVL13:
	.loc 1 63 0
	mov	r4, r0
	.loc 1 64 0
	add	r0, r0, r2
.LVL14:
	bl	strstr
.LVL15:
	.loc 1 65 0
	cmp	r0, #0
	beq	.L14
	.loc 1 65 0 is_stmt 0 discriminator 1
	sub	r0, r0, r4
.LVL16:
	b	.L15
.LVL17:
.L14:
	.loc 1 65 0 discriminator 2
	mov	r0, r4
.LVL18:
	bl	strlen
.L15:
	.loc 1 66 0 is_stmt 1
	@ sp needed for prologue
.LVL19:
	pop	{r4, pc}
	.cfi_endproc
.LFE33:
	.fnend
	.size	find, .-find
	.section	.text.Xml_pushDecode,"ax",%progbits
	.align	1
	.code	16
	.thumb_func
	.type	Xml_pushDecode, %function
Xml_pushDecode:
	.fnstart
.LFB39:
	.loc 1 243 0
	.cfi_startproc
	.save	{r4, r5, r6, r7, lr}
	push	{r4, r5, r6, r7, lr}
.LCFI3:
	.cfi_def_cfa_offset 20
	.cfi_offset 4, -20
	.cfi_offset 5, -16
	.cfi_offset 6, -12
	.cfi_offset 7, -8
	.cfi_offset 14, -4
.LVL20:
	ldr	r3, .L37
	ldr	r4, .L37+4
	mov	r6, r1
.LPIC15:
	add	r3, pc
	ldr	r3, [r3]
	.pad #8236
	add	sp, sp, r4
.LCFI4:
	.cfi_def_cfa_offset 8256
	.loc 1 243 0
	ldr	r1, .L37+8
.LVL21:
	str	r2, [sp]
	ldr	r2, [r3]
.LVL22:
	add	r1, r1, sp
	str	r0, [sp, #8]
	str	r2, [r1]
.LVL23:
	.loc 1 245 0
	ldr	r2, [sp]
	str	r3, [sp, #12]
	cmp	r2, #0
	bne	.L17
	.loc 1 245 0 is_stmt 0 discriminator 1
	mov	r0, r6
.LVL24:
	bl	strlen
	str	r0, [sp]
.LVL25:
.L17:
	.loc 1 247 0 is_stmt 1
	ldr	r0, [sp, #8]
	add	r1, sp, #20
	bl	luaL_buffinit
	.loc 1 248 0
	ldr	r1, .L37+12
	mov	r0, r6
.LPIC10:
	add	r1, pc
	bl	strstr
	.loc 1 249 0
	ldr	r5, [sp]
	.loc 1 248 0
	mov	r4, r0
.LVL26:
	.loc 1 249 0
	cmp	r0, #0
	beq	.L18
	.loc 1 250 0
	sub	r5, r0, r6
.LVL27:
.L18:
	.loc 1 255 0
	ldr	r3, .L37+16
	.loc 1 256 0
	mov	r7, #0
	.loc 1 255 0
.LPIC11:
	add	r3, pc
	str	r3, [sp, #4]
	b	.L31
.LVL28:
.L24:
	.loc 1 252 0
	cmp	r5, r7
	bls	.L20
	.loc 1 252 0 is_stmt 0 discriminator 1
	add	r1, r6, r7
	sub	r2, r5, r7
	add	r0, sp, #20
	bl	luaL_addlstring
.L20:
	.loc 1 253 0 is_stmt 1
	ldr	r2, [sp, #28]
	ldr	r3, [sp, #24]
	cmp	r2, r3
	bcc	.L21
	.loc 1 253 0 is_stmt 0 discriminator 2
	add	r0, sp, #20
	mov	r1, #1
	bl	luaL_prepbuffsize
.L21:
	.loc 1 253 0 discriminator 4
	add	r3, r6, r5
	ldrb	r0, [r3, #2]
	mov	r7, #100
.LVL29:
	ldrb	r1, [r3, #4]
	mul	r0, r7
	ldrb	r3, [r3, #3]
	add	r1, r1, #48
	add	r1, r1, r0
	mov	r0, #10
	mul	r3, r0
	ldr	r2, [sp, #28]
	ldr	r7, [sp, #20]
	add	r1, r1, r3
	.loc 1 255 0 is_stmt 1
	add	r0, r4, #6
	.loc 1 253 0 discriminator 4
	strb	r1, [r7, r2]
	add	r2, r2, #1
	.loc 1 255 0
	ldr	r1, [sp, #4]
	.loc 1 253 0 discriminator 4
	str	r2, [sp, #28]
	.loc 1 255 0
	bl	strstr
	.loc 1 254 0
	add	r7, r5, #6
.LVL30:
	.loc 1 256 0
	sub	r4, r0, #0
.LVL31:
	beq	.L30
	.loc 1 257 0
	sub	r5, r4, r6
.LVL32:
	b	.L31
.LVL33:
.L30:
	.loc 1 256 0
	ldr	r5, [sp]
	b	.L23
.LVL34:
.L31:
	.loc 1 251 0 discriminator 1
	cmp	r4, #0
	beq	.L23
	.loc 1 251 0 is_stmt 0 discriminator 2
	ldr	r1, [sp]
	add	r3, r5, #5
	cmp	r3, r1
	bcs	.L23
	.loc 1 251 0 discriminator 3
	ldrb	r3, [r4, #5]
	cmp	r3, #59
	bne	.L23
	.loc 1 251 0 discriminator 4
	ldrb	r3, [r4, #2]
	sub	r3, r3, #48
	cmp	r3, #9
	bhi	.L23
	.loc 1 251 0 discriminator 5
	ldrb	r3, [r4, #3]
	sub	r3, r3, #48
	cmp	r3, #9
	bhi	.L23
	.loc 1 251 0 discriminator 6
	ldrb	r3, [r4, #4]
	sub	r3, r3, #48
	cmp	r3, #9
	bls	.L24
.LVL35:
.L23:
	.loc 1 259 0 is_stmt 1
	cmp	r5, r7
	bls	.L25
	.loc 1 259 0 is_stmt 0 discriminator 1
	add	r1, r6, r7
	sub	r2, r5, r7
	add	r0, sp, #20
	bl	luaL_addlstring
.L25:
	.loc 1 262 0 is_stmt 1
	ldr	r4, .L37+20
	.loc 1 260 0
	add	r0, sp, #20
	bl	luaL_pushresult
	.loc 1 262 0
.LPIC12:
	add	r4, pc
	ldr	r5, [r4, #4]
	ldr	r7, [sp, #8]
.LVL36:
	sub	r6, r5, #1
.LVL37:
	lsl	r5, r5, #2
	b	.L26
.L27:
	.loc 1 263 0
	mov	r1, #1
	neg	r1, r1
	mov	r2, #0
	mov	r0, r7
	bl	lua_tolstring
	ldr	r3, [r4]
	mov	r1, r0
	mov	r0, r7
	add	r2, r3, r5
	ldr	r2, [r2, #4]
	ldr	r3, [r3, r5]
	bl	luaL_gsub
	.loc 1 264 0
	mov	r1, #2
	mov	r2, #1
	mov	r0, r7
	neg	r1, r1
	neg	r2, r2
	bl	lua_rotate
	mov	r1, #2
	mov	r0, r7
	neg	r1, r1
	bl	lua_settop
	.loc 1 262 0 discriminator 2
	sub	r6, r6, #2
.LVL38:
.L26:
	.loc 1 262 0 is_stmt 0 discriminator 1
	ldr	r3, [r4, #4]
	.loc 1 262 0 discriminator 2
	sub	r5, r5, #8
	.loc 1 262 0 discriminator 1
	cmp	r6, r3
	bcc	.L27
	.loc 1 266 0 is_stmt 1
	ldr	r3, .L37+8
	ldr	r1, [sp, #12]
	add	r3, r3, sp
	ldr	r2, [r3]
	ldr	r3, [r1]
	cmp	r2, r3
	beq	.L28
	bl	__stack_chk_fail
.L28:
	ldr	r3, .L37+24
	add	sp, sp, r3
	@ sp needed for prologue
.LVL39:
	pop	{r4, r5, r6, r7, pc}
.L38:
	.align	2
.L37:
	.word	__stack_chk_guard(GOT_PREL)+(.-(.LPIC15+4))
	.word	-8236
	.word	8228
	.word	.LC1-(.LPIC10+4)
	.word	.LC1-(.LPIC11+4)
	.word	.LANCHOR0-(.LPIC12+4)
	.word	8236
	.cfi_endproc
.LFE39:
	.fnend
	.size	Xml_pushDecode, .-Xml_pushDecode
	.section	.text.Tokenizer_set,"ax",%progbits
	.align	1
	.code	16
	.thumb_func
	.type	Tokenizer_set, %function
Tokenizer_set:
	.fnstart
.LFB36:
	.loc 1 106 0
	.cfi_startproc
	.save	{r3, r4, r5, r6, r7, lr}
	push	{r3, r4, r5, r6, r7, lr}
.LCFI5:
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	.cfi_offset 4, -20
	.cfi_offset 5, -16
	.cfi_offset 6, -12
	.cfi_offset 7, -8
	.cfi_offset 14, -4
.LVL40:
	.loc 1 106 0
	mov	r4, r0
	mov	r6, r1
	.loc 1 107 0
	sub	r5, r2, #0
	beq	.L41
	neg	r7, r1
	adc	r7, r7, r1
	cmp	r7, #0
	bne	.L41
	.loc 1 108 0
	ldr	r0, [r0, #24]
.LVL41:
	bl	free
.LVL42:
	.loc 1 109 0
	add	r0, r5, #1
	bl	malloc
	.loc 1 110 0
	mov	r1, r6
	.loc 1 109 0
	str	r0, [r4, #24]
	.loc 1 110 0
	mov	r2, r5
	bl	strncpy
	.loc 1 111 0
	ldr	r3, [r4, #24]
	strb	r7, [r3, r5]
	.loc 1 114 0
	ldr	r0, [r4, #24]
	.loc 1 112 0
	str	r5, [r4, #32]
	str	r5, [r4, #28]
	.loc 1 114 0
	b	.L40
.L41:
	.loc 1 107 0 discriminator 1
	mov	r0, #0
.L40:
	.loc 1 115 0
	@ sp needed for prologue
.LVL43:
.LVL44:
.LVL45:
	pop	{r3, r4, r5, r6, r7, pc}
	.cfi_endproc
.LFE36:
	.fnend
	.size	Tokenizer_set, .-Tokenizer_set
	.section	.text.Xml_encode.part.0,"ax",%progbits
	.align	1
	.code	16
	.thumb_func
	.type	Xml_encode.part.0, %function
Xml_encode.part.0:
	.fnstart
.LFB45:
	.loc 1 381 0
	.cfi_startproc
	.save	{r4, r5, r6, r7, lr}
	push	{r4, r5, r6, r7, lr}
.LCFI6:
	.cfi_def_cfa_offset 20
	.cfi_offset 4, -20
	.cfi_offset 5, -16
	.cfi_offset 6, -12
	.cfi_offset 7, -8
	.cfi_offset 14, -4
.LVL46:
	ldr	r4, .L49
	ldr	r1, .L49+4
	.loc 1 383 0
	mov	r2, #0
	.loc 1 381 0
	.pad #8228
	add	sp, sp, r4
.LCFI7:
	.cfi_def_cfa_offset 8248
	.loc 1 381 0
	ldr	r4, .L49+8
	add	r1, r1, sp
	mov	r5, r0
.LPIC27:
	add	r4, pc
	ldr	r4, [r4]
	.loc 1 383 0
	mov	r7, #4
	.loc 1 385 0
	mov	r6, #0
	.loc 1 381 0
	ldr	r3, [r4]
	str	r3, [r1]
	.loc 1 383 0
	mov	r1, #1
	neg	r1, r1
	bl	luaL_checklstring
.LVL47:
	str	r4, [sp, #4]
	.loc 1 385 0 discriminator 1
	ldr	r4, .L49+12
.LPIC26:
	add	r4, pc
	b	.L43
.LVL48:
.L44:
	.loc 1 386 0
	neg	r1, r1
	mov	r2, #0
	bl	lua_tolstring
	ldr	r3, [r4]
	lsl	r2, r6, #2
	mov	r1, r0
	ldr	r2, [r2, r3]
	mov	r0, r5
	ldr	r3, [r3, r7]
	bl	luaL_gsub
	.loc 1 387 0
	mov	r1, #2
	mov	r2, #1
	mov	r0, r5
	neg	r1, r1
	neg	r2, r2
	bl	lua_rotate
	mov	r1, #2
	mov	r0, r5
	neg	r1, r1
	bl	lua_settop
	.loc 1 385 0 discriminator 2
	add	r6, r6, #2
.LVL49:
	add	r7, r7, #8
.LVL50:
.L43:
	.loc 1 385 0 is_stmt 0 discriminator 1
	ldr	r3, [r4, #4]
	.loc 1 386 0 is_stmt 1
	mov	r0, r5
	mov	r1, #1
	.loc 1 385 0 discriminator 1
	cmp	r6, r3
	bcc	.L44
	.loc 1 390 0
	mov	r2, #0
	bl	lua_tolstring
	.loc 1 393 0
	add	r1, sp, #12
	.loc 1 390 0
	mov	r4, r0
.LVL51:
	.loc 1 393 0
	mov	r0, r5
.LVL52:
	bl	luaL_buffinit
.LVL53:
	.loc 1 394 0
	mov	r2, #0
	b	.L45
.LVL54:
.L46:
	.loc 1 394 0 is_stmt 0 discriminator 1
	add	r2, r2, #1
.LVL55:
.L45:
	ldrb	r3, [r4, r2]
	cmp	r3, #0
	bne	.L46
	.loc 1 399 0 is_stmt 1
	cmp	r2, #0
	beq	.L47
	.loc 1 399 0 is_stmt 0 discriminator 1
	add	r0, sp, #12
	mov	r1, r4
	bl	luaL_addlstring
.LVL56:
.L47:
	.loc 1 400 0 is_stmt 1
	add	r0, sp, #12
	bl	luaL_pushresult
	.loc 1 401 0
	mov	r1, #2
	mov	r2, #1
	neg	r2, r2
	mov	r0, r5
	neg	r1, r1
	bl	lua_rotate
	mov	r1, #2
	mov	r0, r5
	neg	r1, r1
	bl	lua_settop
	.loc 1 403 0
	ldr	r3, .L49+4
	ldr	r1, [sp, #4]
	mov	r0, #1
	add	r3, r3, sp
	ldr	r2, [r3]
	ldr	r3, [r1]
	cmp	r2, r3
	beq	.L48
	bl	__stack_chk_fail
.L48:
	ldr	r3, .L49+16
	add	sp, sp, r3
	@ sp needed for prologue
.LVL57:
.LVL58:
.LVL59:
	pop	{r4, r5, r6, r7, pc}
.L50:
	.align	2
.L49:
	.word	-8228
	.word	8220
	.word	__stack_chk_guard(GOT_PREL)+(.-(.LPIC27+4))
	.word	.LANCHOR0-(.LPIC26+4)
	.word	8228
	.cfi_endproc
.LFE45:
	.fnend
	.size	Xml_encode.part.0, .-Xml_encode.part.0
	.section	.text.Xml_encode,"ax",%progbits
	.align	1
	.global	Xml_encode
	.code	16
	.thumb_func
	.type	Xml_encode, %function
Xml_encode:
	.fnstart
.LFB43:
	.loc 1 381 0
	.cfi_star