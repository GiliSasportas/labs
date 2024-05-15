// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/auction/auction.sol";
import "lib/forge-std/src/interfaces/IERC20.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "@hack/staking/erc20.sol";
import "@hack/auction/myERC721.sol";

contract AuctionTest is Test {

    Auction A;
    MyERC721 erc721;
    myToken i;
    uint wad= 10**18;
    string  name = "gili";
    string  symbole = "tamar";
    address ownerNft= vm.addr(111);    
        
    function setUp() public {
        i= new myToken();
        erc721=new MyERC721(name,symbole);
        A = new Auction(address(i),address(erc721));
    }

    function testMint() public {
        console.log(i.balanceOf(address(this)),"befor mint");
        i.mint(address(this),10000*wad);
        console.log(i.balanceOf(address(this)),"after mint");
        assertEq(i.balanceOf(address(this)), 10000*wad);

    }

    function testStartAction() public{
        vm.startPrank(ownerNft);
        start();
        A.startAction(7, ownerNft, 1, 10);
        assertEq(erc721.balanceOf(address(A)), 1);
        vm.stopPrank();
    }

    function testSuggest() payable public{
        testStartAction();
        address a=vm.addr(11);
        vm.startPrank(a);
        console.log();
        vm.deal(a,100);
        suggest();
        A.suggest(100);
        assertEq(i.balanceOf(a), 0);
        assertEq(A.bidAddress(), a);
        assertEq(A.maxBid(), 100);
        vm.stopPrank();
    }

    function suggest() public{
        i.mint(address(this),10000*wad);
        i.approve(address(A), 2000*wad);
   
    }

    function start() public{
        erc721.mint(ownerNft ,1);
        erc721.approve(address(A), 1);
    }


}
