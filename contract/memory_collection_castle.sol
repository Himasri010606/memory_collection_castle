// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title SimpleMemoryCastle
 * @dev A simplified, decentralized castle where users can store and share their memories in public rooms.
 * @author Memory Collection Castle Team (Simplified Version)
 */
contract SimpleMemoryCastle {

    struct Memory {
        uint256 id;
        address creator;
        string title;
        string description;
        uint256 timestamp;
        uint256 roomId;
        uint256 likes;
    }

    struct Room {
        uint256 id;
        string name;
        address owner;
        uint256 creationTime;
        uint256 memoryCount;
    }

    // State variables
    uint256 private nextMemoryId;
    uint256 private nextRoomId;

    mapping(uint256 => Memory) public memories;
    mapping(uint256 => Room) public rooms;
    mapping(address => uint256[]) public userMemories;
    mapping(address => uint256[]) public userRooms;
    mapping(uint256 => uint256[]) public roomMemories;
    mapping(uint256 => mapping(address => bool)) public memoryLikes;

    // Events
    event MemoryStored(uint256 indexed memoryId, address indexed creator, string title, uint256 roomId);
    event RoomCreated(uint256 indexed roomId, address indexed owner, string name);
    event MemoryLiked(uint256 indexed memoryId, address indexed liker);

    // Modifiers
    modifier memoryExists(uint256 _memoryId) {
        require(_memoryId < nextMemoryId, "Memory does not exist");
        _;
    }

    modifier roomExists(uint256 _roomId) {
        require(_roomId < nextRoomId, "Room does not exist");
        _;
    }

    /**
     * @dev Create a new public room in the castle.
     * @param _name Name of the room.
     */
    function createRoom(string memory _name) external returns (uint256) {
        require(bytes(_name).length > 0, "Room name cannot be empty");

        uint256 roomId = nextRoomId++;
        Room storage newRoom = rooms[roomId];

        newRoom.id = roomId;
        newRoom.name = _name;
        newRoom.owner = msg.sender;
        newRoom.creationTime = block.timestamp;
        newRoom.memoryCount = 0;

        userRooms[msg.sender].push(roomId);
        emit RoomCreated(roomId, msg.sender, _name);
        return roomId;
    }

    /**
     * @dev Store a new memory in a specific room.
     * @param _title Title of the memory.
     * @param _description Description of the memory.
     * @param _roomId The ID of the room where the memory will be stored.
     */
    function storeMemory(
        string memory _title,
        string memory _description,
        uint256 _roomId
    ) external roomExists(_roomId) returns (uint256) {
        require(bytes(_title).length > 0, "Memory title cannot be empty");

        uint256 memoryId = nextMemoryId++;
        Memory storage newMemory = memories[memoryId];

        newMemory.id = memoryId;
        newMemory.creator = msg.sender;
        newMemory.title = _title;
        newMemory.description = _description;
        newMemory.timestamp = block.timestamp;
        newMemory.roomId = _roomId;
        newMemory.likes = 0;

        userMemories[msg.sender].push(memoryId);
        roomMemories[_roomId].push(memoryId);
        rooms[_roomId].memoryCount++;

        emit MemoryStored(memoryId, msg.sender, _title, _roomId);
        return memoryId;
    }

    /**
     * @dev Like a memory. A user can only like a memory once.
     * @param _memoryId ID of the memory to like.
     */
    function likeMemory(uint256 _memoryId) external memoryExists(_memoryId) {
        require(!memoryLikes[_memoryId][msg.sender], "You have already liked this memory");

        memories[_memoryId].likes++;
        memoryLikes[_memoryId][msg.sender] = true;
        emit MemoryLiked(_memoryId, msg.sender);
    }

    /**
     * @dev Get details for a specific memory.
     */
    function getMemory(uint256 _memoryId)
        external
        view
        memoryExists(_memoryId)
        returns (Memory memory)
    {
        return memories[_memoryId];
    }

    /**
     * @dev Get all memory IDs within a specific room.
     */
    function getRoomMemories(uint256 _roomId)
        external
        view
        roomExists(_roomId)
        returns (uint256[] memory)
    {
        return roomMemories[_roomId];
    }
}
