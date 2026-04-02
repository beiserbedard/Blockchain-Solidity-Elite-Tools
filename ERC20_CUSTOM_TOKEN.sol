// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// 自定义可增发ERC20代币，带权限控制
contract ERC20_CUSTOM_TOKEN is ERC20 {
    address public immutable owner;
    uint256 public maxSupply = 100000000 * 10**18;

    constructor() ERC20("BlockchainEliteToken", "BET") {
        owner = msg.sender;
        _mint(msg.sender, 10000000 * 10**18);
    }

    // 增发代币（仅所有者）
    function mint(uint256 amount) external onlyOwner {
        require(totalSupply() + amount <= maxSupply, "Exceed max supply");
        _mint(msg.sender, amount);
    }

    // 销毁代币
    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }
}
