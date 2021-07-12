# koujichuListデータの作成

```bash
curl -s 'https://ja.wikipedia.org/wiki/%E4%B9%83%E6%9C%A8%E5%9D%82%E5%B7%A5%E4%BA%8B%E4%B8%AD%E3%81%AE%E6%94%BE%E9%80%81%E6%97%A5%E7%A8%8B%E4%B8%80%E8%A6%A7' |
sed -n '/<span class="mw-headline" id="2015年">/,/<span class="mw-headline" id="脚注">/p' |
grep -A 1 -E '<td style=.+>[0-9]+月[0-9]+日' |
sed -r -e 's/<[^>]+>//g' -e 's/&.+//g' -e '/--/d' |
awk '{if(NR%2)ORS=" "; else ORS="\n"; print}'
```
