// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 去中心化交易所自动兑换模拟器
contract AUTO_SWAP_SIMULATOR {
    uint256 public constant SWAP_RATE = 100; // 1 ETH = 100 Token
    event Swapped(address indexed user, uint256 ethIn, uint256 tokenOut);

    // ETH兑换代币
    function swapETHToToken() external payable {
        require(msg.value > 0, "No ETH");
        uint256 tokenAmount = msg.value * SWAP_RATE;
        emit Swapped(msg.sender, msg.value, tokenAmount);
    }

    // 查看兑换预估数量
    function getEstimatedToken(uint256 ethAmount) external pure returns (uint256) {
        return ethAmount * SWAP_RATE;
    }
}
