; Latency.asm - DPC Latency Measurement Routine
; Assembly x64 - 2% of project
; Ultra-low latency measurement for performance monitoring

EXTERN __rdtsc:PROC

; RDTSC (Read Time Stamp Counter) wrapper
PUBLIC MeasureLatency
PUBLIC GetSystemTime

.code

; Measure latency using RDTSC
; void MeasureLatency(uint64_t* outCycles)
MeasureLatency PROC
	; RCX = pointer to output

	; Read timestamp counter (start)
	CPUID           ; Serialize instruction pipeline
	RDTSC           ; Read TSC into EDX:EAX
	MOV R8, RDX     ; Save high 32 bits
	MOV R9, RAX     ; Save low 32 bits

	; Do measurement work
	NOP
	NOP
	NOP
	NOP
	NOP

	; Read timestamp counter (end)
	CPUID           ; Serialize
	RDTSC           ; Read TSC again

	; Calculate difference
	SUB RAX, R9
	SBB RDX, R8

	; Store result to output
	MOV [RCX], RAX

	RET
MeasureLatency ENDP

; Get high-resolution system time
; uint64_t GetSystemTime()
GetSystemTime PROC
	RDTSC           ; Read TSC into EDX:EAX
	SHL RDX, 32
	OR RAX, RDX     ; Combine into 64-bit value
	RET
GetSystemTime ENDP

END
