# CMakeLists.txt - Build configuration for CrustGame
cmake_minimum_required(VERSION 3.20)
project(CrustGame CXX Fortran ASM_MASM)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Platform check
if(NOT WIN32)
	message(FATAL_ERROR "CrustGame is Windows-only")
endif()

# Architecture check
if(NOT CMAKE_SIZEOF_VOID_P EQUAL 8)
	message(FATAL_ERROR "CrustGame requires x64 architecture")
endif()

# Output directories
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib")

# ============================================================================
# CrustCore - C++ Service (50%)
# ============================================================================
add_executable(CrustCore
	src/CrustCore/cpp/CrustCore.cpp
	src/CrustCore/cpp/ServiceManager.hpp
	src/CrustCore/cpp/OptimizationEngine.hpp
)

target_include_directories(CrustCore PRIVATE
	${CMAKE_SOURCE_DIR}/src/CrustCore/cpp
)

# Link Windows libraries
target_link_libraries(CrustCore PRIVATE
	kernel32
	user32
	advapi32
	wtsapi32
	wmi
)

# ============================================================================
# Assembly Routines - x64 (2%)
# ============================================================================
if(MSVC)
	enable_language(ASM_MASM)
	set(CMAKE_ASM_MASM_COMPILE_OBJECT "<CMAKE_C_COMPILER> <DEFINES> <INCLUDES> <FLAGS> /c <SOURCE> /Fo<OBJECT>")

	add_library(CrustOptimizer STATIC
		src/CrustOptimizer/assembly/Latency.asm
		src/CrustOptimizer/assembly/CPUAffinity.asm
	)

	# Link to CrustCore
	target_link_libraries(CrustCore PRIVATE CrustOptimizer)
endif()

# ============================================================================
# Fortran Predictor (1%)
# ============================================================================
add_library(CrustPredictor STATIC
	src/CrustPredictor/fortran/predictor.f90
)

target_link_libraries(CrustCore PRIVATE CrustPredictor)

# ============================================================================
# Copy PowerShell Scripts
# ============================================================================
add_custom_command(TARGET CrustCore POST_BUILD
	COMMAND ${CMAKE_COMMAND} -E copy_directory
	"${CMAKE_SOURCE_DIR}/src/CrustScripts/powershell"
	"${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/scripts"
	COMMENT "Copying PowerShell scripts"
)

# ============================================================================
# Copy Documentation
# ============================================================================
add_custom_command(TARGET CrustCore POST_BUILD
	COMMAND ${CMAKE_COMMAND} -E copy
	"${CMAKE_SOURCE_DIR}/docs/ARCHITECTURE.md"
	"${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/"
	COMMENT "Copying documentation"
)

# ============================================================================
# Build Summary
# ============================================================================
message(STATUS "")
message(STATUS "CrustGame Build Configuration")
message(STATUS "==============================")
message(STATUS "Platform: ${CMAKE_SYSTEM_NAME} ${CMAKE_SYSTEM_PROCESSOR}")
message(STATUS "Generator: ${CMAKE_GENERATOR}")
message(STATUS "C++ Standard: C++${CMAKE_CXX_STANDARD}")
message(STATUS "Output: ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}")
message(STATUS "")
