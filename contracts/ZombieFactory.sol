// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

/**
 * @title ZombieFactory
 * @author Thanh-Quy Nguyen
 * @dev A smart contract where zombies are created
 */
contract ZombieFactory {
	event NewZombie(uint256 zombieId, string name, uint256 dna);

	uint256 dnaDigits = 16;
	uint256 dnaModulus = 10**dnaDigits;

	string example = "MyString";
	string example2 = "MyOtherString";

	struct Zombie {
		string name;
		uint256 dna;
	}

	Zombie[] public zombies;

	mapping(uint256 => address) public zombieToOwner;
	mapping(address => uint256) public ownerZombieCount;

	/**
	 * @dev A function that creates a new zombie and adds it to the zombies array
	 * @param _name The name of the new zombie to be added
	 * @param _dna The dna of the new zombie to be added
	 */
	function _createZombie(string memory _name, uint256 _dna) internal {
		zombies.push(Zombie(_name, _dna));
		uint256 id = zombies.length - 1;
		zombieToOwner[id] = msg.sender;
		ownerZombieCount[msg.sender]++;

		emit NewZombie(id, _name, _dna);
	}

	/**
	 * @dev A function that returns a random number modulus dnaModulus
	 * @param _str A string from which the random number is generated
	 */
	function _generateRandomDna(string memory _str)
		private
		view
		returns (uint256)
	{
		uint256 rand = uint256(keccak256(abi.encodePacked(_str)));

		return rand % dnaModulus;
	}

	/**
	 * @dev A public function that will create a zombie with random dna from a given name
	 * @param _name The name of the zombie to be created
	 */
	function createRandomZombie(string memory _name) public {
		require(
			ownerZombieCount[msg.sender] == 0,
			"This user has already created a Zombie"
		);
		uint256 randDna = _generateRandomDna(_name);

		_createZombie(_name, randDna);
	}
}
