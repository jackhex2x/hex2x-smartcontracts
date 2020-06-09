const Hex2XToken = artifacts.require('Hex2XToken');

let hex2x;

module.exports = function(deployer, network, accounts) {
  deployer.then(async () => {
    hex2x = await deployer.deploy(Hex2XToken);
  });
};