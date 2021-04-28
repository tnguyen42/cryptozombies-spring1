const { expect } = require("chai");

require("chai").should();

const ZombieFactory = artifacts.require("ZombieFactory");

contract("ZombieFactory", function ([]) {
	beforeEach(async () => {
		this.ZombieFactory = await ZombieFactory.new();
	});

	describe("Creating zombies", () => {
		it("should emit an event and create a zombie", async () => {
			await this.ZombieFactory.createRandomZombie("Jacques");

			const zombie = await this.ZombieFactory.zombies.call([0]);
			zombie.name.should.equal("Jacques");
		});
	});
});
