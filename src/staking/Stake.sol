// SPDX-License-Identifier: MIT
import "lib/forge-std/src/interfaces/IERC20.sol";
import "@hack/staking/erc20.sol";
pragma solidity ^0.8.6;

    struct User{
        uint sum;
        uint date;
    }

    contract Stake {
        myToken i; 
        uint256 public rewards=1000000;
        mapping(address => User) public staking;
    
        constructor(address token){
            i=myToken(token);
            i.mint(address(this), 1000000);
        }

        function stake(uint amount) public{
            staking[msg.sender].sum+=amount;
            staking[msg.sender].date=block.timestamp;
            i.transferFrom(msg.sender,address(this), amount);
        }

        function whithdraw(uint amount) public{   
            i.transfer(msg.sender, amount);//mint-תוקן
            getReward();
            staking[msg.sender].sum-=amount;
          //  staking[msg.sender].sum=0;
        }

        function getReward() public returns (uint256){
            require(staking[msg.sender].date > (block.timestamp +7 days));
            uint256 b=((staking[msg.sender].sum)/(i.balanceOf(address(this))-rewards))*100;   //5000/1000000=0.2  *100  =20
            uint256 t=(rewards*b)/100;  //1000000*       20 /100 = 200000   //*0.02                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
            return t;
        }
}