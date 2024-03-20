// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/wallet/Gabaim.sol";


contract testGabaim is Test {
    Owner public wallet;

    function setUp() public {
        wallet = new Owner();
    }

//משיכה
       function testWithdraw() public{
        uint balances= address(wallet).balance;
        uint sumWithdraw=100 ;
       //assert.isTrue(address(wallet),true,"you can not withdraw");
         wallet.withdraw(sumWithdraw);
        assertEq(address(wallet).balance, balances - sumWithdraw,"withdraw failed");   
         }

    function testgetBalance() view public{
        uint balanceOwner = wallet.getBalance();
         assert(balanceOwner==address(wallet).balance);
    }

//הפקדה

function testReceive() payable public {
      uint num = 50; 
      uint initialBalance = wallet.getBalance(); 
      payable(wallet).transfer(10);
      assertEq(wallet.getBalance(), initialBalance + num, "Balance should increase by num after transfer");
      wallet.withdraw(2);
     }

}