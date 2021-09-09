#!/bin/bash

set -e

# mecab解析結果
result=$(mecab ../data/single_all)

# 名詞,代名詞
md=$(echo "$result" | awk -F '[\t,]' 'BEGIN{OFS="\t"} $2$3=="名詞代名詞" && !a[$0]++{print "名詞_代名詞",$1,$9}')
# 名詞,一般
mi=$(echo "$result" | awk -F '[\t,]' 'BEGIN{OFS="\t"} $2$3=="名詞一般" && !a[$0]++ {print "名詞_一般",$1,$9}')
# 名詞,形容動詞
mk=$(echo "$result" | awk -F '[\t,]' 'BEGIN{OFS="\t"} $2$3=="名詞形容動詞語幹" && !a[$0]++{print "名詞_形容動詞",$1,$9}')
# 名詞,サ変接続
ms=$(echo "$result" | awk -F '[\t,]' 'BEGIN{OFS="\t"} $2$3=="名詞サ変接続" && !a[$0]++{print "名詞_サ変接続",$1,$9}')
# 名詞,副詞可能
mh=$(echo "$result" | awk -F '[\t,]' 'BEGIN{OFS="\t"} $2$3=="名詞副詞可能" && !a[$0]++{print "名詞_副詞可能",$1,$9}')
# 名詞,数
mn=$(echo "$result" | awk -F '[\t,]' 'BEGIN{OFS="\t"} $2$3=="名詞数" && !a[$0]++{print "名詞_数",$1,$9}')

# 助詞,連体化
jr=$(echo "$result" | awk -F '[\t,]' 'BEGIN{OFS="\t"} $2$3=="助詞連体化" && !a[$0]++{print "助詞_連体化",$1,$9}')
# 助詞,格助詞
jk=$(echo "$result" | awk -F '[\t,]' 'BEGIN{OFS="\t"} $2$3=="助詞格助詞" && !a[$0]++{print "助詞_格助詞",$1,$9}')

# 形容詞,自立
kj=$(echo "$result" | awk -F '[\t,]' 'BEGIN{OFS="\t"} $2$3=="形容詞自立" && !a[$0]++{print "形容詞_自立",$1,$9}')

# 副詞,助詞類接続
hj=$(echo "$result" | awk -F '[\t,]' 'BEGIN{OFS="\t"} $2$3=="副詞助詞類接続" && !a[$0]++{print "副詞_助詞類接続",$1,$9}')
# 副詞,一般
hi=$(echo "$result" | awk -F '[\t,]' 'BEGIN{OFS="\t"} $2$3=="副詞一般" && !a[$0]++{print "副詞_一般",$1,$9}')

# 結果出力
cat <<EOS
種類	用語	読み
$md
$mi
$mk
$ms
$mh
$mn
$jr
$jk
$kj
$hj
$hi
EOS
