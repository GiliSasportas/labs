// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/wallet/Collectors.sol";


contract testCollectors is Test {


    Collectors public wallet;


    function setUp() public {
        wallet = new Collectors();
    }

    function testgetBalance() view public{
        uint balanceOwner = wallet.getBalance();
         assert(balanceOwner==address(wallet).balance);
    }

    function testWithdraw() public{ 
        payable(wallet).transfer(100);
        uint balances= wallet.getBalance();
        address addC=vm.addr(20);
        wallet.addCollector(addC);
        vm.prank(addC);
        wallet.withdraw(50);
        assertEq(wallet.getBalance(), balances - 50,"withdraw failed");   

    }

    function testDeposite() payable public {
        uint initialBalance = wallet.getBalance(); 
        uint sum=10;
        payable(wallet).transfer(sum);
        assertEq(wallet.getBalance(), initialBalance + sum, "Balance should increase by num after transfer");
    }

    function testaddCollector() public{
        wallet.addCollector(address(10));
        assertEq(wallet.countCollectors(),1);
        assertEq(wallet.collectors(address(10)),true);
    }

    function testHaveTreeCollectors() public{
        wallet.addCollector(address(6));
        wallet.addCollector(address(8));
        wallet.addCollector(address(11));
        assertEq(wallet.countCollectors(),3);
        vm.expectRevert();
        wallet.addCollector(address(2));     
    }

    function testchangeCollector() public{
        //before change
        wallet.addCollector(address(4));
        assertEq(wallet.collectors(address(4)),true);
        assertEq(wallet.collectors(address(3)),false);
        wallet.changeCollector(address(4),address(3));
        //after change
        assertEq(wallet.collectors(address(4)),false);
        assertEq(wallet.collectors(address(3)),true);

    }

    function tesFaildtchangeCollector() public {
        wallet.addCollector(address(4));
        vm.expectRevert();
        wallet.changeCollector(address(5),address(3));
     

    }

}