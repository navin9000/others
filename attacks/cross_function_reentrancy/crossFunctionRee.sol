//SPDX-License-Identifier:UNLICENSED
pragma solidity 0.8.7;

/**
 * @title Learning the cross-function reentrancy attack
 * @author pulamarasetti naveen
 */

contract Bank {
    mapping(address => uint) public balances;
    bool internal locked;

    modifier nonreentrant() {
        require(!locked, "no reentrancy allowed");
        locked = true;
        _;
        locked = false;
    }

    function deposite() external payable {
        require(msg.value >= 1 ether, "less funds");
        balances[msg.sender] += msg.value;
    }

    function withdrawAll() external nonreentrant {
        require(balances[msg.sender] > 1 ether, "insufficient balance");
        uint bal = balances[msg.sender];
        (bool success, ) = payable(msg.sender).call{value: bal}("");
        require(success, "withdrawAll failed");
        balances[msg.sender] = 0;
    }

    function transfer(address to, uint amt) external {
        require(balances[msg.sender] >= amt, "insufficient funds");
        balances[to] += amt;
        balances[msg.sender] -= amt;
    }

    function getUserBalance() public view returns (uint256) {
        return balances[msg.sender];
    }
}
