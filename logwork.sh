#!/bin/bash

author=$USER

unset password
echo "Utilizando '$author' como login do JIRA"
prompt="Informe a senha do JIRA:"
while IFS= read -p "$prompt" -r -s -n 1 char
do
    if [[ $char == $'\0' ]]
    then
        break
    fi
    prompt='*'
    password+="$char"
done
echo ""

sed 1d "$1" |
gawk '/^.*$/ {                                                                                                       line = handle_line($0)
 n = split(line, data, ";")
 for(i = 1; i <= n; i++) {
   if(i == 6) {
     card = data[i]
     card = gensub(/\[(.*)\].*/, "\\1","g", card )
     printf "%s;", card
   }
   if(i == 12)
   {
     time = data[i]
     time = gensub(/(.*):(.*):(.*)/, "\\1h \\2m", "g", time)
     data[i] = time
   }

   printf "%s;",data[i]
 }
 printf "\n"
}

function handle_line(n) {
  while (a = match (n, /(".*")/)) {
    start = RSTART
    len = RLENGTH

    value = substr(n, RSTART+1, RLENGTH-2)
    gsub(",", "\\,", value)
    n = substr(n, 1, start-1) value substr(n, (start+len))
  }
  gsub(",",";", n)
  n = gensub(/(\\\;)/,",", "g", n)
  return n
}' |
while IFS=\; read user email client project task card description billable startDate startTime endDate endTime duration tags amount; do

 startDate="$startDate"T"$startTime".000-0300

 data="{ \"author\" : { \"name\": \"$author\" }, \"comment\" : \"$description\", \"started\" : \"$startDate\", \"timeSpent\": \"$duration\" }"

echo $data

result=$(eval "curl -u $author:$password -H 'Content-Type: application/json; charset=utf-8' -s -w \"%{http_code} $card\n\" http://jira.wkm.com.br/rest/api/2/issue/$card/worklog -X POST --data '$data' -o /dev/null ");
  echo $result
  echo $result >> worklogged.txt;


 done
