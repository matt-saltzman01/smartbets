pragma solidity ^0.4.18;
import "/home/jmkjr/Gambling/Training/ethereum-api-master/oraclizeAPI.sol";

contract Outcome is usingOraclize {
  enum Stages {
    Betting,
    Settlement
  }

  uint public betsPlaced;
  mapping(address => string) public bets;
  address public escrow;
  address public winnerAddress;
  address public player1;
  address public player2;

  // current Stage
  Stages public stage = Stages.Betting;

  modifier atStage(Stages _stage) {
    require(stage == _stage);
    _;
  }

  function Outcome() public payable {
    betsPlaced = 0;
    escrow = this;
  }

  function () public payable {
    // accept ether
  }

  function nextStage() internal {
    stage = Stages(uint(stage) + 1);
  }

  function getState() public constant returns (Stages) {
    return Stages(uint(stage));
  }

  function placeBet(string teamID) public payable atStage(Stages.Betting) {
    bets[msg.sender] = teamID;
    betsPlaced += 1;
    if (betsPlaced == 1) {
      player1 = msg.sender;
    }
    if (betsPlaced == 2) {
      player2 = msg.sender;
      nextStage();
      oraclize_query("URL", "json(https://blockchains-backend.herokuapp.com/get_winning_team_by_match_id/1788377376).teamId");
    }
  }

  function getWinnerAddress() public view atStage(Stages.Settlement) returns (address) {
    return winnerAddress;
  }

  function __callback(bytes32 myid, string result) {
    //winnerID = result;
    if (keccak256(bets[player1]) == keccak256(result)) {
      player1.transfer(escrow.balance);
      winnerAddress = player1;
    } else {
      player2.transfer(escrow.balance);
      winnerAddress = player2;
    }
  }

}
