// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    address public owner;
    string[] public candidates;

    mapping(string => uint256) public votes;
    mapping(address => uint8) public userVoteCount;
    mapping(address => mapping(string => uint8)) public userVotesForCandidate;

    constructor(string[] memory _candidates) {
        owner = msg.sender;
        candidates = _candidates;
    }

    function vote(string memory _candidate) public {
        require(userVoteCount[msg.sender] < 5, "You have used all 5 votes");

        bool valid = false;
        for (uint i = 0; i < candidates.length; i++) {
            if (keccak256(bytes(candidates[i])) == keccak256(bytes(_candidate))) {
                valid = true;
                break;
            }
        }
        require(valid, "Invalid candidate");

        votes[_candidate]++;
        userVoteCount[msg.sender]++;
        userVotesForCandidate[msg.sender][_candidate]++;
    }

    function getVotes(string memory _candidate) public view returns (uint256) {
        return votes[_candidate];
    }

    function getUserVotesForCandidate(address user, string memory _candidate) public view returns (uint8) {
        return userVotesForCandidate[user][_candidate];
    }

    function getUserVoteCount(address user) public view returns (uint8) {
        return userVoteCount[user];
    }

    function getCandidates() public view returns (string[] memory) {
        return candidates;
    }
}

