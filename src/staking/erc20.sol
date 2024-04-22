// SPDX-License-Identifier: MIT
import "lib/forge-std/src/interfaces/IERC20.sol";
pragma solidity ^0.8.6;


contract myToken is IERC20{

    uint public totalSupply;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;


    function transfer(address to, uint256 amount) external returns (bool){
       balanceOf[msg.sender]-=amount;
       balanceOf[to]+=amount;
       return true;
    }

    function approve(address spender, uint256 amount) external  returns (bool){
        allowance[msg.sender][spender]=amount;
        return true;
    }
    
    function transferFrom(address from, address to, uint256 amount) external returns (bool){
        allowance[from][msg.sender]-=amount;
        balanceOf[from]-=amount;
        balanceOf[to]+=amount;
        return true;
    }
    
    function mint(address to ,uint256 amount)public{
        balanceOf[to] += amount;   
        totalSupply+=amount; 
    }

    function name() external view returns (string memory){
        return "token";
    }

    function decimals() external view returns (uint8){
        return 10;
    }


    function symbol() external view returns (string memory){
     return "token";
    }

}