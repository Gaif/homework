const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Counter", function () {
  it("Should return the new Counter once it's changed", async function () {
    const Counter = await ethers.getContractFactory("Counter");
    const counter = await Counter.deploy(10);
    await counter.deployed();

    //count沒有return值，所有需要修改合約才能測試？？


    
    // expect(await counter.count()).to.equal(11);

    // const setGreetingTx = await counter.set(10);

    // // wait until the transaction is mined
    // await setGreetingTx.wait();

    // expect(await count.set()).to.equal(13);
  });
});
