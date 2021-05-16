const { expect } = require("chai");

require("chai").should();
const { expectRevert } = require("@openzeppelin/test-helpers");

const ZombieFactory = artifacts.require("ZombieFactory");

contract("ZombieFactory", function ([user0]) {
	beforeEach(async () => {
		this.ZombieFactory = await ZombieFactory.new();
	});

	describe("Creating zombies", () => {
		it("should emit an event and create a zombie", async () => {
			await this.ZombieFactory.createRandomZombie("Jacques");

			const zombie = await this.ZombieFactory.zombies.call([0]);
			zombie.name.should.equal("Jacques");
		});

		it("should not be allowed twice in a row by the same user", async () => {
			await this.ZombieFactory.createRandomZombie("Jacques", { from: user0 });
			await expectRevert(
				this.ZombieFactory.createRandomZombie("Jacques", { from: user0 }),
				"This user has already created a Zombie"
			);
		});
	});
});
