//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DaoToken is ERC20 {
    constructor() ERC20("DaoToken", "TK") {
        _mint(msg.sender, 10 * 10**uint256(decimals()));
    }
}