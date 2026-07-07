// OptimizationEngine.hpp - Core optimization logic
#pragma once

#include <string>
#include <vector>
#include <cstdint>

namespace CrustCore {

struct OptimizationConfig {
	bool enableCPUAffinity = true;
	bool enableMemoryOptimization = true;
	bool enableInputLagReduction = true;
	bool enableGPUControl = true;
	bool enableMonitoring = true;
};

struct SystemMetrics {
	float cpuUsage = 0.0f;
	float ramUsage = 0.0f;
	float gpuUsage = 0.0f;
	float dpcLatency = 0.0f;
	uint32_t contextSwitches = 0;
	bool isStable = true;
};

class OptimizationEngine {
public:
	OptimizationEngine() = default;
	~OptimizationEngine() = default;

	// Enable gaming mode optimizations
	bool EnableGamingMode(uint32_t processId);

	// Disable gaming mode
	bool DisableGamingMode(uint32_t processId);

	// Get current system metrics
	SystemMetrics GetSystemMetrics();

	// Apply CPU affinity to isolate process
	bool SetCPUAffinity(uint32_t processId, uint32_t coreMask);

	// Optimize memory
	bool OptimizeMemory();

	// Monitor DPC latency
	float GetDPCLatency();

private:
	OptimizationConfig config;
	SystemMetrics currentMetrics;
};

} // namespace CrustCore
