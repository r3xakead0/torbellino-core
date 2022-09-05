const deploy = async () => {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contract with the account:", deployer.address);

  const Torbellino = await ethers.getContractFactory("Torbellino");
  const deployed = await Torbellino.deploy();

  console.log("Torbellino is deployed at:", deployed.address);
};

deploy()
  .then(() => process.exit(0))
  .catch((error) => {
      console.log(error);
      process.exit(1);
});