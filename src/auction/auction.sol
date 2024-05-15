// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "lib/forge-std/src/interfaces/IERC20.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "@hack/auction/myERC721.sol";
import "forge-std/console.sol";

contract Auction{
    
    IERC20 public token;
    IERC721 public NFT;
    bool started=false;
    address public owner;
    address public bidAddress;
    address public NFTaddress;
    uint256 public maxBid=5;
    uint256 public endAt;

    constructor(address tokenErc20,address tokenErc721 ){
        owner = msg.sender;
        token=IERC20(tokenErc20);
        NFT= IERC721(tokenErc721);
    }

     modifier isOwner() {
       require(msg.sender==owner,"not owner ");
        _; 
    }


    function startAction(uint256 _days,address nftOwner, uint256 tokenId, uint256 amount) public {
        console.log(NFT.ownerOf(tokenId), "owner nft");
        require(NFT.ownerOf(tokenId) == nftOwner, "not owner") ;
        require(started == false);
        started=true;     
        uint256 finish= block.timestamp+ (_days * 1 days);
        endAt=finish;
        maxBid=amount;
        NFTaddress=nftOwner;
        NFT.transferFrom(nftOwner, address(this), tokenId);
    }

    function suggest(uint amount ) public  {
        require(amount > maxBid,"the value less from max");
        require(started == true,"not started");
        require(block.timestamp < endAt, "finish auction");
        // if(NFTaddress != bidAddress){
        //    token.transfer(bidAddress,maxBid);
        // }
        require(amount > maxBid,"the value less from max");
        maxBid=amount;
        bidAddress= msg.sender;
        console.log(msg.sender.balance, "aaa");
        console.log(address(this).balance, "aaa");
        //token.transferFrom(msg.sender,address(this),amount);

    }

    function endAction( ) public {
        require(block.timestamp >= endAt,"cannot transfer before days have passed");
        token.transfer(NFTaddress,address(this).balance);
        NFT.transferFrom(address(this), bidAddress, address(this).balance);
        started=false;
    }
}



