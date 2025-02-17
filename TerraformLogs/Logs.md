# Terraform Logging Configuration Guide

## Introduction
Logging in Terraform is essential for debugging, monitoring, and troubleshooting infrastructure deployment. Terraform provides built-in logging capabilities through environment variables that control the verbosity and output of logs.

## Configuring Terraform Logging
Terraform uses two primary environment variables to manage logging:

1. **TF_LOG** - Controls the logging verbosity level.
2. **TF_LOG_PATH** - Specifies the file path to store log output.

### TF_LOG Levels
The `TF_LOG` variable defines the verbosity level of logs. The available levels are:

- `TRACE` - Provides the most detailed logs, including every step Terraform takes.
- `DEBUG` - Provides detailed operational logs.
- `INFO` - Displays general process information.
- `WARN` - Shows warnings about potential issues.
- `ERROR` - Logs only errors that prevent Terraform execution.

### TF_LOG_PATH
By default, Terraform logs are printed to standard error (stderr). Setting the `TF_LOG_PATH` variable directs logs to a file.

## Setting Up Logging for a Session
You can enable logging for a single session by setting environment variables.

### Windows (PowerShell):
```powershell
$env:TF_LOG = "TRACE"
$env:TF_LOG_PATH = "terraform.log"
```

### Linux/macOS (Bash):
```bash
export TF_LOG="TRACE"
export TF_LOG_PATH="terraform.log"
```

Running Terraform commands such as `terraform plan` or `terraform apply` will generate a `terraform.log` file in the current directory.

## Persisting Logging Settings
To retain these settings across sessions, update the shell profile.

### Windows (PowerShell Profile):
1. Check your profile path:
   ```powershell
   echo $profile
   ```
2. Open the profile file and add:
   ```powershell
   $env:TF_LOG = "TRACE"
   $env:TF_LOG_PATH = "terraform.log"
   ```
3. Save the file and restart PowerShell.

### Linux/macOS (Bash Profile):
1. Open `.bashrc` or `.bash_profile`:
   ```bash
   nano ~/.bashrc
   ```
2. Append the following lines:
   ```bash
   export TF_LOG="TRACE"
   export TF_LOG_PATH="terraform.log"
   ```
3. Save and apply changes:
   ```bash
   source ~/.bashrc
   ```

## Example: Debugging Terraform
Suppose you encounter an issue with a Terraform plan. To debug:

1. Enable logging:
   ```bash
   export TF_LOG="DEBUG"
   export TF_LOG_PATH="terraform_debug.log"
   ```
2. Run Terraform command:
   ```bash
   terraform plan
   ```
3. Open the log file to inspect details:
   ```bash
   cat terraform_debug.log
   ```

## Best Practices
- Set `TF_LOG` to `TRACE` or `DEBUG` only when troubleshooting.
- Use `TF_LOG_PATH` to avoid cluttering the terminal with logs.
- Add `terraform.log` to `.gitignore` to prevent it from being committed.

## Additional Resources
For more details, refer to the [Terraform Debugging Documentation](https://developer.hashicorp.com/terraform/internals/v1.1.x/debugging).

By configuring logging properly, you can efficiently diagnose and resolve issues in Terraform workflows.

# Reference:
https://www.phillipsj.net/posts/how-to-configure-logging-for-terraform/
