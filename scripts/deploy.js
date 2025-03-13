const hre = require("hardhat");

async function main() {
    const forwarderAddress = "0x1ae3fC838C97663FDeA8Bcb5a470cb344B9478CF";

    const StudentRegistry = await hre.ethers.deployContract("StudentRegistry", [forwarderAddress]);
    await StudentRegistry.waitForDeployment();

    console.log("StudentRegistry deployed to:", await StudentRegistry.getAddress());
}

main().catch((error) => {
    console.error(error);
    process.exit(1);
});
