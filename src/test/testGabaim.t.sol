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
        uint balances= wallet.getBalance();
       //assert.isTrue(address(wallet),true,"you can not withdraw");
         wallet.withdraw(100);
        assertEq(wallet.getBalance(), balances - 100,"withdraw failed");   
    }

    function testDeposite() payable public {
      uint initialBalance = wallet.getBalance(); 
      payable(wallet).transfer(10);
      assertEq(wallet.getBalance(), initialBalance + 10, "Balance should increase by num after transfer");
    }

}