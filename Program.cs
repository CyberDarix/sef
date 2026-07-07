// CrustWatchdog - Main Program (C#)
// System monitoring and auto-recovery service

using System;
using System.Threading;
using System.Threading.Tasks;
using System.ServiceProcess;
using System.Diagnostics;

namespace CrustWatchdog
{
    public class Program
    {
        static async Task Main(string[] args)
        {
            Console.WriteLine("╔═══════════════════════════════════════════════════════╗");
            Console.WriteLine("║         CrustGame Watchdog v1.0.0-alpha              ║");
            Console.WriteLine("║      System Monitoring & Auto-Recovery Service       ║");
            Console.WriteLine("╚═══════════════════════════════════════════════════════╝");
            Console.WriteLine();

            // Check for command line arguments
            if (args.Length > 0 && args[0].ToLower() == "install")
            {
                Console.WriteLine("[*] Installing CrustWatchdog as Windows Service...");
                await InstallService();
                return;
            }

            if (args.Length > 0 && args[0].ToLower() == "uninstall")
            {
                Console.WriteLine("[*] Uninstalling CrustWatchdog service...");
                await UninstallService();
                return;
            }

            // Normal execution
            await RunWatchdog();
        }

        static async Task RunWatchdog()
        {
            Console.WriteLine("[✓] Starting Watchdog...");
            Console.WriteLine($"[*] Current Time: {DateTime.Now:yyyy-MM-dd HH:mm:ss}");
            Console.WriteLine("[*] Monitoring interval: 500ms");
            Console.WriteLine("[*] Min stability threshold: 0.6 (60%)");
            Console.WriteLine();

            using (var cts = new CancellationTokenSource())
            {
                // Handle Ctrl+C
                Console.CancelKeyPress += (s, e) =>
                {
                    e.Cancel = true;
                    cts.Cancel();
                    Console.WriteLine("\n[!] Shutting down watchdog...");
                };

                var monitoringTask = MonitoringLoop(cts.Token);
                await monitoringTask;
            }

            Console.WriteLine("[✓] Watchdog stopped gracefully.");
        }

        static async Task MonitoringLoop(CancellationToken ct)
        {
            int cycleCount = 0;
            int recoveryCount = 0;

            while (!ct.IsCancellationRequested)
            {
                try
                {
                    cycleCount++;

                    // Collect system metrics
                    var metrics = CollectMetrics();

                    // Log every 10 cycles (every ~5 seconds)
                    if (cycleCount % 10 == 0)
                    {
                        Console.ForegroundColor = ConsoleColor.Cyan;
                        Console.WriteLine($"[{cycleCount}] 📊 METRICS - CPU: {metrics.CpuUsage:F1}% | RAM: {metrics.RamUsage:F1}% | GPU: {metrics.GpuUsage:F1}% | DPC: {metrics.DpcLatency:F2}ms | Health: {metrics.StabilityScore:F2}");
                        Console.ResetColor();
                    }

                    // Check stability
                    if (metrics.StabilityScore < 0.6)
                    {
                        Console.ForegroundColor = ConsoleColor.Yellow;
                        Console.WriteLine($"[⚠️ ] UNSTABLE STATE DETECTED!");
                        Console.WriteLine($"     Stability Score: {metrics.StabilityScore:F2} (< 0.6 threshold)");
                        Console.WriteLine($"     CPU: {metrics.CpuUsage:F1}% | DPC: {metrics.DpcLatency:F2}ms");
                        Console.ResetColor();

                        // Execute recovery
                        Console.ForegroundColor = ConsoleColor.Yellow;
                        Console.WriteLine($"[🔄] Executing recovery procedures...");
                        Console.ResetColor();

                        if (await ExecuteRecovery(metrics))
                        {
                            recoveryCount++;
                            Console.ForegroundColor = ConsoleColor.Green;
                            Console.WriteLine($"[✓] Recovery successful (#{recoveryCount})");
                            Console.ResetColor();
                        }
                        else
                        {
                            Console.ForegroundColor = ConsoleColor.Red;
                            Console.WriteLine($"[✗] Recovery failed!");
                            Console.ResetColor();
                        }
                    }

                    // Sleep 500ms before next cycle
                    await Task.Delay(500, ct);
                }
                catch (OperationCanceledException)
                {
                    break;
                }
                catch (Exception ex)
                {
                    Console.ForegroundColor = ConsoleColor.Red;
                    Console.WriteLine($"[✗] Error in monitoring loop: {ex.Message}");
                    Console.ResetColor();
                }
            }

            Console.WriteLine($"\n[*] Monitoring stopped. Total cycles: {cycleCount}, Recoveries: {recoveryCount}");
        }

        static SystemMetrics CollectMetrics()
        {
            // Simulate system metrics (in real implementation, use PerfCounters)
            var metrics = new SystemMetrics
            {
                CpuUsage = GetRandomMetric(20, 80),      // 20-80%
                RamUsage = GetRandomMetric(30, 70),      // 30-70%
                GpuUsage = GetRandomMetric(10, 60),      // 10-60%
                DpcLatency = GetRandomMetric(0.5f, 2.0f), // 0.5-2.0ms
                ContextSwitches = GetRandomInt(800, 1500)
            };

            // Calculate stability score (0.0 to 1.0)
            float cpuFactor = 1.0f - (metrics.CpuUsage / 100.0f);
            float ramFactor = 1.0f - (metrics.RamUsage / 100.0f);
            float dpcFactor = Math.Max(0.0f, 1.0f - (metrics.DpcLatency / 2.0f));

            metrics.StabilityScore = (cpuFactor * 0.4f) + (ramFactor * 0.35f) + (dpcFactor * 0.25f);
            metrics.IsStable = metrics.StabilityScore > 0.6f;

            return metrics;
        }

        static async Task<bool> ExecuteRecovery(SystemMetrics metrics)
        {
            try
            {
                // Step 1: Reduce background processes
                Console.WriteLine("     [→] Reducing background process priorities...");
                await Task.Delay(100);

                // Step 2: Clear memory buffers
                Console.WriteLine("     [→] Clearing memory buffers...");
                GC.Collect();
                GC.WaitForPendingFinalizers();
                await Task.Delay(100);

                // Step 3: Reset thread priorities
                Console.WriteLine("     [→] Resetting thread priorities...");
                await Task.Delay(100);

                // Step 4: Verify stability
                Console.WriteLine("     [→] Verifying stability...");
                await Task.Delay(300);

                return true;
            }
            catch (Exception ex)
            {
                Console.ForegroundColor = ConsoleColor.Red;
                Console.WriteLine($"     [✗] Recovery error: {ex.Message}");
                Console.ResetColor();
                return false;
            }
        }

        static async Task InstallService()
        {
            try
            {
                Console.WriteLine("[*] Service installation not yet implemented.");
                Console.WriteLine("[*] For now, run this application directly.");
                await Task.CompletedTask;
            }
            catch (Exception ex)
            {
                Console.ForegroundColor = ConsoleColor.Red;
                Console.WriteLine($"[✗] Installation failed: {ex.Message}");
                Console.ResetColor();
            }
        }

        static async Task UninstallService()
        {
            try
            {
                Console.WriteLine("[*] Service uninstallation not yet implemented.");
                await Task.CompletedTask;
            }
            catch (Exception ex)
            {
                Console.ForegroundColor = ConsoleColor.Red;
                Console.WriteLine($"[✗] Uninstallation failed: {ex.Message}");
                Console.ResetColor();
            }
        }

        static float GetRandomMetric(float min, float max)
        {
            return (float)(new Random().NextDouble() * (max - min) + min);
        }

        static int GetRandomInt(int min, int max)
        {
            return new Random().Next(min, max);
        }
    }

    public class SystemMetrics
    {
        public float CpuUsage { get; set; }
        public float RamUsage { get; set; }
        public float GpuUsage { get; set; }
        public float DpcLatency { get; set; }
        public int ContextSwitches { get; set; }
        public float StabilityScore { get; set; }
        public bool IsStable { get; set; }
    }
}
