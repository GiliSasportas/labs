// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;
import "lib/forge-std/src/interfaces/IERC20.sol";

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/swap/Swap.sol";
import "@hack/staking/erc20.sol";


contract SwapTest is Test {

    Swap s;
    myToken A;
    myToken B;
    uint256 wad =10*18;
1
    function setUp() public {
        A=new myToken();
        B=new myToken();
        s=new Swap(address(A),address(B));

    }

      function testMint() public {
        console.log(A.balanceOf(address(this)),"befor mint");
        A.mint(address(this),1000*wad);
        B.mint(address(this),1000*wad);
        console.log(A.balanceOf(address(this)),"after mint");
        assertEq(A.balanceOf(address(this)), 1000*wad);
        assertEq(B.balanceOf(address(this)), 1000*wad);

     }

     function testTradeAToB() public{
        console.log(11111);
        A.mint(address(this),100000*wad);
        B.mint(address(this),100000*wad);
        A.mint(address(msg.sender),100000*wad);
        B.mint(address(msg.sender),100000*wad);
        A.transfer(address(msg.sender), 100*wad);
        B.transfer(address(msg.sender), 100*wad);
        console.log(B.balanceOf(address(msg.sender)), "1122");
        uint256 amount=100;
        uint256 before= A.balanceOf(address(this));
        A.approve(address(s), amount * wad);
        s.tradeAToB(amount*wad);
       // console.log(A.balanceOf(address(s)),"loggggg");
        //assertEq(s.balanceA(), amount);
       // assertEq(A.balanceOf(address(s)), before+amount);
     }

}