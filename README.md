# nogicomma

## 概要
- nogiのジョークコマンド集。

## 例

![image](https://user-images.githubusercontent.com/44114228/123083029-9bbe0980-d45a-11eb-98a2-cce803a311a6.png)

![image](https://user-images.githubusercontent.com/44114228/123083193-c8722100-d45a-11eb-9973-77bffaf5b79a.png)

<img width="372" alt="ncmark" src="https://user-images.githubusercontent.com/44114228/128032943-7e8b9a64-e18d-4f7e-935d-a7d9bc6d7da1.png">

![image](https://user-images.githubusercontent.com/44114228/128033903-3e768275-1cae-4f85-8ec0-527af7cc8702.png)

![image](https://user-images.githubusercontent.com/44114228/132500739-3803b0a5-d0a6-4b86-bcd0-f8155364891e.png)

![image](https://user-images.githubusercontent.com/44114228/132770231-5e7c204a-ba61-483c-9904-6db78c434847.png)

## インストール
- use docker

```bash
$ docker-compose build

$ docker-compose up -d

$ docker-compose exec nogicomma bash
```

## コマンド

|コマンド|説明|
|:---:|:---:|
|ncseq|指定した数だけnogimarkを出力|
|ncname|指定した名前をnogi風に整形|
|ncmark|指定した数に応じた乃木坂記号を出力|
|nclist|メンバー情報をTSVで出力|
|ncdoko|乃木どこ情報をTSVで出力|
|nckojichu|乃木坂工事中情報をTSVで出力|
|ncnewmember|乃木坂メンバー名ジェネレータ|
|ncnewsingle|楽曲名ジェネレータ|
