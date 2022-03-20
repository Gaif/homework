//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./IUniswapV2Router01.sol";
import "./MasterChef.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract MyTokenMarket {


    using SafeERC20 for IERC20;

    address DjangoToken;
    address router;
    address weth;
    address chef;

    constructor(address _DjangoToken,address _router,address _weth,address _chef) {
        DjangoToken = _DjangoToken;
        router = _router;
        weth = _weth;
        chef = _chef;
    }


    //转入Django币
    function AddLiquidity(uint tokenAmount) external payable {
        IERC20(DjangoToken).safeTransferFrom(msg.sender,address(this),tokenAmount);
        IERC20(DjangoToken).safeApprove(router, tokenAmount);
       IUniswapV2Router01(router).addLiquidityETH{value:msg.value}(DjangoToken,tokenAmount,0,0,msg.sender,block.timestamp);
    }

    function buyToken(uint miniTokenAmount) external payable {
    
    address[] memory path = new address[](2);

    path [0] = weth;
    path [1] = DjangoToken;

    IUniswapV2Router01(router).swapExactETHForTokens{value:msg.value}(miniTokenAmount,path, msg.sender, block.timestamp);

    //买完之后去sushi质押当前Django币 现授权
 
    IERC20(DjangoToken).safeApprove(chef, tokenAmount);

    MasterChef(chef).deposit(MasterChef(chef).poolInfo[-1], tokenAmount);

    }

    function withDraw (uint tokenAmount) public {
        MasterChef(chef).withdraw(MasterChef(chef).poolInfo[-1], tokenAmount);
    }



}


