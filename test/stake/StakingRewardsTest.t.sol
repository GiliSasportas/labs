// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/staking/StakingRewards.sol";
import "@hack/staking/erc20.sol";


contract StakingRewardsTest is Test {

    StakingRewards s;
    myToken  rt;
    myToken  st;
    uint wad =10**18;

    function setUp() public {
        rt= new myToken();//IERC20
        s = new StakingRewards(address(st),address(rt));//STAKE
    }


    function testMint() public {
        console.log(st.balanceOf(address(this)),"befor mint");
        st.mint(address(this),1000*wad);
        console.log(st.balanceOf(address(this)),"after mint");
        assertEq(st.balanceOf(address(this)), 1000*wad);
     }

    function testStake() public{
        console.log("log",address(this),address(s));
        st.mint(address(this),100*wad); 
        st.approve(address(s), 50*wad);
        s.stake(50*wad);
        assertEq(st.balanceOf(address(this)), 150*wad);//מי שעשה stake-?
        assertEq(st.balanceOf(staked()), 1000050*wad);//


    }


    function test




}