// SPDX-License-Identifier: MIT
import "lib/forge-std/src/interfaces/IERC20.sol";
import "@hack/staking/erc20.sol";
pragma solidity ^0.8.6;

    struct User{
        uint sum;
        uint date;
    }
    

    contract Stake {
        uint wad=18*10;
        myToken i; 
        uint256 public rewards=1000000;
        mapping(address => User) public staking;
    
        constructor(address token){
            i=myToken(token);
            i.mint(address(this), 1000000);
        }

        function stake(uint amount) public{
            require(amount > 0 ,"It is impossible to stake this amount");
            staking[msg.sender].sum+=amount;
            staking[msg.sender].date=block.timestamp;
            i.transferFrom(msg.sender,address(this), amount);
        }


        function whithdraw() public{  
            uint amount=staking[msg.sender].sum;
            amount+=getReward();
            rewards-=getReward();
            i.transfer(msg.sender, amount);
            staking[msg.sender].sum=0;
        
        }


        function getReward() public returns (uint256){
            require((staking[msg.sender].date) + 7 days <= ( block.timestamp ),"cannot withdraw before 7 days have passed");
            uint rewardUser=((staking[msg.sender].sum *wad)/(i.balanceOf(address(this))- rewards )) * rewards * 2 / 100 / wad;   //5000/1000000=0.2  *100  =20
            return rewardUser;
        
        }

}
