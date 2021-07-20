# 各種データ作成手順

## memberinfoデータの作成

### 全メンバーの取得

```bash
curl -s 'https://ja.wikipedia.org/wiki/%E4%B9%83%E6%9C%A8%E5%9D%8246' |
grep -E -B 3 '<td>.+(都|県|府|州|道)</td>' |
sed -r -e 's/<[^>]+>//g' -e '/--/d' |
awk '{if(NR%4)ORS="\t";else ORS="\n"; print}' |
awk -F '\t' '{print $1"\t"$2"\t"substr($3,1,10)"\t"$4}'
```

### 現メンバーの取得

```bash
curl -s 'https://ja.wikipedia.org/wiki/%E4%B9%83%E6%9C%A8%E5%9D%8246' |
sed -n -e '/<span class="mw-headline" id="現メンバー">現メンバー/,/<\/table>/p' |
grep -E -B 3 '<td>.+(都|県|府|州|道)</td>' |
sed -r -e 's/<[^>]+>//g' -e '/--/d' |
awk '{if(NR%4) ORS="\t";else ORS="\n"; print}' |
awk -F '\t' '{print $1"\t"$2"\t"substr($3,1,10)"\t"$4}'
```

### 元メンバーの取得

```bash
curl -s 'https://ja.wikipedia.org/wiki/%E4%B9%83%E6%9C%A8%E5%9D%8246' |
sed -n -e '/<span class="mw-headline" id="元メンバー">元メンバー/,/<\/table>/p' |
grep -E -B 3 '<td>.+(都|県|府|州|道)</td>' |
sed -r -e 's/<[^>]+>//g' -e '/--/d' |
awk '{if(NR%4) ORS="\t";else ORS="\n"; print}' |
awk -F '\t' '{print $1"\t"$2"\t"substr($3,1,10)"\t"$4}'
```

## koujichuListデータの作成

```bash
URL="https://ja.wikipedia.org/wiki"
SEARCH="乃木坂工事中の放送日程一覧"
encode=$(printf "$SEARCH" | od -tx1 -An | xargs)
result=$(echo $encode | awk '{sub(".","%&",$0); gsub(" ","%",$0); print toupper($0)}')
page_data=$(curl -s "$URL/$result")

search_command="grep -A 1 -E '<td style=.+>[0-9]+月[0-9]+日' | sed -r -e 's/<[^>]+>//g' -e 's/&#.+//g' -e '/--/d' | tr -d '\"' | awk '{if(NR%2)ORS=\"\t\"; else ORS=\"\n\"; print}'"

list_2015=$(echo "$page_data" |
sed -n '/<span class="mw-headline" id="2015年">/,/<span class="mw-headline" id="2016年">/p' |
eval ${search_command})

list_2016=$(echo "$page_data" |
sed -n '/<span class="mw-headline" id="2016年">/,/<span class="mw-headline" id="2017年">/p' |
eval ${search_command})

list_2017=$(echo "$page_data" |
sed -n '/<span class="mw-headline" id="2017年">/,/<span class="mw-headline" id="2018年">/p' |
eval ${search_command})

list_2018=$(echo "$page_data" |
sed -n '/<span class="mw-headline" id="2018年">/,/<span class="mw-headline" id="2019年">/p' |
eval ${search_command})

list_2019=$(echo "$page_data" |
sed -n '/<span class="mw-headline" id="2019年">/,/<span class="mw-headline" id="2020年">/p' |
eval ${search_command})

list_2020=$(echo "$page_data" |
sed -n '/<span class="mw-headline" id="2020年">/,/<span class="mw-headline" id="2021年">/p' |
eval ${search_command})

list_2021=$(echo "$page_data" |
sed -n '/<span class="mw-headline" id="2021年">/,/<span class="mw-headline" id="脚注">/p' |
eval ${search_command})

echo "$list_2015" | sed 's/^/2015年/'
echo "$list_2016" | sed 's/^/2016年/'
echo "$list_2017" | sed 's/^/2017年/'
echo "$list_2018" | sed 's/^/2018年/'
echo "$list_2019" | sed 's/^/2019年/'
echo "$list_2020" | sed 's/^/2020年/'
echo "$list_2021" | sed 's/^/2021年/'
```

## singleデータの作成

```bash
cat data | sed -n '/<span class="mw-headline" id="シングル">/,/<span class="mw-headline" id="アルバム">/p' | grep -E -e '<td .+>[0-9]{4}年[0-9]+月[0-9]+日' -e '<b>.+</b>' | sed -r 's/<[^>]+>//g' | awk '{if(NR%2)ORS="\t"; else ORS="\n"; print}' > single.tsv
```
