pragma solidity ^0.4.10;

import "../democracy/DelegationNetwork.sol";
import "../token/TokenLedger.sol";
import "../token/MiniMeToken.sol";

contract Honeycomb is TokenLedger, Controlled {
   
    MiniMeToken public honey;
    uint public capacity = 0;
    
    function Honeycomb(MiniMeToken _honey) public {
        honey = _honey;
    }

    function depositHoney(bytes _data) public {
        uint amount = honey.allowance(msg.sender, this);
        receiveApproval(msg.sender, amount, address(honey), _data);
    }
    
    function register(address _token, address _sender, uint _amount, bytes _data) internal {
        require(address(honey) == _token);
        require(tokenBalances[_token] + _amount > capacity);
        super.register(_token, _sender, _amount, _data);
    }

    function withdraw(address _dest, uint256 _amount) public onlyController {
        withdraw(honey, _dest, _amount, 0x0);
    }
}