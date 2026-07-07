// ServiceManager.hpp - Service management header
#pragma once

#include <windows.h>
#include <string>
#include <atomic>

namespace CrustCore {

class ServiceManager {
public:
	ServiceManager() = default;
	~ServiceManager() = default;

	// Initialize service with given name
	bool Initialize(const std::string& serviceName);

	// Start service operations
	bool Start();

	// Stop service operations
	bool Stop();

	// Check if service is running
	bool IsRunning() const;

	// Apply optimization
	bool ApplyOptimization(const std::string& mode);

	// Reset to defaults
	bool ResetDefaults();

private:
	std::atomic<bool> isRunning = false;
	std::string serviceName;
	SERVICE_STATUS serviceStatus = {};
	SERVICE_STATUS_HANDLE serviceStatusHandle = nullptr;

	void MonitoringLoop();
};

} // namespace CrustCore
