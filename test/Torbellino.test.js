const { expect } = require("chai");

describe("Torbellino Contract", () => {

  let torbellino; 

  before(async () => {
    const Torbellino = await ethers.getContractFactory("Torbellino");
    torbellino = await Torbellino.deploy();
    await torbellino.deployed();
  });

  it("Torbellino Initial Balance", async () => {
    const totalBalance = await torbellino.getTotalBalance();
    expect(totalBalance).to.be.equal(0);
  });

});