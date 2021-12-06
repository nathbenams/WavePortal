// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {

	uint256 totalWaves;
	mapping(address => uint8) public countAddress;

	event NewWave(address indexed from, uint256 timestamp, string message);

	uint256 private seed;

	mapping(address => uint256) public lastWave;

	struct Wave {
		address waver;
		string message;
		uint256 timestamp;
	}

	Wave[] waves;

    constructor() payable {
        console.log("The contract is created");
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function wave(string memory _message) public {

    	require(lastWave[msg.sender] + 15 minutes < block.timestamp, "Wait 15 mn");

    	lastWave[msg.sender] = block.timestamp;
    	totalWaves += 1;
    	countAddress[msg.sender] += 1;
    	console.log("%s has waved with the message %s", msg.sender, _message);

    	waves.push(Wave(msg.sender, _message, block.timestamp));

    	seed = (block.timestamp + block.difficulty + seed) % 100;

    	console.log("Random # generated: %d", seed);

    	if(seed <= 50) {
    		console.log("%s won!!", msg.sender);
    		uint256 prizeAmount = 0.0001 ether;
    		require(
    			prizeAmount <= address(this).balance,
    			"The contract does not have funds"
    		);
    		(bool success, ) = (msg.sender).call{value: prizeAmount}("");
    		require(success, " Failed to withdraw prize.");
    	}

    	emit NewWave(msg.sender, block.timestamp, _message);

    	
    }

    function getTotalWaves() public view returns (uint256){
    	console.log("We have %d total waves!", totalWaves);
    	return totalWaves;
    }

    function getAddressWaves() public view returns (uint8){
    	console.log("The address %s has waved %d times", msg.sender, countAddress[msg.sender]);
    	return countAddress[msg.sender];
    }

    function getAllWaves() public view returns (Wave[] memory) {
    	return waves;
    }
}