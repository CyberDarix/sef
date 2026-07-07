// main.rs - CrustWatchdog Entry Point (Rust)
// Rust 15% - System monitoring and auto-recovery

use std::sync::atomic::{AtomicBool, Ordering};
use std::sync::Arc;
use std::thread;
use std::time::Duration;

mod monitor;
mod recovery;
mod ipc_bridge;

use monitor::SystemMonitor;
use recovery::RecoveryManager;

fn main() {
	println!("CrustWatchdog - System Monitoring Service");
	println!("Starting watchdog...");

	let is_running = Arc::new(AtomicBool::new(true));
	let is_running_clone = is_running.clone();

	// Setup signal handler for graceful shutdown
	ctrlc::set_handler(move || {
		println!("Shutting down CrustWatchdog...");
		is_running_clone.store(false, Ordering::Relaxed);
	}).expect("Error setting Ctrl-C handler");

	// Initialize components
	let mut system_monitor = SystemMonitor::new();
	let recovery_manager = RecoveryManager::new();

	// Main monitoring loop
	while is_running.load(Ordering::Relaxed) {
		// Get system metrics
		let metrics = system_monitor.collect_metrics();

		// Check system health
		if !metrics.is_stable {
			println!("⚠️  System instability detected!");
			println!("   DPC Latency: {:.2}ms", metrics.dpc_latency);
			println!("   CPU Usage: {:.1}%", metrics.cpu_usage);
			println!("   RAM Usage: {:.1}%", metrics.ram_usage);

			// Trigger recovery
			if let Err(e) = recovery_manager.execute_recovery(&metrics) {
				eprintln!("❌ Recovery failed: {}", e);
			} else {
				println!("✅ Recovery executed successfully");
			}
		}

		// Log metrics every 5 seconds
		if system_monitor.metrics_log_counter % 10 == 0 {
			println!("📊 Metrics - CPU: {:.1}% | RAM: {:.1}% | GPU: {:.1}% | DPC: {:.2}ms",
				metrics.cpu_usage, metrics.ram_usage, metrics.gpu_usage, metrics.dpc_latency);
		}

		system_monitor.metrics_log_counter += 1;

		// Sleep for 500ms (monitoring interval)
		thread::sleep(Duration::from_millis(500));
	}

	println!("CrustWatchdog stopped.");
}
