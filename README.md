# wgrib2-docker

GRIB2データの操作用 [wgrib2](https://www.cpc.ncep.noaa.gov/products/wesley/wgrib2/) コマンドをコンテナ化したDockerイメージです。  
Docker環境さえあれば、ローカルにwgrib2をインストールせずに、手軽にGRIB2操作ができます。

---

## 利用方法

### イメージの取得

```sh
docker pull ghcr.io/naogify/wgrib2:latest
```

### コマンド例

カレントディレクトリ内のGRIB2ファイルを操作する場合は、  
-vオプションでマウントして実行します。

```sh
docker run --rm -v "$(pwd)":/data ghcr.io/naogify/wgrib2:latest /data/yourfile.grib2 -help
```

例えば「10m地上のU風成分だけ抽出」する場合：

```sh
docker run --rm -v "$(pwd)":/data ghcr.io/naogify/wgrib2:latest \
  /data/input.grib2 -match ":UGRD:10 m above ground:" -grib_out /data/wind_u_10m.grib2
```

---

## タグ・イメージ名

- `ghcr.io/naogify/wgrib2:latest`
    - 常に最新のmainブランチ由来
- （将来）バージョンタグも付与予定

---

## 開発・CI/CD

このイメージは [GitHub Actions](https://github.com/naogify/wgrib2-docker/actions) で自動ビルド・自動pushされています。

### 手動ビルド例

```sh
docker build -t ghcr.io/naogify/wgrib2:latest .
```

---

## ライセンス・クレジット

- 本イメージは [wgrib2公式](https://www.cpc.ncep.noaa.gov/products/wesley/wgrib2/) のビルド済みバイナリをベースにしています。
- ライセンス等は[公式ページ](https://www.cpc.ncep.noaa.gov/products/wesley/wgrib2/)を参照ください。

---

## お問い合わせ・Issue

ご質問やIssueは [GitHub Issue](https://github.com/naogify/wgrib2-docker/issues) までお願いします。
