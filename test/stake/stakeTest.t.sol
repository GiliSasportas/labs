// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/staking/Stake.sol";
import "@hack/staking/erc20.sol";


contract StakeTest is Test {
    Stake  s;
    myToken  t;

    uint wad=18**10;


    function setUp() public {
        t= new myToken();//IERC20
        s = new Stake(address(t));//STAKE
    }

    function testMint() public {
        console.log(t.balanceOf(address(this)),"befor mint");
        t.mint(address(this),1000);
        console.log(t.balanceOf(address(this)),"after mint");
        assertEq(t.balanceOf(address(this)), 1000);
     }

    function testStake() public{
        console.log("log",address(this),address(s));
        t.mint(address(this),100); 
        t.approve(address(s), 50);
        console.log(t.balanceOf(address(this)),"befor stack");
        s.stake(50);
        assertEq(t.balanceOf(address(this)), 50);
        assertEq(t.balanceOf(address(s)), 1000050);
    }

    function testwithdraw() public{
        t.mint(address(this),1000); 
        t.approve(address(s), 50);
        s.stake(50);
        assertEq(t.balanceOf(address(this)), 950);
        vm.warp(block.timestamp + 7 days);
        s.whithdraw();
        assertEq(t.balanceOf(address(this)), 1000 +20000 );
        assertEq(s.rewards(),980000);
    }

    function testwithdrawBefor7Days() public{
        t.mint(address(this),1000); 
        t.approve(address(s), 50);
        s.stake(50);
        vm.warp(block.timestamp + 3 days);
        vm.expectRevert("cannot withdraw before 7 days have passed");
        s.whithdraw();
    }

     function testwithdrawMoreOneUser() public{

     }



  
}