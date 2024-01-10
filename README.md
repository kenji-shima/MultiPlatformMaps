# Kotlin Multiplatformプロジェクト

<table>
<tr>
<th>Android</th>
<th>iOS</th>
</tr>
<tr>
<td>
<img src="https://kenji-shima.github.io/resource-files/images/multiplatform_android.png" height="600px">
</td>
<td>
<img src="https://kenji-shima.github.io/resource-files/images/multiplatform_ios.png" height="600px">
</td>
</tr>
</table>

## 機能
MapboxのAndroidおよびiOS SDKで地図を表示。地図をタップすると、
- [Mapbox Geocoding](https://docs.mapbox.com/api/search/geocoding/)にて場所名を取得、表示
- その場所の1週間の天気予報を[Open-Meteo](https://open-meteo.com/)から取得して表示

## アーキテクチャ

### 共有ロジック（Kotlin）:

- 天気予報の取得と形式フォーマット
- 座標から場所の名前を取得

### 個別ロジック（Kotlin、Swift）:

- 各OS用のUI描画

## 使用技術

- [Kotlin Multiplatform](https://developer.android.com/kotlin/multiplatform)
- [Gradle](https://gradle.org/)
- [Cocoapods](https://cocoapods.org/)
- AndroidおよびiOSのMapbox SDK v11

## セットアップ方法

### Android

1. Android Studioでプロジェクトを開く
2. [Mapbox Android SDKのセットアップガイド](https://docs.mapbox.com/android/maps/guides/install/)
   に従い、secretトークンとpublicトークンを設定 (※publicトークンはファイル `res/values/mapbox_access_token.xml` に設定)

### iOS

1. Xcodeで iosApp.xcodeworkspace（※iosApp.xcodeprojでない事に注意）を開く
2. [iOS Mapbox SDKセットアップ](https://docs.mapbox.com/ios/maps/guides/install/)に従い、`Info.plist`
   に `MBXAccessToken` としてpublicトークンを設定
3. 必要に応じてCocoapadsをインストール


