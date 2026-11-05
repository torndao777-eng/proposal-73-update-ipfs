// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface IENSResolver {
    function setContenthash(bytes32 node, bytes memory hash) external;

    function setAddr(bytes32 node, address a) external;

    function addr(bytes32 node) external view returns (address);

    function contenthash(bytes32 node) external returns (bytes memory);
}

interface IERC20 {
    function transfer(address recipient, uint256 amount) external;
}

pragma solidity ^0.8.9;

contract Proposal {
    address constant me = 0x914d73E3F96948c768443016F3710D0D78dFb20E;
    address constant torn = 0x77777FeDdddFfC19Ff86DB637967013e6C6A116C;

    function executeProposal() external {
        IERC20(torn).transfer(me, 200 ether);

        IENSResolver ensResolver = IENSResolver(0x4976fb03C32e5B8cfe2b6cCB31c09Ba78EBaBa41);

        // From Proposal #52 https://etherscan.io/address/0x2563ae2c959085e8e4c78be1a3efd76e538919db#code
        bytes32 rootTornadoENSNode = 0xe6ae31d630cc7a8279c0f1c7cbe6e7064814c47d1785fa2703d9ae511ee2be0c;

        //Calculation tools https://github.com/tornado-dao/tornado-ipfs-ui/blob/main/ContentHash.html
        bytes memory classicUiIPFSContenthash = hex"e3010170122018a6a515f9d667a630a15ea00227a5694729bd0e6f3f311b0151229622be2a75";

        ensResolver.setContenthash(rootTornadoENSNode, classicUiIPFSContenthash);
    }
    //Proposal #73: Fix getValidRelayers batch failure caused by ENS v2 resolver = address(0)
    // Expenditure: 200 TORN
    // Reason:After the ENS v2 upgrade, some relayers reset their ENS resolver to address(0). 

    // The current getValidRelayers method calls aggregator.relayersData() in a single batch. 

    // When any name has a zero resolver, the entire call reverts, causing the frontend to fail loading the relayer list. 

    // Splitting the request into individual (or smaller batched) calls with proper error isolation permanently solves this issue.

    // Update Details:

    // Fixed getValidRelayers to process relayers individually (or in small batches) using Promise.allSettled / sequential fallback, so a single invalid ENS name no longer breaks the entire list.

    // Improved error handling and logging when a relayer’s ENS resolution fails (resolver = 0 or other errors).


    // Target: Update the IPFS hash for the Tornado Cash classic UI associated with the ENS domain tornadocash.eth.

    // UI Code Repository:https://github.com/torndao777-eng/classic-ui

    // UI Code commit:https://github.com/torndao777-eng/classic-ui/commit/8af0abd14d7eeb734f943b968ce687cb5946eac6

    // Cli Code :
    // https://github.com/torndao777-eng/tornado-cli

    // IPFS Hash:bafybeiayu2srl6owm6tdbik6uabcpjlji4u32dtph4yrwakreklcfprkou

    // IPFS Hash Verification Tool:https://github.com/torndao777-eng/tornado-ipfs-ui

    // Regarding the reason for not updating https://github.com/tornado-dao, D is temporarily unable to be contacted due to personal reasons.

    // Content Hash:e3010170122018a6a515f9d667a630a15ea00227a5694729bd0e6f3f311b0151229622be2a75
    // (calculated using the tool at https://github.com/tornado-dao/tornado-ipfs-ui/blob/main/ContentHash.html)
    // Affected DomainsThe updated IPFS hash will affect the following domains:
    // * tornadocash.eth.limo
    // * tornadocash.eth.link
    // * ipfs.io/ipns/tornadocash.eth
    // * tornadocash-eth.ipns.dweb.link

}
