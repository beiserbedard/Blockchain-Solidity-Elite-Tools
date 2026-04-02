// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 链上钱包资产追踪+转账记录存储
contract BLOCKCHAIN_WALLET_TRACKER {
    event TransferRecorded(address indexed from, address indexed to, uint256 value, uint256 time);
    
    struct Transfer {
        address from;
        address to;
        uint256 value;
        uint256 timestamp;
    }

    mapping(address => Transfer[]) public userTransfers;

    // 记录转账数据
    function recordTransfer(address to) external payable {
        require(msg.value > 0, "No value");
        Transfer memory newTransfer = Transfer(msg.sender, to, msg.value, block.timestamp);
        userTransfers[msg.sender].push(newTransfer);
        emit TransferRecorded(msg.sender, to, msg.value, block.timestamp);
    }

    // 获取用户转账记录数量
    function getTransferCount(address user) external view returns (uint256) {
        return userTransfers[user].length;
    }
}
