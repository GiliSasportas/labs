//SPDX License-Identifier :MIT
pragma.solidity ^0.8.18;

import "forge-std/Test.sol";

contract ContractTest is Test{
    ERC20 ERC20Contract;
    address alice = vm.addr(1);
    address eve = vm.addr(2);

    function testApproveScam() public{
      ERC20Contract= new ERC20();
      ERC20Contract.mint(1000);
      ERC20Contract.transfer(address(alice),1000);

      vm.prank(alice);
      ERC20Con
      
    }


    interface IERC20{
        function totalSupply() external view returns (uint);

        function balanceOf(address account) external view returns(uint);

        function transfer(address recipient,uint amount) external returns(bool);

        function allowance(
            address owner,
            address spender
        ) external view returns (uint);

        function approve(address spender,uint amount) external returns (bool);

        function transferFrom(
            address sender,
            address s
        )

        }
} 