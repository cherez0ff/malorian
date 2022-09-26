#/bin/bash
input="$1" # FULL PATH HERE!
while read -r line
do
  if [[ -n "$line" ]]; then
    echo -n "${line}${2}"
    echo
  fi
done < "$input"
