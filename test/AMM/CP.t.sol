// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;
import "lib/forge-std/src/interfaces/IERC20.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/swap/CP.sol";
import "@hack/staking/erc20.sol";



contract CPTest is Test {

    CP c;
    myToken A;
    myToken B;
    uint256 wad =10*18;

    function setUp() public {
        A=new myToken();
        B=new myToken();
        c=new CP(address(A),address(B));

        A.mint(address(this),21*wad);//10
        B.mint(address(this),42*wad);//20
        B.mint(address(msg.sender),100000*wad);
        //msg.sender.mint(address(this),1*wad);
    }
    function testMint() public {
        console.log(A.balanceOf(address(this)),"befor mint");
        A.mint(address(this),1*wad);
        B.mint(address(this),1*wad);
        //msg.sender.mint(address(this),1*wad);
        console.log(A.balanceOf(address(this)),"after mint");
        assertEq(A.balanceOf(address(this)), 1000*wad);
        assertEq(B.balanceOf(address(this)), 1000*wad);
    }

    function testSwap() public {
        uint amount = 6*wad;
        c.swap(address(A),amount);
        //amountOut=6.666
        assertEq(A.balanceOf(address(this)),26);//15
        assertEq(B.balanceOf(address(this)),34);//14

    }
}


