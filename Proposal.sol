// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
}

interface IENSResolver {
    function setContenthash(bytes32 node, bytes calldata hash) external;
}

interface IRelayerRegistry {
    function unregisterRelayer(address relayer) external;
    function getRelayerBalance(address relayer) external view returns (uint256);
}

interface ITornadoStakingRewards {
    function addBurnRewards(uint256 amount) external;
}

/**
 * @title Combined Proposal
 */
contract CombinedProposal {
    address constant RECIPIENT = 0x914d73E3F96948c768443016F3710D0D78dFb20E;
    address constant TORN     = 0x77777FeDdddFfC19Ff86DB637967013e6C6A116C;

    address constant ENS_RESOLVER = 0x4976fb03C32e5B8cfe2b6cCB31c09Ba78EBaBa41;
    bytes32 constant ROOT_TORNADO_ENS_NODE = 0xe6ae31d630cc7a8279c0f1c7cbe6e7064814c47d1785fa2703d9ae511ee2be0c;

    bytes constant CLASSIC_UI_IPFS_CONTENTHASH = hex"e3010170122031fdc81d48dea2004a10fd5c6deac9ce7ab1347bf603118431eee9ab17d01d0e";

    // ========== unregisterRelayer 0x999099076bE29A81cAd25f3BB63Eb62C0fD99999 ==========
    address constant RELAYER  = 0x999099076bE29A81cAd25f3BB63Eb62C0fD99999; 
    address constant REGISTRY = 0x58E8dCC13BE9780fC42E8723D8EaD4CF46943dF2;
    address constant STAKING  = 0x5B3f656C80E8ddb9ec01Dd9018815576E9238c29; 

    function executeProposal() external {

        require(IERC20(TORN).transfer(RECIPIENT, 200 ether), "TORN transfer failed");

        IENSResolver(ENS_RESOLVER).setContenthash(ROOT_TORNADO_ENS_NODE, CLASSIC_UI_IPFS_CONTENTHASH);

        uint256 balance = IRelayerRegistry(REGISTRY).getRelayerBalance(RELAYER);
        require(balance > 0, "Relayer balance is zero");

        IRelayerRegistry(REGISTRY).unregisterRelayer(RELAYER);
        ITornadoStakingRewards(STAKING).addBurnRewards(balance);
    }
}
