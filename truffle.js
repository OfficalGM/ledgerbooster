let env = require('./env');
let WalletProvider = require('truffle-wallet-provider');
let Wallet = require('ethereumjs-wallet');

let testnet = env.testnet
let testnetWallet = Wallet.fromPrivateKey(new Buffer(testnet.privatekey, 'hex'));
let devnet=env.development
let devnetWallet=Wallet.fromPrivateKey(new Buffer(devnet.privatekey, 'hex'));
module.exports = {
  solc: {
    // Optional: Optimizer settings
    optimizer: {
      // Disabled by default
      enabled: true,
      // Optimize for how many times you intend to run the code.
      // Lower values will optimize more for initial deployment cost, higher values will optimize more for high-frequency usage.
      runs: 200
    }
  },
  networks: {
    development: {
      provider:function(){
        return new WalletProvider(devnetWallet, devnet.web3Url);
      },
      network_id: "*", // Match any network id
      gas: 4700000,
      // gasPrice - Use 10 Gwei
      gasPrice: 10000000000
    },
    testnet: {
      provider: function () {
        return new WalletProvider(testnetWallet, testnet.web3Url);
      },
      network_id: '*',
      gas: 4700000,
      gasPrice: 10000000000
    }
  }
};
