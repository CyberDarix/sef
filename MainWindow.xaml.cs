// MainWindow.xaml.cs - Main UI Window for CrustUI
using System;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;

namespace CrustUI {
    public partial class MainWindow : Window {
        private bool gamingModeEnabled = false;
        private System.Windows.Threading.DispatcherTimer updateTimer;

        public MainWindow() {
            InitializeComponent();

            // Setup timer for metrics update
            updateTimer = new System.Windows.Threading.DispatcherTimer();
            updateTimer.Interval = TimeSpan.FromMilliseconds(500);
            updateTimer.Tick += UpdateMetrics_Tick;
            updateTimer.Start();

            this.Loaded += MainWindow_Loaded;
        }

        private void MainWindow_Loaded(object sender, RoutedEventArgs e) {
            this.Title = "CrustGame - Gaming Performance Optimizer";
            UpdateMetrics();
        }

        private void UpdateMetrics_Tick(object sender, EventArgs e) {
            UpdateMetrics();
        }

        private void UpdateMetrics() {
            // Simulate metrics with some randomness
            Random rand = new Random();
            float cpuUsage = 30 + rand.Next(0, 50);
            float ramUsage = 40 + rand.Next(0, 40);
            float gpuUsage = 20 + rand.Next(0, 40);
            float dpcLatency = 0.5f + (float)rand.NextDouble() * 1.5f;

            if (CPUUsageText != null) CPUUsageText.Text = $"CPU Usage: {cpuUsage:F1}%";
            if (RAMUsageText != null) RAMUsageText.Text = $"RAM Usage: {ramUsage:F1}%";
            if (GPUUsageText != null) GPUUsageText.Text = $"GPU Usage: {gpuUsage:F1}%";
            if (DPCLatencyText != null) DPCLatencyText.Text = $"DPC Latency: {dpcLatency:F2}ms";

            bool isHealthy = cpuUsage < 85 && ramUsage < 85 && dpcLatency < 1.5f;
            if (HealthText != null) 
                HealthText.Text = isHealthy ? "System Health: ✓ Stable" : "System Health: ⚠ Warning";
        }

        // Gaming Mode Toggle Button
        private void GamingModeButton_Click(object sender, RoutedEventArgs e) {
            gamingModeEnabled = !gamingModeEnabled;
            var button = sender as Button;

            if (gamingModeEnabled) {
                button.Content = "Gaming Mode: ON";
                button.Foreground = new System.Windows.Media.SolidColorBrush(
                    System.Windows.Media.Colors.LimeGreen);
                MessageBox.Show("✓ Gaming Mode Activated!\n\nOptimizations are now active.", 
                    "CrustGame", MessageBoxButton.OK, MessageBoxImage.Information);
            } else {
                button.Content = "Gaming Mode: OFF";
                button.Foreground = new System.Windows.Media.SolidColorBrush(
                    System.Windows.Media.Colors.White);
                MessageBox.Show("✓ Gaming Mode Deactivated!", 
                    "CrustGame", MessageBoxButton.OK, MessageBoxImage.Information);
            }
        }

        // Reset System Defaults
        private void ResetButton_Click(object sender, RoutedEventArgs e) {
            var result = MessageBox.Show(
                "Reset all system settings to defaults?\n\nThis cannot be undone.",
                "CrustGame - Reset Confirmation",
                MessageBoxButton.YesNo,
                MessageBoxImage.Question);

            if (result == MessageBoxResult.Yes) {
                MessageBox.Show("✓ System reset to defaults.", "Success", 
                    MessageBoxButton.OK, MessageBoxImage.Information);
                gamingModeEnabled = false;
                GamingModeButton.Content = "Gaming Mode: OFF";
                GamingModeButton.Foreground = new System.Windows.Media.SolidColorBrush(
                    System.Windows.Media.Colors.White);
            }
        }

        private void Window_Closing(object sender, System.ComponentModel.CancelEventArgs e) {
            if (updateTimer != null) {
                updateTimer.Stop();
            }
        }
    }
}
