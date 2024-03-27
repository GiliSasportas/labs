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

     function fuzztestDeposite(uint sum) public {
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

    function fuzzaddGabay(address ad) public{
      wallet.addGabay(ad);
      assertEq(wallet.countowners(),1);
      assertEq(wallet.owners(address(ad)),true);
      vm.expectRevert("the gabay already exist");
       wallet.addGabay(ad);
    }

}