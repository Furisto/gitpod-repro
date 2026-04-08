---
name: run-tests
description: "Run and add Go tests for the CLI project"
---

## Workflow

1. Run existing tests: `go test ./...`
2. For new commands, create a test file `cmd/<command>_test.go`
3. Use table-driven tests with `t.Run` subtests
4. Test both success and error cases
5. Verify with `go test -v ./...`

## Example

```go
package cmd

import (
    "bytes"
    "testing"
)

func TestGreetCmd(t *testing.T) {
    tests := []struct {
        name    string
        args    []string
        want    string
        wantErr bool
    }{
        {
            name: "valid name",
            args: []string{"greet", "Alice"},
            want: "Hello, Alice!\n",
        },
        {
            name:    "missing argument",
            args:    []string{"greet"},
            wantErr: true,
        },
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            buf := new(bytes.Buffer)
            rootCmd.SetOut(buf)
            rootCmd.SetArgs(tt.args)
            err := rootCmd.Execute()
            if (err != nil) != tt.wantErr {
                t.Errorf("error = %v, wantErr %v", err, tt.wantErr)
            }
            if !tt.wantErr && buf.String() != tt.want {
                t.Errorf("got %q, want %q", buf.String(), tt.want)
            }
        })
    }
}
```

## Anti-patterns

- Do not skip error case tests — always test invalid inputs
- Do not use `t.Fatal` inside goroutines — use `t.Error` instead
