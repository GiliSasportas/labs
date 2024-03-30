// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/wallet/Gabaim.sol";


contract fuzztestGabaim is Test {

    Gabaim public wallet;

    function setUp() public {
      wallet = new Gabaim();
    }

    function testDeposite(uint256 sum) public {
      uint initialBalance = wallet.getBalance();
      address ad=vm.addr(20);
      vm.startPrank(ad);
      vm.deal(ad,sum);
      payable(wallet).transfer(sum);
      assertEq(wallet.getBalance(), initialBalance + sum, "Balance should increase by num after transfer");
      vm.stopPrank();
    }

    // function testWithdraw(uint256 sum) payable public {
    //   console.log("sum",sum);
    //   console.log("in whithdraw");
    //   payable(wallet).transfer(100000000000);
    //   uint balances = wallet.getBalance();
    //   console.log("balances",balances);
    //   address ad = vm.addr(12);
    //   wallet.addGabay(ad);
     
    
    //   vm.prank(ad);
    //   require(sum<balances);
    //   wallet.withdraw(sum);
    //   console.log("balances2",balances);
    //   assertEq(wallet.getBalance(),balances-sum);
      
      
    // }


 function testWithdraw(uint256 sum) public{ 
  cp
        payable(wallet).transfer(100);
        uint balances= wallet.getBalance();
        address add=vm.addr(20);
        wallet.addGabay(add);
        vm.startPrank(add);
        wallet.withdraw(sum);
        assertEq(wallet.getBalance(), balances - sum,"withdraw failed");   
        vm.stopPrank();
    }
    function testaddGabay(address Gabay) public{
      wallet.addGabay(address(Gabay));
      assertEq(wallet.countowners(),1);
      assertEq(wallet.owners(address(Gabay)),true);
    }

     function testaddGabayAlreadyExist(address Gabay) public{
      wallet.addGabay(address(Gabay));
      assertEq(wallet.countowners(),1);
      assertEq(wallet.owners(address(Gabay)),true);
      vm.expectRevert("The Gabay already exist");
      wallet.addGabay(address(Gabay));
    }

   function testNotOwnerAddGabay(address Gabay) public{
       address d= vm.addr(12);
       vm.startPrank(d);
       vm.expectRevert("you not owner");
       wallet.addGabay(address(Gabay));
       vm.stopPrank();
   }

    function testHaveTreeGabaim(address Gabay) public{
        wallet.addGabay(vm.addr(1));
        wallet.addGabay(vm.addr(2));
        wallet.addGabay(vm.addr(3));
        assertEq(wallet.countowners(),3);
        vm.expectRevert("There are already 3 owners");
        wallet.addGabay(address(Gabay));
    }

    function testChangeGabay(address oldGabay, address newGabay) public{
      vm.assume( oldGabay != newGabay);
      wallet.addGabay(address(oldGabay));
      wallet.changeGabay(address(oldGabay),address(newGabay));
      assertEq(wallet.owners(address(oldGabay)),false);
      assertEq(wallet.owners(address(newGabay)),true);
    }

       function tesFaildtchangeGabay(address oldGabay) public {
        wallet.addGabay(oldGabay);
        vm.expectRevert("The Gabay not exist");
        wallet.changeGabay(address(4),address(3));
    }
}