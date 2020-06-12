pragma solidity 0.5.7;

import "./Hex2XToken.sol";

contract GlobalsAndUtility is Hex2XToken {
    /* Define events */
    event XfLobbyEnter(
        uint40 timestamp,
        address indexed memberAddr,
        uint256 indexed entryId,
        uint96 rawAmount,
        address indexed referrerAddr
    );

    event XfLobbyExit(
        uint40 timestamp,
        address indexed memberAddr,
        uint256 indexed entryId,
        uint72 xfAmount,
        address indexed referrerAddr
    );

    event DailyDataUpdate(
        uint40 timestamp,
        uint16 dailyDataCountAdded,
        uint16 dailyDataCount,
        bool isAutoUpdate,
        address indexed updaterAddr
    );

    event Claim(
        uint40 timestamp,
        address indexed claimToAddr,
        bytes20 indexed btcAddr,
        uint8 claimFlags,
        uint56 rawHex,
        uint56 adjHex,
        uint72 claimedHearts,
        address indexed referrerAddr,
        address senderAddr
    );

    event ClaimAssist(
        uint40 timestamp,
        address claimToAddr,
        uint8 claimFlags,
        uint56 rawHex,
        uint56 adjHex,
        uint72 claimedHearts,
        address referrerAddr,
        address indexed senderAddr
    );

    event StakeStart(
        uint40 timestamp,
        address indexed stakerAddr,
        uint40 indexed stakeId,
        uint72 stakedHearts,
        uint72 stakeShares,
        uint16 stakedDays,
        bool isAutoStake
    );

    event StakeGoodAccounting(
        uint40 timestamp,
        address indexed stakerAddr,
        uint40 indexed stakeId,
        uint72 payout,
        uint72 penalty,
        address indexed senderAddr
    );

    event StakeEnd(
        uint40 timestamp,
        address indexed stakerAddr,
        uint40 indexed stakeId,
        uint72 payout,
        uint72 penalty,
        uint16 servedDays
    );

    event ShareRateChange(
        uint40 timestamp,
        uint40 shareRate,
        uint40 indexed stakeId
    );

    /* Origin address */
    address internal constant ORIGIN_ADDR = 0xa626D82da4767852a7ba4daBc9321a87d8631941;

    /* Flush address */
    address payable internal constant FLUSH_ADDR = 0x56Dfb043018c96f6c699b30204cdFaB09C9E72FE;

    uint256 private constant HEARTS_PER_HEX2X = 10 ** uint256(decimals); // 1e8
    uint256 private constant HEX2X_PER_HEX = 1;

    /* Time of contract launch (2019-03-04T00:00:00Z) */
    uint256 internal constant LAUNCH_TIME = 1551657600;

    /* Size of a Hearts or Shares uint */
    uint256 internal constant HEART_UINT_SIZE = 72;

    /* Size of a transform lobby entry index uint */
    uint256 internal constant XF_LOBBY_ENTRY_INDEX_SIZE = 40;
    uint256 internal constant XF_LOBBY_ENTRY_INDEX_MASK = (1 << XF_LOBBY_ENTRY_INDEX_SIZE) - 1;

    /* Seed for WAAS Lobby */
    uint256 internal constant WAAS_LOBBY_SEED_HEX2X = 1e9;
    uint256 internal constant WAAS_LOBBY_SEED_HEARTS = WAAS_LOBBY_SEED_HEX2X * HEARTS_PER_HEX2X;

    /* Start of claim phase */
    uint256 internal constant PRE_CLAIM_DAYS = 1;
    uint256 internal constant CLAIM_PHASE_START_DAY = PRE_CLAIM_DAYS;

    /* Length of claim phase */
    uint256 private constant CLAIM_PHASE_WEEKS = 50;
    uint256 internal constant CLAIM_PHASE_DAYS = CLAIM_PHASE_WEEKS * 7;

    /* End of claim phase */
    uint256 internal constant CLAIM_PHASE_END_DAY = CLAIM_PHASE_START_DAY + CLAIM_PHASE_DAYS;

    /* Number of words to hold 1 bit for each transform lobby day */
    uint256 internal constant XF_LOBBY_DAY_WORDS = (CLAIM_PHASE_END_DAY + 255) >> 8;

    /* WAAS lump day */
    uint256 internal constant WAAS_LUMP_DAY = CLAIM_PHASE_END_DAY + 1;
}