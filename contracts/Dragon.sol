pragma solidity ^0.4.18;
import "/home/jmkjr/Gambling/Training/smartbets/node_modules/ethereum-api-master/oraclizeAPI.sol";

contract Dragon is usingOraclize {
  enum Stages {
    Betting,
    Settlement
  }

  uint public betsPlaced;
  uint public player1amount;
  mapping(address => string) public bets;
  address public escrow;
  address public winnerAddress;
  address public player1;
  address public player2;
  string public queryResult;

  // current Stage
  Stages public stage = Stages.Betting;

  modifier atStage(Stages _stage) {
    require(stage == _stage);
    _;
  }

  function Dragon() public payable {
    betsPlaced = 0;
    escrow = this;
  }

  function reset() internal {
    stage = Stages.Betting;
    bets[player1] = '';
    bets[player2] = '';
    queryResult = '';
    betsPlaced = 0;
    player1amount = 0;
    winnerAddress = 0;
    player1 = 0;
    player2 = 0;
  }

  function () public payable {
    // accept ether
  }

  function nextStage() internal {
    stage = Stages(uint(stage) + 1);
  }

  function placeBet(string teamID) public payable atStage(Stages.Betting) {
    require(msg.value == 10000000000000000 || msg.value == 20000000000000000 || msg.value == 30000000000000000);
    bets[msg.sender] = teamID;
    betsPlaced += 1;
    if (betsPlaced == 1) {
      player1 = msg.sender;
      player1amount = msg.value;
    }
    if (betsPlaced == 2) {
      player2 = msg.sender;
      require(msg.value == player1amount);
      require(keccak256(bets[player1]) != keccak256(teamID));
      nextStage();
      oraclize_query("URL", "json(https://blockchains-backend.herokuapp.com/get_team_with_first_dragon_by_match_id/1788343955).teamId");
    }
  }

  function getWinnerAddress() public view atStage(Stages.Settlement) returns (address) {
    return winnerAddress;
  }

  function __callback(bytes32 myid, string result) {
    queryResult = result;
    if (keccak256(bets[player1]) == keccak256(result)) {
      player1.transfer(escrow.balance);
      winnerAddress = player1;
    } else if (keccak256(bets[player2]) == keccak256(result)) {
      player2.transfer(escrow.balance);
      winnerAddress = player2;
    } else {
      player1.transfer(escrow.balance / 2.0);
      player2.transfer(escrow.balance);
    }
    reset();
  }

}
