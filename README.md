# Proposal #73: Fix getValidRelayers batch failure caused by ENS v2 resolver = address(0)
Expenditure: 200 TORN

Reason: After the ENS v2 upgrade, some relayers reset their ENS resolver to address(0). 

The current getValidRelayers method calls aggregator.relayersData() in a single batch. 

When any name has a zero resolver, the entire call reverts, causing the frontend to fail loading the relayer list. 

Splitting the request into individual (or smaller batched) calls with proper error isolation permanently solves this issue.

Update Details:

Fixed getValidRelayers to process relayers individually (or in small batches) using Promise.allSettled / sequential fallback, so a single invalid ENS name no longer breaks the entire list.

Improved error handling and logging when a relayer’s ENS resolution fails (resolver = 0 or other errors).


Target: Update the IPFS hash for the Tornado Cash classic UI associated with the ENS domain tornadocash.eth.

UI Code Repository: https://github.com/torndao777-eng/classic-ui

UI Code commit: https://github.com/torndao777-eng/classic-ui/commit/8af0abd14d7eeb734f943b968ce687cb5946eac6

Cli Code :
https://github.com/torndao777-eng/tornado-cli

IPFS Hash: bafybeiayu2srl6owm6tdbik6uabcpjlji4u32dtph4yrwakreklcfprkou

IPFS Hash Verification Tool: https://github.com/torndao777-eng/tornado-ipfs-ui

Regarding the reason for not updating https://github.com/tornado-dao, D is temporarily unable to be contacted due to personal reasons.

Content Hash: e3010170122018a6a515f9d667a630a15ea00227a5694729bd0e6f3f311b0151229622be2a75
 (calculated using the tool at https://github.com/tornado-dao/tornado-ipfs-ui/blob/main/ContentHash.html)
Affected Domains The updated IPFS hash will affect the following domains:
* tornadocash.eth.limo
* tornadocash.eth.link
* ipfs.io/ipns/tornadocash.eth
* tornadocash-eth.ipns.dweb.link




