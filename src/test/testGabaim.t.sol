// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/wallet/Gabaim.sol";


contract testGabaim is Test {
    Gabaim public wallet;


    function setUp() public {
        wallet = new Gabaim();
    }

    function testgetBalance() view public{
        uint balanceOwner = wallet.getBalance();
         assert(balanceOwner==address(wallet).balance);
    }

    function testWithdraw() public{
        
        payable(wallet).transfer(100);
        uint balances= wallet.getBalance();
        //uint sum=100;
        wallet.addGabay(vm.addr(1));
        vm.prank(vm.addr(1));
        wallet.withdraw(50);
        assertEq(wallet.getBalance(), balances - 50,"withdraw failed");   
    }

    function testDeposite() payable public {
      uint initialBalance = wallet.getBalance(); 
      uint sum=10;
      payable(wallet).transfer(sum);
      assertEq(wallet.getBalance(), initialBalance + sum, "Balance should increase by num after transfer");
    }

    function testAddGabay() public{
        wallet.addGabay(address(1));
        assertEq(wallet.countGabaim(),1);
        assertEq(wallet.owners(address(1)),true);
    }

    function testHaveTreeGabaim() public{
        wallet.addGabay(address(1));
        wallet.addGabay(address(2));
        wallet.addGabay(address(3));
        assertEq(wallet.countGabaim(),3);
        vm.expectRevert();
        wallet.addGabay(address(4));     
    }

}