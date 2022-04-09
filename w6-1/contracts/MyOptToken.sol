//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";



contract MyOptToken is ERC20, Ownable {
  using SafeERC20 for IERC20;

  uint public price;  //价格
  address public udscToken; 
  uint public settlementTime;
  uint public constant during = 1 days; // 过期时间

  constructor(address usdc) ERC20("MyCallOptToken", "Django") {
    udscToken = usdc;
    price = 1000; // 价格
    settlementTime =block.timestamp + 100 days;  //行权时间
  }


  //购买token
  function mint() external payable onlyOwner {
    _mint(msg.sender, msg.value*100);//1eth购买100token
  }

  //行权
  function settlement(uint amount) external {
    //判断是否过期
    require(block.timestamp >= settlementTime && block.timestamp < settlementTime + during, "invalid time");

    //销毁
    _burn(msg.sender, amount);

    uint needUsdcAmount = price * amount;
    //收到usdc
    IERC20(udscToken).safeTransferFrom(msg.sender, address(this), needUsdcAmount);
    //返回eth
    safeTransferETH(msg.sender, amount);
  }

  function safeTransferETH(address to, uint256 value) internal {
    (bool success, ) = to.call{value: value}(new bytes(0));
    require(success, 'TransferHelper::safeTransferETH: ETH transfer failed');
  }

  //期权过期，全部销毁
  function burnAll() external onlyOwner {
    require(block.timestamp >= settlementTime + during, "not end");
    uint usdcAmount = IERC20(udscToken).balanceOf(address(this));
    IERC20(udscToken).safeTransfer(msg.sender, usdcAmount);


    selfdestruct(payable(msg.sender));
    // uint ethAmount = address(this).balance;
    // safeTransferETH(msg.sender, ethAmount);
  }


}