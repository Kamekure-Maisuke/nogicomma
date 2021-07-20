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
curl -s 'https://ja.wikipedia.org/wiki/%E4%B9%83%E6%9C%A8%E5%9D%82%E5%B7%A5%E4%BA%8B%E4%B8%AD%E3%81%AE%E6%94%BE%E9%80%81%E6%97%A5%E7%A8%8B%E4%B8%80%E8%A6%A7' |
sed -n '/<span class="mw-headline" id="2015年">/,/<span class="mw-headline" id="脚注">/p' |
grep -A 1 -E '<td style=.+>[0-9]+月[0-9]+日' |
sed -r -e 's/<[^>]+>//g' -e 's/&.+//g' -e '/--/d' |
awk '{if(NR%2)ORS=" "; else ORS="\n"; print}'
```

## singleデータの作成

```bash
cat data | sed -n '/<span class="mw-headline" id="シングル">/,/<span class="mw-headline" id="アルバム">/p' | grep -E -e '<td .+>[0-9]{4}年[0-9]+月[0-9]+日' -e '<b>.+</b>' | sed -r 's/<[^>]+>//g' | awk '{if(NR%2)ORS="\t"; else ORS="\n"; print}' > single.tsv
```
