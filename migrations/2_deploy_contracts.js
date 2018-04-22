var Outcome = artifacts.require("./Outcome.sol");
module.exports = function(deployer) {
  deployer.deploy(Outcome, {gas: 6700000});
};
