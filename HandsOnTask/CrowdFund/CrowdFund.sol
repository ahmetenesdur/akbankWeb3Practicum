// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./IERC20.sol";

interface IERC20 {
    function transfer(address, uint) external returns (bool);

    function transferFrom(
        address,
        address,
        uint
    ) external returns (bool);
}

contract CrowdFund {
    event Launch( // Event to be emitted when the campaign is launched
        uint id,
        address indexed creator,
        uint goal,
        uint32 startAt,
        uint32 endAt
    );

    event Cancel(uint id);
    event Pledge(uint indexed id, address indexed caller, uint amount);
    event Unpledge(uint indexed id, address indexed caller, uint amount);
    event Claim(uint id);
    event Refund(uint id, address indexed caller, uint amount);

    struct Campaign {
        // Creator of campaign
        address creator;
        // Amount of tokens to raise
        uint goal;
        // Total amount pledged
        uint pledged;
        // Timestamp of start of campaign
        uint32 startAt;
        // Timestamp of end of campaign
        uint32 endAt;
        // True if goal was reached and creator has claimed the tokens.
        bool claimed;
    }

    IERC20 public immutable token;
    // Total count of campaigns created.
    // It is also used to generate id for new campaigns.
    uint public count;
    // Mapping from id to Campaign
    mapping(uint => Campaign) public campaigns;
    // Mapping from campaign id => pledger => amount pledged
    mapping(uint => mapping(address => uint)) public pledgedAmount;

    constructor(address _token) {
        token = IERC20(_token)
    }

    function launch(
        uint _goal,
        uint32 _startAt,
        uint32 _endAt
    ) external {
        require(_startAt >= block.timestamp, "start at < now");
        require(_endAt >= _startAt, "end at < start at");
        require(_endAt <= block.timestamp + 90 days, "end at > max duration");

        count += 1;
        campaigns[count] = Campaign({
            creator: msg.sender,
            goal: _goal,
            pledged: 0,
            startAt: _startAt,
            endAt: _endAt,
            claimed: false
        });

        emit Launch(count, msg.sender, _goal, _startAt, _endAt);
    }

    function cancel(uint _id) external { // Cancel a campaign
        Campaign memory campaign = campaigns[_id]; 
        require(campaign.creator == msg.sender, "not creator"); // Only creator can cancel campaign
        require(block.timestamp < campaign.startAt, "started"); // Cannot cancel a campaign that has started

        delete campaigns[_id]; // Delete campaign from mapping
        emit Cancel(_id); // Emit Cancel event
    }

    // Pledge tokens to a campaign
    function pledge(uint _id, uint _amount) external {
        Campaign storage campaign = campaigns[_id]; // Get campaign from mapping
        require(block.timestamp >= campaign.startAt, "not started"); // Campaign must have started
        require(block.timestamp <= campaign.endAt, "ended"); // Campaign must not have ended

        campaign.pledged += _amount; // Add amount to total pledged
        pledgedAmount[_id][msg.sender] += _amount; // Add amount to pledger's pledged amount
        token.transferFrom(msg.sender, address(this), _amount); // Transfer tokens from caller to this contract

        emit Pledge(_id, msg.sender, _amount); // Emit Pledge event
    }

    function unpledge(uint _id, uint _amount) external { // Unpledge tokens from a campaign
        Campaign storage campaign = campaigns[_id];
        require(block.timestamp <= campaign.endAt, "ended"); // Campaign must not have ended

        campaign.pledged -= _amount; // Subtract amount from total pledged
        pledgedAmount[_id][msg.sender] -= _amount; // Subtract amount from pledger's pledged amount
        token.transfer(msg.sender, _amount); // Transfer tokens from this contract to caller

        emit Unpledge(_id, msg.sender, _amount); // Emit Unpledge event
    }

    function claim(uint _id) external {
        Campaign storage campaign = campaigns[_id];
        require(campaign.creator == msg.sender, "not creator"); // Only creator can claim tokens
        require(block.timestamp > campaign.endAt, "not ended");
        require(campaign.pledged >= campaign.goal, "pledged < goal"); // Pledged amount must be greater than or equal to goal
        require(!campaign.claimed, "claimed"); // Cannot claim tokens more than once

        campaign.claimed = true; // Set claimed to true
        token.transfer(campaign.creator, campaign.pledged); // Transfer tokens from this contract to creator

        emit Claim(_id); // Emit Claim event
    }

    function refund(uint _id) external { 
        Campaign memory campaign = campaigns[_id];
        require(block.timestamp > campaign.endAt, "not ended"); // Campaign must have ended
        require(campaign.pledged < campaign.goal, "pledged >= goal"); // Pledged amount must be less than goal

        uint bal = pledgedAmount[_id][msg.sender]; // Get amount pledged by caller
        pledgedAmount[_id][msg.sender] = 0; // Set amount pledged by caller to 0
        token.transfer(msg.sender, bal); // Transfer tokens from this contract to caller

        emit Refund(_id, msg.sender, bal); // Emit Refund event
    }
}
