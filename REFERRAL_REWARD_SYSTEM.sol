// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 区块链推荐奖励系统，邀请用户即可获得代币奖励
contract REFERRAL_REWARD_SYSTEM {
    IERC20 public rewardToken;
    mapping(address => address) public referrers;
    mapping(address => uint256) public referralRewards;
    uint256 public rewardAmount = 50 * 10**18;

    constructor(address token) {
        rewardToken = IERC20(token);
    }

    // 注册推荐关系
    function registerReferral(address referrer) external {
        require(referrers[msg.sender] == address(0), "Already registered");
        require(referrer != msg.sender, "Cannot refer self");
        
        referrers[msg.sender] = referrer;
        referralRewards[referrer] += rewardAmount;
        rewardToken.transfer(referrer, rewardAmount);
    }

    // 查看推荐人奖励
    function getReferralReward(address user) external view returns (uint256) {
        return referralRewards[user];
    }
}

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
}
