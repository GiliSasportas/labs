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
        t= new myToken();//IERC20
        s = new Stake(address(t));//STAKE
    }

    function testMint() public {
        t.mint(address(this),1000);
        assertEq(t.balanceOf(address(this)), 1000);
     }

    function testStake() public{
        console.log("log",address(this),address(s));
        t.mint(address(this),100); 
        t.approve(address(s), 50);//מסכים ל-stake למשוך 50
        s.stake(50);
        assertEq(t.balanceOf(address(this)), 50);
    }

    function testwithdraw() public{
        t.mint(address(this),100); 
        t.approve(address(s), 50);//מסכים ל-stake למשוך 50
        s.stake(50);
        //t.transfer(s.staking[msg.sender].sum,100);
       // uint256 b=s.staking[msg.sender].sum;
        uint256 b= t.balanceOf(address(this));
        console.log(b,"bbbbbb");
        assertEq(t.balanceOf(address(this)), 50);
        s.whithdraw(50);
        uint256 c= t.balanceOf(address(this));

        // uint256 bafter=s.staking[msg.sender].sum;
        // console.log(b,"b",bafter,"bafter");
        assertEq(t.balanceOf(address(this)), b-50);
    }


    


}