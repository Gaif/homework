const { ethers, network } = require("hardhat");
// const delay = require('./delay');


async function main() {

    let [owner, second] = await ethers.getSigners();

    let myerc20 = await ethers.getContractAt("Django",
    '0x08b7faccE7F037E3F0bA1a9Fc0Ce3f0b1DD2F718',
        owner);

    await myerc20.transfer('0xd773983c23beb4d7d90052a0c4d63c785442e0f2', 1000);
}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });


  // duration = 60;
  // await delay.advanceTime(ethers.provider, duration); 
  // await delay.advanceBlock(ethers.provider);