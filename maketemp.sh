maketemp() {
  (
    mkfile() {
      set -C
      : > "$file" &
      if [ -p "$file" ]; then
        : <> "$file" || :
        return 1
      fi
      wait $!
    }
    : & n=$! && wait $!
    retry=1000 && umask 0077
    while [ $((retry = retry - 1)) -ge 0 ]; do
      n=$(( n ^ ((n << 13) & 4294967295) ))
      n=$(( n ^ ((n >> 17) & 32767) ))
      n=$(( n ^ ((n << 5) & 4294967295) ))
      file=$(( (n < 0 ? -1 * n : n) % 100000000 + 100000000))
      file="${TMPDIR:-/tmp}/${file#1}"
      case ${1:--file} in
        -file) mkfile "$file" 2>/dev/null && break ;;
        -dir) mkdir "$file" 2>/dev/null && break ;;
        -fifo) mkfifo "$file" 2>/dev/null && break ;;
        *) echo "maketemp: unknown file type: $1" >&2 && exit 1
      esac
    done
    [ "$retry" -ge 0 ] && printf '%s\n' "$file" && exit 0
    echo "maketemp: failed to create temporary file: $file" >&2
    exit 1
  )
}
