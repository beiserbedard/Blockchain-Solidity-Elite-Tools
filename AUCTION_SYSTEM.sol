// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 链上公开拍卖系统，自动结算最高价
contract AUCTION_SYSTEM {
    address public auctioneer;
    uint256 public endTime;
    address public highestBidder;
    uint256 public highestBid;

    constructor(uint256 _auctionMinutes) {
        auctioneer = msg.sender;
        endTime = block.timestamp + _auctionMinutes * 1 minutes;
    }

    // 出价
    function bid() external payable {
        require(block.timestamp < endTime, "Auction ended");
        require(msg.value > highestBid, "Bid too low");
        
        if (highestBidder != address(0)) {
            payable(highestBidder).transfer(highestBid);
        }
        
        highestBidder = msg.sender;
        highestBid = msg.value;
    }

    // 结束拍卖
    function endAuction() external {
        require(block.timestamp >= endTime, "Not ended");
        payable(auctioneer).transfer(highestBid);
    }
}
