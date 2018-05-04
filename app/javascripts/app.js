// Import the page's CSS. Webpack will know what to do with it.
import "../stylesheets/app.css";

// Import libraries we need.
import { default as Web3} from 'web3';
import { default as contract } from 'truffle-contract'

/*
 * When you compile and deploy your Voting contract,
 * truffle stores the abi and deployed address in a json
 * file in the build directory. We will use this information
 * to setup a Voting abstraction. We will use this abstraction
 * later to create an instance of the Voting contract.
 * Compare this against the index.js from our previous tutorial to see the difference
 * https://gist.github.com/maheshmurthy/f6e96d6b3fff4cd4fa7f892de8a1a1b4#file-index-js
 */

import outcome_artifacts from '../../build/contracts/Outcome.json'
import dragon_artifacts from '../../build/contracts/Dragon.json'

var Outcome = contract(outcome_artifacts);
var Dragon = contract(dragon_artifacts);

Outcome.setProvider(web3.currentProvider);
Dragon.setProvider(web3.currentProvider);

function betOnWinningTeam() {
    var inputs = document.getElementById("winning_team_form").elements;
    var inputTeamID = inputs["winning_team_id"].value;
    var inputAmount = inputs["winning_team_amount"].value;
    console.log("inputTeamID: " + inputTeamID);
    console.log("inputAmount: " + inputAmount);
    Outcome.deployed().then(function(contractInstance) {
      let app = contractInstance;
      app.placeBet(inputTeamID, {from: web3.eth.accounts[0], value: web3.toWei(inputAmount, "ether")});
    });
}

function betOnTeamWithFirstDragon() {
    var inputs = document.getElementById("first_dragon_form").elements;
    var inputTeamID = inputs["first_dragon_team_id"].value;
    var inputAmount = inputs["first_dragon_amount"].value;
    Dragon.deployed().then(function(contractInstance) {
      let app = contractInstance;
      app.placeBet(inputTeamID, {from: web3.eth.accounts[0], value: web3.toWei(inputAmount, "ether")});
    });
}

$(document).ready(function() {
    $("#winning_team_button").click(betOnWinningTeam);
    $("#first_dragon_button").click(betOnTeamWithFirstDragon);

  if (typeof web3 !== 'undefined') {
    console.warn("Using web3 detected from external source like Metamask")
    // Use Mist/MetaMask's provider
    window.web3 = new Web3(web3.currentProvider);
  } else {
    console.warn("No web3 detected. Falling back to http://localhost:8545. You should remove this fallback when you deploy live, as it's inherently insecure. Consider switching to Metamask for development. More info here: http://truffleframework.com/tutorials/truffle-and-metamask");
    // fallback - use your fallback strategy (local node / hosted node + in-dapp id mgmt / fail)
    window.web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
  }
});
