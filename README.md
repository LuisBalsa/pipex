# Pipex - Unfinished

Pipex is a command-line utility designed to replicate the functionality of the `|` operator in shell commands. It allows the user to execute a series of commands, with the output of each command piped as input to the next command in the sequence.

Please note that this version of Pipex is an unfinished work, more tests needed.


## Usage

The general syntax for running PipeX is as follows:

```shell
./pipex file1/(here_doc LIMITER) cmd1 .. cmdx file2
```

- `file1`: The input file for the first command or the keyword `here_doc` to enable here document functionality.
- `LIMITER` (only when `file1` is `here_doc`): The delimiter to indicate the end of the here document input.
- `cmd1 .. cmdx`: The commands to be executed in sequence, with the output of each command piped as input to the next command.
- `file2`: The output file to store the final result.

**Note:** This is an unfinished version of PipeX, and its functionality may be limited or incomplete.
