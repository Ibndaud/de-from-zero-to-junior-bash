#!/bin/bash

{
 echo "Отчет о логе веб-сервера"
 echo "========================"
 echo -e "Общее количество запросов:\t  $(awk 'END{print NR}' access.log)"
 echo -e "Количество уникальных IP-адресов:\t $(awk 'NF { ips[$1] } END { print length(ips) }' access.log)"
 echo
 echo
 echo "Количество запросов по методам:"
 echo "   $(awk '/GET/ { count++ } END { print count }' access.log) GET"
 echo "   $(awk '/POST/ { count++ } END { print count }' access.log) POST"
 echo
 echo
 echo -e "Самый популярный URL:\t $(awk 'match($0, /"[^"]+"/) {
     req = substr($0, RSTART+1, RLENGTH-2)
     n = split(req, parts, /[[:space:]]+/)
     if (n >= 2) {
       url = parts[2]
       counts[url]++
       if (counts[url] > max) { max = counts[url]; top = url }
     }
   }
   END { print max, top }' access.log)"
} > report.txt

echo "Отчет сохранен в файл report.txt"
