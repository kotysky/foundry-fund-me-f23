// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script {
    uint256 constant SEND_VALUE = 0.01 ether;

    function fundFundMe(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).fund{value: SEND_VALUE}(); // Esto coge el la ultima direccion de FundMe y le hace un fund
        vm.stopBroadcast();
        console.log("Funded FundMe contract %s", SEND_VALUE);
    }

    function run() external {
        address mostRecentlyDeployedFundMe = DevOpsTools
            .get_most_recent_deployment("FundMe", block.chainid);
        fundFundMe(mostRecentlyDeployedFundMe);
    }
}

contract WithdrawFundMe is Script {
    function withdrawFundMe(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).withdraw();
        vm.stopBroadcast();
    }

    function run() external {
        address mostRecentlyDeployedFundMe = DevOpsTools
            .get_most_recent_deployment("FundMe", block.chainid);
        withdrawFundMe(mostRecentlyDeployedFundMe);
    }
}
