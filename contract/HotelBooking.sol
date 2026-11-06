// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract HotelBooking {

    // The account that deploys this contract becomes the hotel owner.
    address public owner;

    uint256 public nextBookingId = 1;

    enum BookingStatus {
        Pending,
        Confirmed,
        Cancelled,
        Completed
    }

    struct Booking {
        uint256 id;
        address guest;
        string roomType;
        uint256 checkIn;
        uint256 checkOut;
        uint256 payment;
        BookingStatus status;
    }

    mapping(uint256 => Booking) private bookings;

    event BookingCreated(
        uint256 bookingId,
        address guest,
        string roomType
    );

    event BookingUpdated(
        uint256 bookingId,
        BookingStatus status
    );

    modifier onlyOwner() {
        require(msg.sender == owner, "Only hotel owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    // Guest creates a booking and sends test ETH.
    function createBooking(
        string memory roomType,
        uint256 checkIn,
        uint256 checkOut
    ) public payable returns (uint256) {

        require(bytes(roomType).length > 0, "Room type required");
        require(checkIn > block.timestamp, "Check-in must be future");
        require(checkOut > checkIn, "Invalid dates");
        require(msg.value > 0, "Payment required");

        uint256 bookingId = nextBookingId;

        bookings[bookingId] = Booking(
            bookingId,
            msg.sender,
            roomType,
            checkIn,
            checkOut,
            msg.value,
            BookingStatus.Pending
        );

        nextBookingId++;

        emit BookingCreated(bookingId, msg.sender, roomType);

        return bookingId;
    }

    // Only the hotel owner can confirm a booking.
    function confirmBooking(uint256 bookingId) public onlyOwner {

        require(bookings[bookingId].id != 0, "Booking not found");
        require(
            bookings[bookingId].status == BookingStatus.Pending,
            "Booking is not pending"
        );

        bookings[bookingId].status = BookingStatus.Confirmed;

        emit BookingUpdated(
            bookingId,
            BookingStatus.Confirmed
        );
    }

    // Guest or hotel owner can cancel a booking.
    function cancelBooking(uint256 bookingId) public {

        require(bookings[bookingId].id != 0, "Booking not found");

        require(
            msg.sender == bookings[bookingId].guest ||
            msg.sender == owner,
            "Not authorised"
        );

        require(
            bookings[bookingId].status == BookingStatus.Pending ||
            bookings[bookingId].status == BookingStatus.Confirmed,
            "Cannot cancel booking"
        );

        bookings[bookingId].status = BookingStatus.Cancelled;

        emit BookingUpdated(
            bookingId,
            BookingStatus.Cancelled
        );
    }

    // TODO: Complete this function yourself.
    // Decide when a booking can be marked Completed and test it.
    function completeBooking(uint256 bookingId) public onlyOwner {
        // Add booking-exists validation.
        // Add a check that the booking is Confirmed.
        // Change the status to Completed.
        // Emit BookingUpdated.
    }

    // Anyone can read the booking details.
    function getBooking(uint256 bookingId)
        public
        view
        returns (Booking memory)
    {
        require(bookings[bookingId].id != 0, "Booking not found");

        return bookings[bookingId];
    }
}