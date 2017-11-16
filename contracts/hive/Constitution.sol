pragma solidity ^0.4.10;

import "./Queen.sol";
import "./Hive.sol";
import "../democracy/DelegationNetwork.sol";
import "../democracy/ProposalManager.sol";
import "../democracy/QuadraticVote.sol";
import "../token/MiniMeToken.sol";

contract Constitution {
    
    event NewConstitution(address constitution);
    Hive public hive;
    address public constitution;

    modifier onlyQueen {
        require(msg.sender == address(this));
        _;
    }

    modifier onlyHive {
        require(msg.sender == address(hive));
        _;
    }

    MiniMeToken token;
    DelegationNetwork delegations;
    ProposalManager proposals;
    QuadraticVote influence;
    
    function install() public onlyQueen {
        if (address(delegations) == 0x0) {
            delegations = new DelegationNetwork();
            token = hive.honey();
            proposals = new ProposalManager();
            influence = new QuadraticVote(token, 1000000000, 1000, 30 days, 30 days, 60 days, 120 days);
        }
    }
    
    function update() public onlyQueen returns (bool) {
        return false;
    }

    function newProposal(address destination, uint value, bytes data) public onlyHive returns(uint) {
        return proposals.addProposal(0x0, destination, value, data);
    }

    function honeyMove(address _from, address _to, uint _value) public onlyHive returns (bool) {
        influence.moved(_from, _to, _value); 
        return true;
    }

}