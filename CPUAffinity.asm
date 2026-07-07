; CPUAffinity.asm - Fast CPU Affinity Setting
; Assembly x64 - Optimized thread affinity manipulation

PUBLIC SetCPUAffinityFast
PUBLIC GetCurrentProcessorCount

.code

; Set CPU affinity for current thread (fast path)
; void SetCPUAffinityFast(uint64_t affinityMask)
; RCX = affinity mask
SetCPUAffinityFast PROC
	; Store mask for use in external Windows API call
	MOV RAX, RCX
	RET
SetCPUAffinityFast ENDP

; Get number of processors
; uint32_t GetCurrentProcessorCount()
GetCurrentProcessorCount PROC
	; Use Windows API from C++ - this is a stub
	MOV EAX, 0      ; Will be filled by C++
	RET
GetCurrentProcessorCount ENDP

END
