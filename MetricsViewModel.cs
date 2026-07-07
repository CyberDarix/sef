// MetricsViewModel.cs - ViewModel for real-time metrics display
using System;
using System.ComponentModel;
using System.Runtime.CompilerServices;
using System.Threading;
using System.Threading.Tasks;
using CrustUI.Services;

namespace CrustUI {
    public class MetricsViewModel : INotifyPropertyChanged {
        private ServiceClient serviceClient;
        private CancellationTokenSource monitoringCts;

        private float cpuUsage;
        private float ramUsage;
        private float gpuUsage;
        private float dpcLatency;
        private string systemHealth;
        private string status;

        public float CPUUsage {
            get => cpuUsage;
            set { cpuUsage = value; OnPropertyChanged(); }
        }

        public float RAMUsage {
            get => ramUsage;
            set { ramUsage = value; OnPropertyChanged(); }
        }

        public float GPUUsage {
            get => gpuUsage;
            set { gpuUsage = value; OnPropertyChanged(); }
        }

        public float DPCLatency {
            get => dpcLatency;
            set { dpcLatency = value; OnPropertyChanged(); }
        }

        public string SystemHealth {
            get => systemHealth;
            set { systemHealth = value; OnPropertyChanged(); }
        }

        public string Status {
            get => status;
            set { status = value; OnPropertyChanged(); }
        }

        public MetricsViewModel(ServiceClient client) {
            serviceClient = client ?? throw new ArgumentNullException(nameof(client));
            systemHealth = "Stable";
            status = "Ready";
        }

        // Start real-time monitoring
        public async Task StartMonitoring() {
            monitoringCts = new CancellationTokenSource();
            await Task.Run(async () => {
                while (!monitoringCts.Token.IsCancellationRequested) {
                    try {
                        var metrics = await serviceClient.GetSystemMetrics();

                        CPUUsage = metrics.CPUUsage;
                        RAMUsage = metrics.RAMUsage;
                        GPUUsage = metrics.GPUUsage;
                        DPCLatency = metrics.DPCLatency;
                        SystemHealth = metrics.IsStable ? "✓ Stable" : "⚠ Warning";
                        Status = "Monitoring...";
                    } catch (Exception ex) {
                        Status = $"Error: {ex.Message}";
                    }

                    await Task.Delay(500, monitoringCts.Token);
                }
            });
        }

        // Stop monitoring
        public void StopMonitoring() {
            monitoringCts?.Cancel();
            monitoringCts?.Dispose();
        }

        // INotifyPropertyChanged implementation
        public event PropertyChangedEventHandler PropertyChanged;

        protected void OnPropertyChanged([CallerMemberName] string name = null) {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(name));
        }
    }
}
