// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.25;

import "../lib/forge-std/src/Test.sol";
import "../src/Owner.sol";

contract OwnerTest is Test {
    Owner ownerContract;
    address deployer = address(0xABCD);
    address newOwner = address(0x1234);
    address nonOwner = address(0xDEAD);

    event OwnerSet(address indexed oldOwner, address indexed newOwner);

    function setUp() public {
        vm.prank(deployer);
        ownerContract = new Owner();
    }

    // -----------------------------------------------------------
    // Constructor Tests
    // -----------------------------------------------------------

    function testConstructorSetsOwnerCorrectly() public view {
        assertEq(ownerContract.getOwner(), deployer, "Deployer should be owner");
    }

    function testConstructorEmitsOwnerSetEvent() public {
        vm.prank(deployer);
        vm.expectEmit(true, true, false, true);
        emit OwnerSet(address(0), deployer);

        new Owner();
    }

    // -----------------------------------------------------------
    // getOwner()
    // -----------------------------------------------------------

    function testGetOwnerWorks() public view {
        assertEq(ownerContract.getOwner(), deployer);
    }

    // -----------------------------------------------------------
    // changeOwner()
    // -----------------------------------------------------------

    function testOwnerCanChangeOwner() public {
        vm.prank(deployer);

        vm.expectEmit(true, true, false, true);
        emit OwnerSet(deployer, newOwner);

        ownerContract.changeOwner(newOwner);

        assertEq(ownerContract.getOwner(), newOwner, "New owner should be set");
    }

    function testChangeOwnerRevertsIfNotOwner() public {
        vm.prank(nonOwner);

        vm.expectRevert("Caller is not owner");
        ownerContract.changeOwner(newOwner);
    }

    function testChangeOwnerRevertsIfZeroAddress() public {
        vm.prank(deployer);

        vm.expectRevert("New owner should not be the zero address");
        ownerContract.changeOwner(address(0));
    }

    // -----------------------------------------------------------
    // Changing owner again with updated owner
    // -----------------------------------------------------------

    function testNewOwnerCanChangeOwnerAgain() public {
        // Step 1: old owner assigns new owner
        vm.prank(deployer);
        ownerContract.changeOwner(newOwner);

        // Step 2: new owner reassigns
        address thirdOwner = address(0xBEEF);

        vm.prank(newOwner);
        vm.expectEmit(true, true, false, true);
        emit OwnerSet(newOwner, thirdOwner);

        ownerContract.changeOwner(thirdOwner);

        assertEq(ownerContract.getOwner(), thirdOwner);
    }

    // -----------------------------------------------------------
    // Fuzzing
    // -----------------------------------------------------------

    function testFuzzChangeOwner(address random) public {
        vm.assume(random != address(0));
        vm.prank(deployer);
        ownerContract.changeOwner(random);
        assertEq(ownerContract.getOwner(), random);
    }

    function testFuzzCallerMustBeOwner(address randomCaller, address randomOwner) public {
        vm.assume(randomCaller != randomOwner);
        vm.assume(randomOwner != address(0));

        // Set a known owner
        vm.prank(deployer);
        ownerContract.changeOwner(randomOwner);

        // Now randomCaller tries to change owner
        vm.prank(randomCaller);
        vm.expectRevert("Caller is not owner");
        ownerContract.changeOwner(address(0x1111));
    }
}