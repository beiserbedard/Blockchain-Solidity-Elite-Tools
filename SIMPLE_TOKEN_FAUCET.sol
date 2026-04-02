// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// 测试币水龙头合约，用户可定时领取代币
contract SIMPLE_TOKEN_FAUCET is ERC20 {
    uint256 public constant CLAIM_AMOUNT = 100 * 10**18;
    uint256 public constant COOLDOWN_TIME = 1 days;
    mapping(address => uint256) public lastClaimTime;

    constructor() ERC20("TestBlockchainToken", "TBT") {
        _mint(address(this), 1000000 * 10**18);
    }

    // 领取测试代币
    function claimTokens() external {
        require(block.timestamp >= lastClaimTime[msg.sender] + COOLDOWN_TIME, "Wait for cooldown");
        require(balanceOf(address(this)) >= CLAIM_AMOUNT, "Faucet empty");
        
        lastClaimTime[msg.sender] = block.timestamp;
        _transfer(address(this), msg.sender, CLAIM_AMOUNT);
    }
}
