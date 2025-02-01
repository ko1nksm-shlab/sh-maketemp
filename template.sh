#!/bin/sh

tmpl() {
  set -- "$1" "${2%"${2##*[!X]}"}" "${2##*[!X]}"
  : & set -- "$@" $(( ($! * 48271) % 2147483647 )) && wait $!
  until [ "${#3}" -eq 0 ] && eval "$1"='$2'; do
    set -- "$1" "$2" "$3" $(( ($4 * 48271) % 2147483647 )) # MINSTD
    set -- "$@" $((${4#-} % 62)) 0 1 2 3 4 5 6 7 8 9
    set -- "$@" A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
    set -- "$@" a b c d e f g h i j k l m n o p q r s t u v w x y z
    eval 'set -- "$1" "${2}${'$(($5 + 5))'}" "${3#X}" "$4"'
  done
}

tmpl_cmd() {
  set -- "$1" "${2%"${2##*[!X]}"}" "${2##*[!X]}"
  eval "$1"='${2}$(tr -dc 0-9A-Za-z < /dev/urandom | dd bs=1 count=${#3} 2>/dev/null)'
}

retry=${1:-20} name='' template="tmp.XXXXXXXXXX"
while [ $((retry = retry - 1)) -ge 0 ]; do
  tmpl name "$template"
  echo "$name"
done
