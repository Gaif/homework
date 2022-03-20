// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile'); 


  // We get the contract to deploy
  const Greeter = await hre.ethers.getContractFactory("MyTokenMarket");


  let routerAddr = "0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0";
  let wethAddr = "0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512";
  let DjangoAdd = "0x08b7faccE7F037E3F0bA1a9Fc0Ce3f0b1DD2F718";


  const greeter = await Greeter.deploy("Hello, Hardhat!");

  await Greeter.deploy(
    DjangoAdd,
    routerAddr,
    wethAddr,
);

  console.log("Greeter deployed to:", greeter.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
