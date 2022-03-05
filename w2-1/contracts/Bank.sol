//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract Bank {
    mapping(address=> uint) userSaveCount;



    function saveMoney() public payable {
        userSaveCount[msg.sender] = msg.value;
    }
    
    function withdraw() public {
        payable(msg.sender).transfer(userSaveCount[msg.sender]);
        userSaveCount[msg.sender] = 0;
    }

}

