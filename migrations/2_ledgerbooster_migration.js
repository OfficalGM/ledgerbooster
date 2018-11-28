const LedgerBooster = artifacts.require("./LedgerBooster.sol");
const Util=artifacts.require("Util");
module.exports = function(deployer) {
  deployer.link(Util,LedgerBooster);
  deployer.deploy(LedgerBooster);
};
