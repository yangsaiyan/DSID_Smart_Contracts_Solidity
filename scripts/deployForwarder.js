const hre = require("hardhat");

async function main() {
    const Forwarder = await hre.ethers.deployContract("MinimalForwarder");
    await Forwarder.waitForDeployment();

    console.log("MinimalForwarder deployed to:", await Forwarder.getAddress());
}

main().catch((error) => {
    console.error(error);
    process.exit(1);
});
