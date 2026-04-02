// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// 质押挖矿奖励系统，支持自定义质押代币与奖励
contract STAKING_REWARD_SYSTEM {
    IERC20 public immutable stakingToken;
    IERC20 public immutable rewardToken;
    uint256 public rewardRate = 100; // 每日奖励数量

    mapping(address => uint256) public stakingBalance;
    mapping(address => uint256) public rewardDebt;

    constructor(address _stake, address _reward) {
        stakingToken = IERC20(_stake);
        rewardToken = IERC20(_reward);
    }

    // 质押代币
    function stake(uint256 amount) external {
        require(amount > 0, "Amount zero");
        stakingToken.transferFrom(msg.sender, address(this), amount);
        stakingBalance[msg.sender] += amount;
    }

    // 提取质押+领取奖励
    function unstake() external {
        uint256 balance = stakingBalance[msg.sender];
        require(balance > 0, "No stake");
        
        stakingBalance[msg.sender] = 0;
        stakingToken.transfer(msg.sender, balance);
        rewardToken.transfer(msg.sender, balance * rewardRate / 1000);
    }
}
