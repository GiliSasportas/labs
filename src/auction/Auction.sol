// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "lib/forge-std/src/interfaces/IERC20.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract Auction{
    IERC20 public coin;
    IERC721 public NFT;
    bool started=false;
    address public owner;
    address public bidAddress;
    address public NFTaddress;
    uint256 public maxBid;
    uint256 public amountDays;
    uint256 public endAt;

     modifier isOwner() {
       require(msg.sender==owner,"not owner ");
        _; 
    }

    modifier bidder() {
       require(msg.value > maxBid,"the value less from max");
       require(started == true);
       require(block.timestamp < endAt);
        _; 
    }

    function startAction(uint256 _days,address nftOwner, uint256 tokenId, uint256 amount) public isOwner{
        require(started == false);
        started=true;     
        uint256 finish= block.timestamp+ (_days * 1 days);
        endAt=finish;
        maxBid=amount;
        NFTaddress=nftOwner;
        NFT.transferFrom(nftOwner, address(this), tokenId);
    }

    function suggest( ) public payable bidder{
        if(NFTaddress != bidAddress){
           coin.transfer(bidAddress,maxBid);
        }
        maxBid=msg.value;
        bidAddress= msg.sender;
        coin.transferFrom(msg.sender,address(this),msg.value);
    }

    function endAction( ) public payable {
        require(block.timestamp >= endAt,"cannot transfer before days have passed");
        coin.transfer(NFTaddress,address(this).balance);
        NFT.transferFrom(address(this), bidAddress, address(this).balance);
    }
}
