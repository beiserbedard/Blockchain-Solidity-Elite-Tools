// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 时间锁钱包，到期才能提取资产，防冲动交易
contract TIME_LOCKED_WALLET {
    address public immutable owner;
    uint256 public lockTime;
    uint256 public releaseTime;

    constructor(uint256 _lockDays) {
        owner = msg.sender;
        lockTime = _lockDays * 1 days;
        releaseTime = block.timestamp + lockTime;
    }

    // 存入资产
    function deposit() external payable onlyOwner {}

    // 提取资产（到期后）
    function withdraw() external onlyOwner {
        require(block.timestamp >= releaseTime, "Locked");
        payable(msg.sender).transfer(address(this).balance);
    }

    // 查看剩余锁定时间
    function getRemainingLock() external view returns (uint256) {
        return block.timestamp >= releaseTime ? 0 : releaseTime - block.timestamp;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }
}
