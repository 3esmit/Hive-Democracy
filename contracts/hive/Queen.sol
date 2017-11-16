pragma solidity ^0.4.10;

import "../deploy/DelegatedCall.sol";
import "./Hive.sol";

contract Queen is DelegatedCall {

    event NewConstitution(address constitution);
    Hive public hive;
    address public constitution;
    
    modifier onlyQueen {
        require(msg.sender == address(this));
        _;
    }

    /**
     * @dev initializes Queen with it's first constitution.
     */
    function Queen(address _firstConstitution) public {
        hive = Hive(msg.sender);
        constitution = _firstConstitution;
        NewConstitution(constitution);
        require(constitution.delegatecall(sha3("install()")));
    }
    
    /**
     * @dev default function delegates, no ETH payments allowed to queen
     */
    function () public delegated {
        // should be empty
    }

    function honeyMove(address _from, address _to, uint _value) public delegated returns (bool) {

    }
    /**
     * @dev sets a new constitution and calls update().
     */
    function updateConstitution(address _newConstitution) public onlyQueen {
        constitution = _newConstitution;
        NewConstitution(constitution);
        if (!this.update()) {
            revert();
        }
    }

    function update() public delegated returns (bool) {
        return false;
    }
    /**
     * @dev defines the address for delegation of calls
     */
    function _target()
        internal
        constant
        returns(address)
        {
            return constitution;
        }

    
}