import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/drafts/Counters.sol";
import "./icrypto.sol";

contract CryptoRight is ICryptoRight {

    using Counters for Counters.Counter;

    Counters.Counter copyright_ids;

    // @TODO: Implement the Work struct

    struct Work {
        address owner;
        string uri;
    }

    // @TODO: Implement the copyrights mapping

    mapping(uint => Work) public copyrights;

    // @TODO: Implement the Copyright Event


    // @TODO: Implement the OpenSource Event

    // @TODO: Implement the Transfer Event

    event Copyright(uint copyright_id, address owner, string reference_uri);

    event OpenSource(uint copyright_id, string reference_uri);

    event Transfer(uint copyright_id, address new_owner);

    modifier onlyCopyrightOwner(uint copyright_id) {
        require(copyrights[copyright_id].owner ==msg.sender, "HOW ABOUT, NO");
        // @TODO: Check if copyright owner is equal to msg.sender
        _;
    }

    function copyrightWork(string memory reference_uri) public {
        // @TODO: Implement the copyrightWork function
        copyright_ids.increment();
        uint id = copyright_ids.current();

        copyrights[id] = Work(msg.sender, reference_uri);

        emit Copyright(id, msg.sender, reference_uri);
    }

    function openSourceWork(string memory reference_uri) public {
        // @TODO: Implement the copyrightWork function
        copyright_ids.increment();
        uint id = copyright_ids.current();

        copyrights[id].uri = reference_uri;

        emit OpenSource(id, reference_uri);
    }

    function transferCopyrightOwnership(uint copyright_id, address new_owner) public onlyCopyrightOwner(copyright_id) {
        // @TODO: Implement the copyrightWork function
        copyrights[copyright_id].owner = new_owner;
        emit Transfer(copyright_id, new_owner);
    }

        

    function renounceCopyrightOwnership(uint copyright_id) public onlyCopyrightOwner(copyright_id) {
        // @TODO: Implement the copyrightWork function
        transferCopyrightOwnership(copyright_id, address(0) );

        emit OpenSource(copyright_id, copyrights[copyright_id].uri);
    }

}
