#!/bin/bash

DATA_DIR="$(dirname $0)/../data"

curl -s "https://ja.wikipedia.org/wiki/%E4%B9%83%E6%9C%A8%E5%9D%8246" |
grep -E -B 3 '<td>.+(都|県|府|州|道)</td>' |
sed -r -e 's/<[^>]+>//g' -e '/--/d' |
awk '{if(NR%4)ORS="\t";else ORS="\n"; print}' |
awk -F '\t' '{print $1"\t"$2"\t"substr($3,1,10)"\t"$4}'
