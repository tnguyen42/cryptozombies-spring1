const ZombieFactory = artifacts.require("ZombieFactory.sol");

module.exports = function (deployer, network) {
	return deployer.then(() => {
		console.log("Deploying ZombieFactory on " + network);
		return deployer.deploy(ZombieFactory);
	});
};
