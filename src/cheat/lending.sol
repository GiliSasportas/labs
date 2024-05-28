// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;
import "lib/forge-std/src/interfaces/IERC20.sol";
contract erc20_{

    IERC20 public constant dai = IERC20(0xFf795577d9AC8bD7D90Ee22b6C1703490b6512FD);
    IERC20 public constant aDai = IERC20(0xdCf0aF9e59C002FA3AA091a46196b37530FD48a8);
    IERC20 public constant aWeth = IERC20(0x87b1f4cf9BD63f7BBD3eE1aD04E8F52540349347);
    IERC20 private constant weth = IERC20(0xd0A1E359811322d97991E03f863a0C30C2cF029C);
    
}