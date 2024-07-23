// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DAO {
    struct Member {  // "struct" allows me to group together different data types under a single name 
        bool exists;  // "exists" is a boolean flag that indicates whether the member exists in the DAO
        uint256 votingPower;  // voting power of the member
    }
    
    mapping(address => Member) members;  // mapping of members, address is the key and member is the value type 
    address[] memberList;  // list of members  

    uint256 totalVotingPower;  // total voting power of all members 

    // events 
    event MemberAdded(address indexed member, uint256 votingPower);  // "votingPower" is a data member as defined above, the voting power assigned to the new member
    event MemberRemoved(address indexed member);  // member is address of the member who is removed
    event Voted(address indexed voter, uint256 proposalId, bool support);
        // voter is the address of the member who is voting
        // proposalId is the the ID of the proposal on which the member is voting
        // support is a boolean indicating whether the member supports or opposes the proposal

    // modifier to check if the member exists  - modifiers are used to modify functions or restrict access to certain functions based on conditions 
    modifier onlyMember() {
        require(members[msg.sender].exists, "You are not a member");  // checks if the msg.sender exists in the mapping
        _;
    }

    // function to add a member
    function addMember(address _member, uint256 _votingPower) external {
        require(!members[_member].exists, "Member already exists");  // checks if the 'exists' flag for the member is false, if this is not the case, then the function will revert with the error message
        members[_member] = Member(true, _votingPower);
        memberList.push(_member);  // push adds the member to the memberList array
        totalVotingPower += _votingPower;
        emit MemberAdded(_member, _votingPower);
    }

    // function to remove a member,   onlyMembers is a modifier that restricts who can call the function 
    function removeMember(address _member) external onlyMember {  // function that is named removeMember, takes one parameter _member which is type address
        delete members[_member];  // deletes the entry _member from the members mapping
        totalVotingPower -= members[_member].votingPower;  // subtracts the votingPower of the member deleted from the totalVotingPower
        emit MemberRemoved(_member);  //emits an event MemberRemoved to signal that the actios was completed succesfully
    }

    // function to get the total number of members
    function getNumberOfMembers() external view returns (uint256) {  //view means it doesnt modify the state of the contract and only reads data
        return memberList.length;  // .length returns length as a uint256
    }

    // function to vote on a proposal
    function vote(uint256 _proposalId, bool _support) external onlyMember {
        require(_proposalId < 10, "Proposal ID is invalid");
        emit Voted(msg.sender, _proposalId, _support);  // everything in () are parameters passed to the event - the address of the member who voted, the id of the proposal being voted on, and _support is a boolean that indicates whether the member supports (true) the proposal
    }
}