// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.6.12;


import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router01.sol";
import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Pair.sol";
import "@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol";
import "@uniswap/v3-core/contracts/libraries/LowGasSafeMath.sol";

import { FlashLoanReceiverBase } from "./FlashLoanReceiverBase.sol";
import { ILendingPool, ILendingPoolAddressesProvider, IERC20 } from "./Interfaces.sol";
import { SafeMath } from "./Libraries.sol";


contract HomeWork is FlashLoanReceiverBase {
    using SafeMath for uint256;
    
    address public usdcAddr = 0xe22da380ee6B445bb8273C81944ADEB6E8450422;
 
    address public aaveaddr = address(0x88757f2f99175387aB4C6a4b3067c77A695b0349);
    address immutable routerV2;
    address immutable routerV3;


    constructor(ILendingPoolAddressesProvider _addressProvider, address _routerV2,
        address _routerV3) FlashLoanReceiverBase(_addressProvider) public {
        routerV2 = _routerV2;
        routerV3 = _routerV3;
    }

    /**
        This function is called after your contract has received the flash loaned amount
     */
    function executeOperation(
        address[] calldata assets,
        uint256[] calldata amounts,
        uint256[] calldata premiums,
        address initiator,
        bytes calldata params
    )
        external
        override
        returns (bool)
    {

        path[0] = assets;
        path[1] = usdcAddr;

        IERC20 tokenA = IERC20(assets);
        
        tokenA.approve(routerV2, amount);

        IUniswapV2Router01(routerV2).swapExactTokensForTokens(
            amount,
            0,
            path,
            address(this),
            block.timestamp
        );

        uint256 amountReceived = usdcAddr.balanceOf(address(this));
        assert(amountReceived > amountRequired);

        uint256 amountMin = LowGasSafeMath.add(amount, MEDIUMFREE);
        usdcAddr.approve(routerV3, amountReceived);
        uint256 amountOut = ISwapRouter(routerV3).exactInputSingle(
            ISwapRouter.ExactInputSingleParams({
                tokenIn: path[1],
                tokenOut: path[0],
                fee: 3000,
                recipient: address(this),
                deadline: block.timestamp,
                amountIn: amountReceived,
                amountOutMinimum: amountMin,
                sqrtPriceLimitX96: 0
            })
        );



        // 还款的时候需要授权所有token
        for (uint i = 0; i < assets.length; i++) {
            uint amountOwing = amounts[i].add(premiums[i]);
            IERC20(assets[i]).approve(address(LENDING_POOL), amountOwing);
        }

        return true;
    }

  
}