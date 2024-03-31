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

    function testWithdraw(uint256 sum) public{ 
      address add=vm.addr(20);
      vm.deal(add,sum);
      wallet.addGabay(add);
      vm.startPrank(add);
      payable(wallet).transfer(sum);
      uint balances= wallet.getBalance();
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

    function tesFaildchangeGabay(address oldGabay, address newGabay) public {
      vm.expectRevert("The Gabay not exist");
      wallet.changeGabay(address(oldGabay),address(newGabay));
    }
}