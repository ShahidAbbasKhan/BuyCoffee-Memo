
const hre = require("hardhat");

async function main() {
  const BuyCoffee = await hre.ethers.getContractFactory("BuyCoffee");
  const Buycoffee = await BuyCoffee.deploy();

  await Buycoffee.deployed();

  console.log(
    `Contract is deployed to address: ${Buycoffee.address}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
