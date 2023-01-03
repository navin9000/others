//SPDX-License-Identifier:UNLICENSED
pragma solidity 0.8.7;

import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import "src/quillCTF/challenge_5.sol";
import "src/quillCTF/challenge_5_Attack.sol";

/**
 * @title Testing contract for challenge_5_Attack.sol
 * @author Purple_Calender
 * @custom:experimental this is an experimental Testing contract
 */

contract Challenge5Test is Test {
    D31eg4t3 challenge;
    Attack challengeAttack;
    address cOwner;

    /**
     * @dev creating the instances of both contracts
     * @dev cOwner is the deployer of the challenge_5 contract
     */
    constructor() {
        cOwner = vm.addr(1);
        challenge = new D31eg4t3();
        challengeAttack = new Attack(address(challenge));
    }

    /**
     * @dev calling attackHackMe() which calls attack contract
     * @dev potentially changes the owner and added mapping bool to true
     */
    function test_attackHackMe() external {
        bool check = challengeAttack.attackHackMe();
        assertEq(check, true);
        assertEq(0xdD870fA1b7C4700F2BD7f44238821C26f7392148, challenge.owner());
        assertEq(
            challenge.canYouHackMe(0xdD870fA1b7C4700F2BD7f44238821C26f7392148),
            true
        );
    }
}
