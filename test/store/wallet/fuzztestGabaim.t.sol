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

    function testDeposite(uint sum) public {
      uint initialBalance = wallet.getBalance();
      address ad=vm.addr(20);
      vm.startPrank(ad);
      vm.deal(ad,sum);
      payable(wallet).transfer(sum);
      assertEq(wallet.getBalance(), initialBalance + sum, "Balance should increase by num after transfer");
      vm.stopPrank();
    }

    function fuzztestWithdraw(uint sum) payable public {
      payable(wallet).transfer(sum);
      uint balances = wallet.getBalance();
      address ad = vm.addr(12);
      wallet.addGabay(ad);
      vm.prank(ad);
      wallet.withdraw(sum);
      assertEq(wallet.getBalance(),balances-sum);
    }

    function testaddGabay(address ad) public{
      wallet.addGabay(address(ad));
      assertEq(wallet.countowners(),1);
      assertEq(wallet.owners(address(ad)),true);
    }

     function testaddGabayAlreadyExist(address z) public{
      wallet.addGabay(address(z));
      assertEq(wallet.countowners(),1);
      assertEq(wallet.owners(address(z)),true);
      vm.expectRevert("The Gabay already exist");
      wallet.addGabay(address(z));
    }

   function testNotOwnerAddGabay(address ad) public{
       address d= vm.addr(12);
       vm.startPrank(d);
       vm.expectRevert("you not owner");
       wallet.addGabay(address(ad));
       vm.stopPrank();
   }

    function testHaveTreeGabaim(address ad) public{
        wallet.addGabay(vm.addr(1));
        wallet.addGabay(vm.addr(2));
        wallet.addGabay(vm.addr(3));
        assertEq(wallet.countowners(),3);
        vm.expectRevert("There are already 3 owners");
        wallet.addGabay(address(ad));
    }

    function testChangeGabay(address adold, address adnew) public{
      vm.expectRevert("Addresses must be different");
      assertEq(address(adold),address(adnew));
      console.log("in change gabay");
      console.log("log",address(adold),address(adnew));
      wallet.addGabay(address(adold));
      wallet.changeGabay(address(adold),address(adnew));
      assertEq(wallet.owners(address(adold)),false);
      assertEq(wallet.owners(address(adnew)),true);
    }
}