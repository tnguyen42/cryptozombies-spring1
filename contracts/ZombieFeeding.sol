// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./ZombieFactory.sol";

abstract contract KittyInterface {
	function getKitty(uint256 _id)
		external
		view
		virtual
		returns (
			bool isGestating,
			bool isReady,
			uint256 cooldownIndex,
			uint256 nextActionAt,
			uint256 siringWithId,
			uint256 birthTime,
			uint256 matronId,
			uint256 sireId,
			uint256 generation,
			uint256 genes
		);
}

/**
 * @dev Holds all of the Zombie Feeding logic
 */
contract ZombieFeeding is ZombieFactory {
	// address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
	// KittyInterface kittyContract = KittyInterface(ckAddress);
	KittyInterface kittyContract;

	/**
	 * @dev Allows the owner of the smart contract to change the address of the CryptoKitties smart contract
	 * @param _address The new address of the CryptoKitties smart contract
	 */
	function setKittyAddress(address _address) external onlyOwner {
		kittyContract = KittyInterface(_address);
	}

	/**
	 * @dev Triggers the cooldown of a given zombie
	 * @param _zombie The zombie which cooldown should be triggered
	 */
	function _triggerCooldown(Zombie storage _zombie) internal {
		_zombie.readyTime = uint32(block.timestamp + cooldownTime);
	}

	/**
	 * @dev Returns true if the zombie is ready to attack again, false otherwise
	 * @param _zombie The zombie to check
	 */
	function _isReady(Zombie storage _zombie) internal view returns (bool) {
		return ((_zombie.readyTime <= block.timestamp));
	}

	/**
	 * @dev Allows the owner of a zombie to feed one of his zombies
	 * @param _zombieId The ID of the zombie to be fed
	 * @param _targetDna The DNA of the target
	 * @param _species The species of the target
	 */
	function feedAndMultiply(
		uint256 _zombieId,
		uint256 _targetDna,
		string memory _species
	) internal {
		require(
			msg.sender == zombieToOwner[_zombieId],
			"You cannot feed a zombie that isn't yours"
		);
		require(
			_isReady(zombies[_zombieId]) == true,
			"The zombie cooldown is not over."
		);

		Zombie storage myZombie = zombies[_zombieId];

		_targetDna = _targetDna % dnaModulus;

		uint256 newDna = (myZombie.dna + _targetDna) / 2;
		if (
			keccak256(abi.encodePacked(_species)) ==
			keccak256(abi.encodePacked("kitty"))
		) {
			newDna = newDna - (newDna % 100) + 99;
		}

		_createZombie("NoName", newDna);
		_triggerCooldown(myZombie);
	}

	/**
	 * @dev A function dedicated to zombie feeding using crypto kitties
	 * @param _zombieId The ID of the zombie to be fed
	 * @param _kittyId The ID of the crypto kitty to be served as food
	 */
	function feedOnKitty(uint256 _zombieId, uint256 _kittyId) public {
		uint256 kittyDna;
		(, , , , , , , , , kittyDna) = kittyContract.getKitty(_kittyId);
		feedAndMultiply(_zombieId, kittyDna, "kitty");
	}
}
