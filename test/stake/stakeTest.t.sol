// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/staking/Stake.sol";
import "@hack/staking/erc20.sol";


contract StakeTest is Test {
    Stake  s;
    myToken  t;


    function setUp() public {
        t= new myToken();
        s = new Stake(address(t));
    }

    function testMint() public {
        t.mint(address(this),1000);
        assertEq(t.balanceOf(address(this)), 1000);
     }

    function testStake() public{
        t.mint(address(this),100); 
        t.approve(address(s), 50);
        s.stake(50);
        assertEq(t.balanceOf(address(this)), 50);
    }


    // function stake(uint amount) public{
    //         staking[msg.sender].sum+=amount;
    //         staking[msg.sender].date=block.timestamp;
    //         i.transferFrom(msg.sender,address(this), amount);
    //     }


}