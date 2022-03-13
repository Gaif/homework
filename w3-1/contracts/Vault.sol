//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Vault {
    mapping(address => uint) public deposited;
    address public immutable token;

    constructor(address _token) {
        token = _token;
    }

    function deposit(uint amount) public {
        require(IERC20(token).transferFrom(msg.sender, address(this), amount), "Transfer from error");
        deposited[msg.sender] += amount;
    }

    function withDraw(uint amount) public {
        require(deposited[msg.sender] <= amount);
        require(IERC20(token).transferFrom(address(this), msg.sender, amount), "Transfer from error");
        deposited[msg.sender] -= amount;
    }



}
