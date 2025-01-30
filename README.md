# sh-maketemp

Alternative implementation of the mktemp command made with POSIX commands only.

Unfortunately, the `mktemp` command is not standardized in POSIX. I hope it will be standardized in the future.

- 0001616: Standardize mktemp utility
  - https://www.austingroupbugs.net/view.php?id=1616

## Usage

```sh
. ./maketemp.sh

# Creating a temporary file
maketemp

# Creating a temporary file with prefix
maketemp prefix

# Creating a temporary directory
maketemp -dir

# Creating a temporary FIFO (named pipe)
maketemp -fifo
```
