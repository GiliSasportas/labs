//SLDX-License-Identifity: GPL -3.0
pragma solidity >=0.7.0 <=0.9.0;
 ///@title Ballot
 //@dev- Implement procces of vote delegation

  contract Ballot{

    struct Voter{
        uint weight;   // weight is accumulated by delegation
        bool voted;    // if true, that person already voted
        address delegate;  // person delegated to
        uint vote;   // index of the voted proposal
    }

    struct Proposal{
        bytes32 name;  // short name 
        uint voteCount;  // number of accumulated votes

    }
    address public chairperson;
     mapping(address => Voter) public voters;
     Proposal[] public Proposals;
    
    ///@dev Create a new ballot to choose one of 'proposalNames'.
    ///@param proposalNames names of proposals

    //what is memory?
     constructor(bytes32[] memory proposalNames){
        chairperson= msg.sender;
        voters[chairperson].weight=1;
        //create a temporary 
        //push the object proposalto the end of proposals
        for(uint i=0; i<proposalNames.length; i++){
         Proposals.push(Proposal({
            name: proposalNames[i],
            voteCount:0
         }));
        }

     }
//give Right To Vote
     function giveRightToVote(address voter) public{
        require(
              msg.sender==chairperson,
            "Only chairprson can give to vote."
        ) ;
    }
  }
