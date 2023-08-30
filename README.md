# cxcxc_app


A new Flutter project.


# 第一次使用流程  
## 清除套件設定  
```
flutter clean  
flutter pub get  
```    


## 啟用與連入本地模擬環境  
```
docker-compose up -d
docker exec -it firebase-emulator.cxcxc /bin/bash  
```  


## 登入firebase
```
firebase login --reauth
```  


## 透過flutterfire命令列，註冊專案  
```
dart pub global activate flutterfire_cli


PATH="$PATH":"$HOME/.pub-cache/bin"  


<!-- 設置 ios、android 專案 -->
flutterfire configure  
```  


## 啟用模擬器，並匯入firestore 測試資料集  
(使用模擬器才需要, 只有 Remote_config 不需要)
```
<!-- 設置 firestore、storage、emulator、Authentication -->
firebase init
<!-- 若要調整專案, 使用 firebase use <project_id> -->
firebase emulators:start
<!-- 若無法啟動, 檢查 firebase.json -->
```  


## 更新 firebase.json  
(使用模擬器才需要, 只有 Remote_config 不需要)
```  
{
  "firestore": {
    "rules": "firestore.rules",
    "indexes": "firestore.indexes.json"
  },
  "storage": {
    "rules": "storage.rules"
  },
  "emulators": {
    "auth": {
      "host": "0.0.0.0",
      "port": 9099
    },
    "firestore": {
      "host": "0.0.0.0",
      "port": 8080
    },
    "storage": {
      "host": "0.0.0.0",
      "port": 9199
    },
    "ui": {
      "host": "0.0.0.0",
      "enabled": true,
      "port": 4000
    },
    "singleProjectMode": true
  }
}


```  


## 設定
(使用模擬器才需要, 只有 Remote_config 不需要)
lib/utils/config.dart
* 未來若要生產用需要全改為環境變數較為安全，避免反向工程
* 因開發用, 若要在開發時啟動環境變數, 需額外設定 IDE 環境變數的設定  
 
```
// 判定是否啟用模擬器，開發時需啟用；生產時須關閉
const bool USE_EMULATOR = true;
// 設定 ip, 若是使用實體手機進行測試, 需更換 ip 為電腦 ip
const String IP = "localhost";
// 判定是否為開發階段
// 定義, 生產階段時, info 以上的 log 才打印出來; 開發階段時, 所有 log 都打印出來
const bool IS_DEVELOPMENT_STAGE = true;
```


## 環境變數(vscode開發)
(使用模擬器與 Firebase Auth 才需要, 只有 Remote_config 不需要)
// 桶子名稱
const String BUCKET_NAME = "cloud-master-artworks";
// Google Provider Client ID
const String GOOGLE_PROVIDER_CLIENT_ID = "<Firebase Google Provider ID>";


### 建立 /.vscode/launch.json
(使用模擬器與 Firebase Auth 才需要, 只有 Remote_config 不需要)
於 configurations 設定環境變數
```
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "cxcxc_ar_app",
            "request": "launch",
            "type": "dart",
            "args": [
                "--dart-define",
                "BUCKET_NAME=cloud-master-artworks",
                "--dart-define",
                "GOOGLE_PROVIDER_CLIENT_ID=<Firebase Google Provider ID>",
            ],
        },
    ]
}
```
