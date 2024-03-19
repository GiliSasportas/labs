// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/Gabaim.sol";


contract testGabaim is Test {

    Gabaim public owner;
    address newGabay=0x321;

    function setUp() public {
        owner = new Gabaim();
    }

     function testAddGabay() public {
        owner.addGabay(newGabay);
        assert.equal(owner.count(), 1, "Count should be incremented to 1");
        assert.isTrue(owner.owners(address(newGabay)), "Current address should be added as Gabay");
    }

     function testChangeGabay() public {
        address oldKey = newGabay;
        address newKey = address(0x123); 
        owner.changeGabay(oldKey, newKey); 
        assert.isFalse(owner.owners(oldKey), "Old key should be removed from owners mapping");
        assert.isTrue(owner.owners(newKey), "New key should be added to owners mapping");
    }
 
}
