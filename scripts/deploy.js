const deploy = async () => {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contract with the account:", deployer.address);

  const PlatziPunks = await ethers.getContractFactory("Torbellino");
  const deployed = await PlatziPunks.deploy();

  console.log("Torbellino is deployed at:", deployed.address);
};

deploy()
  .then(() => process.exit(0))
  .catch((error) => {
      console.log(error);
      process.exit(1);
});