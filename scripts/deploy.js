const hre = require("hardhat");

async function main() {
  const trustedForwarder = "0xDe45b01d5eFB1d30F4ccF65B39056a6aC78Ca81c";
  const StudentRegistry = await hre.ethers.getContractFactory("StudentRegistry");
  const studentRegistry = await StudentRegistry.deploy(trustedForwarder);

  await studentRegistry.waitForDeployment();
  const contractAddress = await studentRegistry.getAddress();

  console.log("Contract deployed at:", contractAddress);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
