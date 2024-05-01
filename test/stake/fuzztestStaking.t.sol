// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.15;

// import "forge-std/Test.sol";
// import "forge-std/console.sol";
// import "@hack/staking/Stake.sol";
// import "@hack/staking/erc20.sol";


// contract fuzztestStaking is Test {
//     Stake s;
//     myToken t;
//     uint wad=10**18;

//     function setUp() public{
//         t=new myToken();
//         s=new Stake(address(t));
//     }

//     // function testMint(uint256 amount) public{
//     //      vm.assume(amount > 0);
//     //     console.log(amount,"hhhhhhhhhhhh");
//     //     require(amount > 0 ,"canot mint");
//     //     console.log(t.balanceOf(address(this)),"befor mint");
//     //     t.mint(address(this),amount );
//     //     console.log(t.balanceOf(address(this)),"after mint");
//     //     assertEq(t.balanceOf(address(this)), amount );

//     // }

//     function testStake(uint amount) public{
       
//         console.log(amount,"amount!!!!!!!!!!!1111");
//         t.mint(address(this),100); 
//         t.approve(address(s), amount );
//           vm.assume(amount > 0 && amount < t.balanceOf(address(this)));
//        // require(amount > 0 && amount < t.balanceOf(address(this)),"amount not valid");
//        //require(amount > 0, "amount must be greater than 0");
//        //require(amount < t.balanceOf(address(this)), "amount exceeds balance");
//         console.log(t.balanceOf(address(this)),"befor stack");
//         s.stake(amount );
//         assertEq(t.balanceOf(address(this)), 50);
//         assertEq(t.balanceOf(address(s)), 1000050);
//     }


// }