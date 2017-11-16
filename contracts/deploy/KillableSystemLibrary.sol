pragma solidity ^0.4.17;

import "./BasicSystemStorage.sol";


/**
 * @title KillableSystemLibrary
 * @author Ricardo Guilherme Schmidt (Status Research & Development GmbH) 
 * @dev Contract that recovers from dead system to recover.
 */
contract KillableSystemLibrary is BasicSystemStorage {

    address watchdog;

     /**
     * @dev Library contract constructor initialize watchdog, able to kill the Library in case of 
     */
    function System() public {
        watchdog == msg.sender;
    }

    function emergencyStop() public {
        require(msg.sender == watchdog);
        selfdestruct(watchdog);
    }


}