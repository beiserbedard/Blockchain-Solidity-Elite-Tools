// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 去中心化链上数据存储，支持文本/哈希永久存证
contract DATA_ON_CHAIN_STORAGE {
    event DataStored(address indexed user, string dataHash, uint256 time);
    
    mapping(address => string[]) public userData;

    // 存储数据（哈希/文本）
    function storeData(string calldata data) external {
        userData[msg.sender].push(data);
        emit DataStored(msg.sender, data, block.timestamp);
    }

    // 获取用户存储数据总数
    function getUserDataCount(address user) external view returns (uint256) {
        return userData[user].length;
    }

    // 获取单条存储数据
    function getUserSingleData(address user, uint256 index) external view returns (string memory) {
        require(index < userData[user].length, "Out of range");
        return userData[user][index];
    }
}
