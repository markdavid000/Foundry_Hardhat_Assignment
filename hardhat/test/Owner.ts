import { expect } from "chai";
import { ethers } from "hardhat";
import { Owner } from "../typechain-types/Owner";

describe("Owner Contract", function () {
  let ownerContract: Owner;
  let deployer: any;
  let addr1: any;
  let addr2: any;

  beforeEach(async () => {
    [deployer, addr1, addr2] = await ethers.getSigners();

    const OwnerFactory = await ethers.getContractFactory("Owner");
    ownerContract = (await OwnerFactory.deploy()) as Owner;
  });

  // -------------------------------------------------------------
  // 1. Deployment tests
  // -------------------------------------------------------------
  it("Should set the deployer as the initial owner", async () => {
    const currentOwner = await ownerContract.getOwner();
    expect(currentOwner).to.equal(deployer.address);
  });

  it("Should emit OwnerSet event on deployment", async () => {
    const OwnerFactory = await ethers.getContractFactory("Owner");

    const tx = await OwnerFactory.deploy();
    const receipt = await tx.deploymentTransaction()?.wait();

    // Decode event
    const event = receipt!.logs
      .map((log) => {
        try {
          return OwnerFactory.interface.parseLog(log);
        } catch {
          return null;
        }
      })
      .find((parsed) => parsed && parsed.name === "OwnerSet");

    expect(event).to.not.be.undefined;
    expect(event!.args.oldOwner).to.equal(ethers.ZeroAddress);
    expect(event!.args.newOwner).to.equal(deployer.address);
  });

  // -------------------------------------------------------------
  // 2. getOwner tests
  // -------------------------------------------------------------
  it("Should return the correct owner", async () => {
    expect(await ownerContract.getOwner()).to.equal(deployer.address);
    console.log(deployer.address);
  });

  // -------------------------------------------------------------
  // 3. changeOwner positive cases
  // -------------------------------------------------------------
  it("Owner should be able to change owner", async () => {
    await ownerContract.changeOwner(addr1.address);
    expect(await ownerContract.getOwner()).to.equal(addr1.address);
  });

  it("Should emit OwnerSet event on owner change", async () => {
    await expect(ownerContract.changeOwner(addr1.address))
      .to.emit(ownerContract, "OwnerSet")
      .withArgs(deployer.address, addr1.address);
  });

  // -------------------------------------------------------------
  // 4. changeOwner negative cases
  // -------------------------------------------------------------
  it("Should revert if non-owner tries to change owner", async () => {
    await expect(
      ownerContract.connect(addr1).changeOwner(addr2.address)
    ).to.be.revertedWith("Caller is not owner");
  });

  it("Should revert if new owner is zero address", async () => {
    await expect(
      ownerContract.changeOwner(ethers.ZeroAddress)
    ).to.be.revertedWith("New owner should not be the zero address");
  });

  // -------------------------------------------------------------
  // 5. Ownership transfer edge case
  // -------------------------------------------------------------
  it("New owner should be able to change ownership again", async () => {
    await ownerContract.changeOwner(addr1.address);

    await expect(ownerContract.connect(addr1).changeOwner(addr2.address))
      .to.emit(ownerContract, "OwnerSet")
      .withArgs(addr1.address, addr2.address);

    expect(await ownerContract.getOwner()).to.equal(addr2.address);
  });
});
