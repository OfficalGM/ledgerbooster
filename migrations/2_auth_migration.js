var Migrations = artifacts.require("./Auth.sol");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
};
