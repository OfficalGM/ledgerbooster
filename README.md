# contract

## 環境

1. 安裝nodejs LTS版本 (目前10.13.0 LTS)
2. `npm install -g truffle`
3. `npm install -g ganache-cli` (Optional)
4. 在 `contract` 目錄下執行 `npm install`
5. `truffle version`檢查目前版本資訊

Output如下，需與下列版本或更高
```
Truffle v4.1.14 (core: 4.1.14)
Solidity v0.4.24 (solc-js)
```

## 複製設定檔

1. `cp env.js.example env.js`
2. 在 `env.js` 填寫 `develpoment` 和 `testnet` 測試鏈的設定檔

註冊 [Infura](https://infura.io/ ) 帳號，建立Project，取得 `PROJECT SECRET` 與 `ENDPOINT` (切換為Ropsten)
安裝 [MetaMask](https://metamask.io/) ，匯入私鑰 (重複`PROJECT SECRET`)，並取得測試幣

設定檔ex:

```
const env={
  development:{
    privatekey : '<PROJECT SECRET><PROJECT SECRET>',
    web3Url : '<ENDPOINT>'
  },
  testnet : {
    privatekey : '<PROJECT SECRET><PROJECT SECRET>',
    web3Url : '<ENDPOINT>'
  }
}
module.exports=env;
```

## 部署智能合約

`truffle deploy --reset --network [development|testnet]`
(Windows環境請改為`truffle.cmd`)

ps.
- development (ganache)
- testnet (infura的ropsten測試網路，可換別的測試鏈)

Output如下，需要取得Contract Address
```
D:\_ns2\contract>truffle.cmd deploy --reset --network development
Using network 'development'.

Running migration: 1_initial_migration.js
  Deploying Migrations...
  ... 0xd993b04508152924f4f404835a6f4adda901f2db6c99279f2026e65293c5e8d1
  Migrations: 0x51f147b7cc0893d13ccec4144a3837997d346f4b
Saving successful migration to network...
  ... 0xfa65eaef572b897f825767fce7ec56152c175fc5d0636398d2b1be16c8ccd3de
Saving artifacts...
Running migration: 2_auth_migration.js
  Deploying Auth...
  ... 0x9267b96f1657348170d84ca011feb7bb93895b8a76edfd2e3c81e9a383486a7f
  Auth: 0x9683eeb68fe0d3df151559670c83a40fbfd8472b
Saving successful migration to network...
  ... 0xf1d238d04264a29d3a0caa6b0585452f1904672be316dbcca1989d35acc2407f
Saving artifacts...
```
Contract Address為 ***0x9683eeb68fe0d3df151559670c83a40fbfd8472b***

## 測試智能合約

1. smart contract 轉成java(在web3j-4.0/bin底下)
- sh web3j truffle generate <'yourpath'>.json -p <'com.your.organisation.name'> -o <'yourpath'>
2. 


## web3j 版本 4.0.1
```
1.一定要安裝 web3j command line tools(詳細方法請參照官網教學)
2.web3j.sh 為Mac版本的shell
```



