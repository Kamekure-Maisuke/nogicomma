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
current_year=$(date '+%Y')
page_data=$(curl -s 'https://ja.wikipedia.org/wiki/乃木坂工事中の放送日程一覧')
search_command="grep -A 1 -E '<td style=.+>[0-9]+月[0-9]+日' | sed -r -e 's/<[^>]+>//g' -e 's/&#.+//g' -e '/--/d' | tr -d '\"' | awk '{if(NR%2)ORS=\"\t\"; else ORS=\"\n\"; print}'"

for i in `seq 2015 $current_year`; do
  [ $i -ne $current_year ] && {
	echo "$page_data" |
	sed -n "/<span class=\"mw-headline\" id=\"$i年\">/,/<span class=\"mw-headline\" id=\"$((i+1))年\">/p" |
	eval ${search_command} |
	sed "s/^/$i年/"
  } || {
	echo "$page_data" |
	sed -n "/<span class=\"mw-headline\" id=\"$i年\">/,/<span class=\"mw-headline\" id=\"脚注\">/p" |
	eval ${search_command} |
	sed "s/^/$i年/"
  }
done
```

## singleデータの作成

```bash
cat data | sed -n '/<span class="mw-headline" id="シングル">/,/<span class="mw-headline" id="アルバム">/p' | grep -E -e '<td .+>[0-9]{4}年[0-9]+月[0-9]+日' -e '<b>.+</b>' | sed -r 's/<[^>]+>//g' | awk '{if(NR%2)ORS="\t"; else ORS="\n"; print}' > single.tsv
```