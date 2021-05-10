// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./ZombieFeeding.sol";

contract ZombieHelper is ZombieFeeding {
	uint256 levelUpFee = 0.001 ether;

	modifier aboveLevel(uint256 _level, uint256 _zombieId) {
		require(
			zombies[_zombieId].level >= _level,
			"The zombie level should be higher."
		);
		_;
	}

	/**
	 * @dev A function that allows the owner of the contract to withdraw the whole balance stored at the smart contract address
	 */
	function withdraw() external onlyOwner {
		address payable _owner = payable(owner());
		_owner.transfer(address(this).balance);
	}

	/**
	 * A function to edit the level up fee
	 * @param _fee The new fee
	 */
	function setLevelUpFee(uint256 _fee) external onlyOwner {
		levelUpFee = _fee;
	}

	/**
	 * @dev A payable function to increase the level of a user's zombie by 1.
	 * @param _zombieId The ID of the zombie to be leveled up
	 */
	function levelUp(uint256 _zombieId) external payable {
		require(
			msg.value == levelUpFee,
			"You didn't pay the right amount of ether for this transaction."
		);
		zombies[_zombieId].level++;
	}

	/**
	 * @dev Allows the owner of a zombie to rename it (if zombie's level >= 2)
	 * @param _zombieId The ID of the zombie to be renamed
	 * @param _newName The new name to be given to the zombie
	 */
	function changeName(uint256 _zombieId, string calldata _newName)
		external
		aboveLevel(2, _zombieId)
	{
		require(
			msg.sender == zombieToOwner[_zombieId],
			"Only the owner of the zombie can rename it."
		);
		zombies[_zombieId].name = _newName;
	}

	/**
	 * @dev Allows the owner of a zombie to change its dna (if zombie's level >= 20)
	 * @param _zombieId The ID of the zombie to be renamed
	 * @param _newDna The new DNA to be given to the zombie
	 */
	function changeDna(uint256 _zombieId, uint256 _newDna)
		external
		aboveLevel(20, _newDna)
	{
		require(
			msg.sender == zombieToOwner[_zombieId],
			"Only the owner of the zombie can change its dna."
		);
		zombies[_zombieId].dna = _newDna;
	}

	function getZombiesByOwner(address _owner)
		external
		view
		returns (uint256[] memory)
	{
		uint256[] memory result = new uint256[](ownerZombieCount[_owner]);

		uint256 counter = 0;

		for (uint256 i = 0; i < zombies.length; i++) {
			if (zombieToOwner[i] == _owner) {
				result[counter] = i;
				counter++;
			}
		}

		return (result);
	}
}
