var Outcome = artifacts.require("./Outcome.sol");
var Dragon = artifacts.require("./Dragon.sol")
module.exports = function(deployer) {
  deployer.deploy(Outcome, {gas: 6700000});
  deployer.deploy(Dragon, {gas: 6700000});
};
