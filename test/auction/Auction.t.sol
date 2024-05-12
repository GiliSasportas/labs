// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/auction/Auction.sol";
import "lib/forge-std/src/interfaces/IERC20.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "@hack/staking/erc20.sol";
import "@hack/auction/MyERC721.sol";

contract AuctionTest is Test {

    Auction A;
    MyERC721 erc721;
    myToken i;
    uint wad= 10**18;
    string  name = "gili";
    string  symbole = "tamar";
    address ownerNft= vm.addr(111);    
        
    function setUp() public {
        //address ownerNft= vm.addr(111);
        //vm.startPrank(ownerNft);
        i= new myToken();
        erc721=new MyERC721(name,symbole);
        //erc721.approve(address(this) , 1);
        erc721.mint(ownerNft ,1);
        A = new Auction(address(i),address(erc721));
    }

    function testMint() public {
        console.log(i.balanceOf(address(this)),"befor mint");
        i.mint(address(this),10000*wad);
        console.log(i.balanceOf(address(this)),"after mint");
        assertEq(i.balanceOf(address(this)), 10000*wad);

     }

    function testStartAction() public{
        console.log("nnnnnnnnn",erc721.ownerOf(1));
        vm.startPrank(ownerNft);
        erc721.approve(address(A), 1);
        A.startAction(7, ownerNft, 1, 10);
        console.log("balance 1",erc721.balanceOf(address(A)));
        assertEq(erc721.balanceOf(address(A)), 1);
        vm.stopPrank();
    }

    function testSuggest() payable public{
        i.mint(address(this),10000*wad);
        address a=vm.addr(11);
        vm.startPrank(a);
        vm.deal(a,50);
        console.log(a.balance,"value");
        console.log(msg.value, "aaa");
        testStartAction();
        i.approve(address(A), 2000*wad);
        i.approve(a, 2000*wad);
        A.suggest{value:a.balance}();
        assertEq(a.balance, 0);
        vm.stopPrank();
    }

    // function testEndAction() public{
    //     A.endAt();
    //     assertEq(i.balanceOf(address(nft)));
    //     assertEq(i.balanceOf(A.bidAddress().balance));
    // }


}
