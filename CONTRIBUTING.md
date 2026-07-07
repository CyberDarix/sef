# Contributing to CrustGame

First off, thanks for considering contributing to CrustGame! It's people like you that make CrustGame such a great tool.

## Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct. By participating, you are expected to uphold this code.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the issue list as you might find out that you don't need to create one. When you are creating a bug report, please include as many details as possible:

* **Use a clear and descriptive title**
* **Describe the exact steps which reproduce the problem**
* **Provide specific examples to demonstrate the steps**
* **Describe the behavior you observed after following the steps**
* **Explain which behavior you expected to see instead and why**
* **Include screenshots and animated GIFs if possible**
* **Include your system information** (Windows version, hardware specs, etc.)

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, please include:

* **Use a clear and descriptive title**
* **Provide a step-by-step description of the suggested enhancement**
* **Provide specific examples to demonstrate the steps**
* **Describe the current behavior and the new behavior**
* **Explain why this enhancement would be useful**

### Pull Requests

* Fill in the required template
* Follow the C++/C#/Rust style guides
* Include appropriate test cases
* End all files with a newline
* Avoid platform-dependent code

## Development Setup

### Prerequisites

- Visual Studio 2022 Community Edition or later
- Windows 10/11 SDK
- .NET 6.0 SDK
- Rust 1.70+ (for Watchdog)
- Intel Fortran Compiler or Gfortran

### Build Instructions

```powershell
# Clone and build
git clone https://github.com/CrustGame/CrustGame.git
cd CrustGame
./build.ps1 -Configuration Debug
```

## Style Guides

### C++ Style Guide

- Use `.hpp` for headers, `.cpp` for implementation
- Use `CamelCase` for class names
- Use `camelCase` for variables and functions
- Prefer `const` and `constexpr` where possible
- Use smart pointers (`unique_ptr`, `shared_ptr`)

### C# Style Guide

- Follow Microsoft C# coding conventions
- Use PascalCase for public members
- Use camelCase for private members
- Use LINQ where appropriate

### Rust Style Guide

- Follow `rustfmt` formatting
- Use `cargo fmt` before submitting
- Use `cargo clippy` for linting

### Commit Messages

- Use the present tense ("Add feature" not "Added feature")
- Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
- Limit the first line to 72 characters or less
- Reference issues and pull requests liberally after the first line

## License

By contributing to CrustGame, you agree that your contributions will be licensed under its MIT License.
