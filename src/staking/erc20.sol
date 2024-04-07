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

    function approve(address spender, uint256 amount) external returns (bool){
        allowance[msg.sender][spender]=amount;
        return true;
    }
    

    function transferFrom(address from, address to, uint256 amount) external returns (bool){
        allowance[from][msg.sender]-=amount;
        balanceOf[from]-=amount;
        balanceOf[to]+=amount;
        return true;
    }

    function name() external view returns (string memory){
        return "choin";
    }

    function decimals() external view returns (uint8){
        return 1;
    }


    function symbol() external view returns (string memory){
     return "c";
    }

}

struct User{
    uint sum;
    uint date;
}
contract StakeTogether {
    
    uint256 public rewards=1000000;
    myToken t; 
    mapping(address => User) public staking;
    constructor(address token){
        token=new myToken();
    }

    receive()external payable {}

    function stake(uint amount) public{
        staking[msg.sender].sum+=amount;
        staking[msg.sender].date=block.timestamp();
        t.transfer(address(this), amount);
    }

    function whithdraw(uint amount) public{
        (msg.sender).transfer(amount);
         staking[msg.sender].sum-=amount;


    }

    function getReward() public{
        require(staking[msg.sender].date>block.timestamp()+7 days);
        uint b=(staking[msg.sender].sum/t.totalSupply())*100;
        5000/25000
        
    }

    }
