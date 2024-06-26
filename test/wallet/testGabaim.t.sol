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
        address add=vm.addr(20);
        vm.deal(add,1000);
        wallet.addGabay(add);
        vm.startPrank(add);
        payable(wallet).transfer(100);
        uint balances= wallet.getBalance();
        wallet.withdraw(50);
        assertEq(wallet.getBalance(), balances - 50,"withdraw failed");   
        vm.stopPrank();
    }

    function testDeposite() payable public {
        uint initialBalance = wallet.getBalance(); 
        uint sum=10;    
        payable(wallet).transfer(sum);
        assertEq(wallet.getBalance(), initialBalance + sum, "Balance should increase by num after transfer");
    }

    function testAddGabay() public{
        wallet.addGabay(address(10));
        assertEq(wallet.countowners(),1);
        assertEq(wallet.owners(address(10)),true);
    }

    function testNotOwnerAddGabay() public{
        address d = vm.addr(1);
        vm.startPrank(d);
        vm.expectRevert("you not owner");
        wallet.addGabay(address(2));
        vm.stopPrank();
    }

    function testHaveTreeGabaim() public{
        wallet.addGabay(address(6));
        wallet.addGabay(address(8));
        wallet.addGabay(address(11));
        assertEq(wallet.countowners(),3);
        vm.expectRevert("There are already 3 owners");
        wallet.addGabay(address(2));     
    }

    function testchangeGabay() public{
        //before change
        wallet.addGabay(address(4));
        assertEq(wallet.owners(address(4)),true);
        assertEq(wallet.owners(address(3)),false);
        wallet.changeGabay(address(4),address(3));
        //after change
        assertEq(wallet.owners(address(4)),false);
        assertEq(wallet.owners(address(3)),true);

    }

    function tesFaildchangeGabay() public {
        wallet.addGabay(address(4));
        vm.expectRevert("The Gabay not exist");
        wallet.changeGabay(address(5),address(3));
    }
}
