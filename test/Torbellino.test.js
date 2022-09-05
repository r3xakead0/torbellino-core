const { expect } = require("chai");

describe("Torbellino Contract", () => {

  let torbellino; 
  let memo;

  before(async () => {
    const Torbellino = await ethers.getContractFactory("Torbellino");
    torbellino = await Torbellino.deploy();
    await torbellino.deployed();
  });

  it("Total Initial Balance is 0", async () => {
    const totalBalance = await torbellino.getTotalBalance();
    expect(totalBalance).to.be.equal(0);
  });

});