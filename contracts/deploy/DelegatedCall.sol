pragma solidity ^0.4.17;


/**
 * @title DelegatedCall
 * @author Ricardo Guilherme Schmidt (Status Research & Development GmbH) 
 * @dev Abstract contract that delegates calls by `delegated` modifier to result of `_target()`
 */
contract DelegatedCall {
    /**
     * @dev delegates the call of this function
     */
    modifier delegated {
        require(_target().delegatecall(msg.data)); //require successfull delegate call to remote `_target()`
        assembly {
            let outSize := returndatasize 
            let outDataPtr := mload(0x40) //allocates pointer in memory
            mstore(0x40, add(outDataPtr, outSize)) //reserves needed size for that pointer
            returndatacopy(outDataPtr, 0, outSize) //copy last return into pointer
            return(outDataPtr, outSize) 
        }
        assert(false); //should never reach here
        _; //never will execute local logic
    }

    /**
     * @dev defines the address for delegation of calls
     */
    function _target()
        internal
        constant
        returns(address);

}
