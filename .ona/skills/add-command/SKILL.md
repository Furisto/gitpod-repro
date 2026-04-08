---
name: add-command
description: "Add a new Cobra CLI command to the project"
---

## Workflow

1. Create a new file under `cmd/` named `<command>.go`
2. Define the command using `cobra.Command` following the pattern in `cmd/root.go`
3. Register the command in an `init()` function with `rootCmd.AddCommand(<command>Cmd)`
4. Add flags and arguments as needed
5. Run `go build .` to verify compilation

## Example

```go
package cmd

import (
    "fmt"
    "github.com/spf13/cobra"
)

var greetCmd = &cobra.Command{
    Use:   "greet [name]",
    Short: "Greet a user",
    Args:  cobra.ExactArgs(1),
    Run: func(cmd *cobra.Command, args []string) {
        fmt.Printf("Hello, %s!\n", args[0])
    },
}

func init() {
    rootCmd.AddCommand(greetCmd)
}
```

## Anti-patterns

- Do not put business logic directly in the `Run` function — extract it into a separate package
- Do not use `os.Exit` inside commands — return errors and let Cobra handle exit codes
