// SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

contract Counter {
    uint public counter;

    constructor(uint x) {
        counter = x;
    }

    function count() public {
        counter++;
    }

    function set(uint x) public {
        counter = counter + x;
    }
    

}