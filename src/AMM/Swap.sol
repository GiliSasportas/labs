// SPDX-License-Identifier: MIT
import "lib/forge-std/src/interfaces/IERC20.sol";
import "@hack/staking/erc20.sol";
import "forge-std/console.sol";
pragma solidity ^0.8.6;
contract Swap{
    uint256 wad = 10*18;
    myToken tokenA;
    myToken tokenB;
    uint256 public balanceA=1000 * wad;
    uint256 public balanceB=1000 * wad;
    address owner;
    //uint256 public k;
    
    mapping(address => uint256) public Provides_liquidity;

    constructor(address _tokenA,address _tokenB){
        owner=msg.sender;
        tokenA=myToken(_tokenA);
        tokenB=myToken(_tokenB);
  
    }
    function priceA() public returns (uint256){
           return balanceB*wad/balanceA*wad;
    }
      function priceB() public returns (uint256){
        return balanceA*wad/balanceB*wad;
    }


    function tradeAToB(uint256 amountA) public {
        require(amountA>0);
        uint256 decreaseB = amountA * priceA();  
        console.log(decreaseB,"123");
        tokenA.transferFrom(msg.sender, address(this) , amountA); 
        balanceA+=amountA;
        tokenB.transfer(msg.sender, decreaseB);
        balanceB-=decreaseB;
    }

    function tradeBToA(uint256 amountB) public {
        require(amountB>0);
        balanceB+=amountB;
        uint256 decreaseA = amountB * priceB();  
        tokenB.transferFrom(msg.sender ,address(this), amountB);
        tokenB.transfer(msg.sender, decreaseA);
        balanceA-=decreaseA;
    }

    function addLiquidity(uint256 amount,uint256 type_AorB) public{
        uint256 sum ;
        require(amount>0);
        require(type_AorB==1 || type_AorB==0);
        if(type_AorB==1){
             sum = amount * priceA();
        }
        else{
             sum = amount * priceB();
        }
        Provides_liquidity[msg.sender]+=amount;
        tokenA.transfer(address(this),amount);
        tokenB.transfer(address(this),sum);
        balanceA+=amount;
        balanceB+=sum;
    }

    function removeLiquidity(uint256 amount,uint256 type_AorB )public {
        uint256 sum ;
        require(type_AorB==1 || type_AorB==0);
        require(amount>0,"amount must be greater than zero");
        require(Provides_liquidity[msg.sender]>=amount,"you dont enough money");
          if(type_AorB==1){
           sum= amount * priceA();
        }
        else{
             sum = amount * priceB();
        }
        Provides_liquidity[msg.sender]-=amount;
        tokenA.transfer(msg.sender,amount);
        tokenB.transfer(msg.sender,sum);
        balanceA-=amount;
        balanceB-=sum;
    }

  
}