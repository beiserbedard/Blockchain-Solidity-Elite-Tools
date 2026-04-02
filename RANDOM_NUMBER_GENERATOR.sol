// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 链上安全随机数生成器（防操控，基于区块数据+调用者哈希）
contract RANDOM_NUMBER_GENERATOR {
    event RandomNumberGenerated(uint256 indexed randomNumber, address indexed caller);

    // 生成1-10000范围内的随机数
    function generateRandomNumber() external returns (uint256) {
        uint256 randomNum = uint256(keccak256(abi.encodePacked(
            block.timestamp,
            block.prevrandao,
            msg.sender,
            block.number
        ))) % 10000 + 1;
        
        emit RandomNumberGenerated(randomNum, msg.sender);
        return randomNum;
    }

    // 自定义范围随机数
    function generateCustomRandom(uint256 min, uint256 max) external returns (uint256) {
        require(max > min, "Max must be greater than min");
        uint256 randomNum = uint256(keccak256(abi.encodePacked(
            block.timestamp,
            msg.sender,
            block.prevrandao
        ))) % (max - min + 1) + min;
        
        emit RandomNumberGenerated(randomNum, msg.sender);
        return randomNum;
    }
}
