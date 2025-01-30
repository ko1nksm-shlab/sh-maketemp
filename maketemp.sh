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
    case ${1:--file} in
      -file | -dir | -fifo) set -- "${1#-}" "${2:-}" ;;
      [!-]*) set -- '' "$1" ;;
      *) echo "maketemp: unknown file type: $1" >&2 && exit 1
    esac
    : & n=$(( ($! * 48271) % 2147483647 )) && wait $!
    retry=1000 && umask 0077
    while [ $((retry = retry - 1)) -ge 0 ]; do
      n=$(( (n * 48271) % 2147483647 )) # MINSTD
      file="${TMPDIR:-/tmp}/${2:-tmp}.${n#-}"
      "mk${1:-file}" "$file" 2>/dev/null && break
    done
    [ "$retry" -ge 0 ] && printf '%s\n' "$file" && exit 0
    echo "maketemp: failed to create temporary file: $file" >&2
    exit 1
  )
}
