pragma solidity ^0.4.10;

import "./Constitution.sol";
import "./Queen.sol";
import "../token/MiniMeToken.sol";
import "../token/TokenController.sol";
import "../Controlled.sol";

contract Hive is TokenController {
    
    Queen public queen;
    MiniMeToken public honey;

    modifier onlyQueen { 
        require(msg.sender == address(queen)); 
        _; 
    }

    function Hive(Constitution _firstConstitution, MiniMeToken _honey) public {
        require(_honey.controller() == address(this));
        queen = new Queen(_firstConstitution);
        honey = _honey;
    }

    function changeQueen(Queen _newQueen) public onlyQueen {
        queen = _newQueen;
    }

    function proxyPayment(address) public payable returns(bool) {
        return false;
    }

    function onTransfer(address _from, address _to, uint _value) public returns(bool) {
        return queen.honeyMove(_from, _to, _value);
    }

    function onApprove(address, address, uint) public returns(bool) {
        return true;
    }
}