// SPDX-License-Identifier: MIT
import "lib/forge-std/src/interfaces/IERC20.sol";
import "@hack/staking/erc20.sol";
pragma solidity ^0.8.6;
contract swap{

    myToken tokenA;
    myToken tokenB;
    uint256 public balanceA;//10  +1 
    uint256 public balanceB;//10
    address owner;
    uint256 public k;
    uint256 wad = 10*18;

    constructor(address _tokenA,a
    ddress t_okenB){
        owner=msg.sender;
        tokenA=myToken(_tokenA);
        tokenB=myToken(_tokenB);
  
    }
    function price() public returns (uint256){
       return balanceB*wad/balanceA*wad;//   10/11 = 0.909090
    }

    function tradeAToB(uint256 amountA) public {
        require(amountA>0);
        balanceA+=amountA;
        uint256 decreaseB = amountA * price();  //1*0.9090
        tokenA.transfer(address(this), amountA);
        tokenA.transferFrom(address(this),msg.sender , decreaseB);
        balanceB-=decreaseB;
    }

    function tradeBToA(uint256 amountB) public {
        require(amountB>0);
        balanceB+=amountB;
        uint256 decreaseA = amountB * price();  
        tokenB.transfer(address(this), amountB);
        tokenB.transferFrom(address(this),msg.sender , decreaseA);
        balanceA-=decreaseA;
    }

    function addLiquidity(uint256 amount) public{\
        require(amount>0);
        uint256 sum = amount * price();
        tokenA.transfer(address(this),amount);
        tokenB.transfer(address(this),sum);
    }



}