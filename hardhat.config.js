require("@nomiclabs/hardhat-waffle");

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
/*
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});
*/

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.4",
  networks: {
  	rinkeby: {
  		url: 'https://eth-rinkeby.alchemyapi.io/v2/tHlZBpF7w4auwpPbfizzq2ot-klvx79p',
  		accounts: ['32c7ecb27c5625ad87330de33dc2877bd471c8e8f7ebdce6be7f0c9aa307b1e4']
  	}
  }
};
