require("chai").should();

const ZombieFactory = artifacts.require("ZombieFactory");

contract("ZombieFactory", function ([_]) {
	beforeEach(async () => {
		this.ZombieFactory = await ZombieFactory.new();
	});

	describe("Creating zombies", () => {
		it("should emit an event and create a zombie", async () => {
			await this.ZombieFactory.createRandomZombie("Jacques");
		});
	});
});
