# Product Requirements Document (PRD)

# Menux

Version: 2.0

---

# 1. Product Overview

Menux is a modern restaurant and hospitality management platform designed to simplify daily operations for restaurants, cafés, hotels, bars, and event venues.

The system enables staff to manage tables, orders, reservations, payments, menus, and team collaboration through an intuitive interface.

The product is designed with a clean, minimal, and mobile-first experience while remaining scalable for larger businesses.

---

# 2. Goals

The application should:

- Simplify restaurant operations
- Reduce waiter mistakes
- Speed up ordering
- Improve communication between staff
- Support restaurants of any size
- Work reliably offline
- Synchronize data when internet is available

---

# 3. Target Users

- Restaurant Owners
- Managers
- Waiters
- Bartenders
- Kitchen Staff
- Hotel Staff
- Event Staff

---

# 4. Core Modules

## Authentication

- Login
- Register
- Forgot Password
- Email Verification
- Organization Invitation

---

## Restaurant Management

Users can create and manage restaurants.

Each restaurant can contain:

- Branches
- Halls
- Tables
- Staff
- Menus

---

## Branch Management

Support multiple branches.

Each branch has:

- Name
- Address
- Working Hours
- Staff
- Halls

---

## Hall Management

Examples:

- Main Hall
- Garden
- VIP Room
- Terrace

---

## Floor Plan

Managers can visually arrange tables.

Features:

- Drag & Drop
- Resize
- Rotate
- Merge Tables
- Duplicate Tables

---

## Table Management

Each table has:

- Name
- Capacity
- Status

Statuses:

- Available
- Reserved
- Occupied
- Cleaning
- Disabled

---

## Reservations

Create reservations with:

- Customer
- Date
- Time
- Guest Count
- Notes

---

## Menu Management

Unlimited:

- Categories
- Subcategories
- Items
- Variants

Each item supports:

- Image
- Description
- Price
- Taxes
- Availability

---

## Ordering

Waiters can:

- Open Table
- Add Customers
- Create Orders
- Edit Orders
- Move Orders
- Merge Orders
- Split Bills
- Send Orders

---

## Kitchen Display

Kitchen receives food orders.

Functions:

- New Orders
- Preparing
- Ready
- Completed

---

## Bar Display

Bar receives drink orders.

Independent from kitchen.

---

## Payments

Support:

- Cash
- Card
- Mixed

Functions:

- Split Bills
- Partial Payments
- Tips
- Discounts

---

## Receipts

Generate receipts containing:

- Items
- Taxes
- Discounts
- Payment Method
- Order History

---

## Staff Management

Manage:

- Employees
- Roles
- Permissions
- Shifts

---

## Customer Management

Store:

- Name
- Phone
- Notes
- Visit History
- Loyalty Points

---

## Reports

Dashboard includes:

- Sales
- Orders
- Best Selling Items
- Staff Performance
- Revenue
- Daily Summary

---

## Notifications

Notify users about:

- New Orders
- Reservations
- Completed Food
- Low Inventory
- Staff Messages

---

## Settings

Business settings:

- Currency
- Language
- Tax
- Printer
- Theme
- Backup

---

# 5. Navigation

Bottom Navigation

- Dashboard
- Orders
- Reservations
- Messages
- More

---

# 6. Design Principles

- Minimal
- Black & White
- Modern
- Fast
- Mobile First
- Touch Friendly
- Consistent
- Apple-inspired interactions
- Smooth scrolling
- Simple navigation
- Large buttons

---

# 7. Technical Requirements

Frontend

- Flutter

Backend

- Supabase

Database

- PostgreSQL

State Management

- Riverpod

Architecture

- Clean Architecture

Offline

- Supported

Cloud Sync

- Automatic

---

# 8. Non-Functional Requirements

- Responsive UI
- Fast startup
- Offline-first
- Secure authentication
- Real-time synchronization
- Scalable architecture
- Reusable components
- Modular codebase

---

# 9. Future Features

- QR Ordering
- Self Checkout
- Online Ordering
- Delivery Integration
- Inventory Management
- AI Reports
- Printer Support
- Analytics
- Multi-language
- Multi-currency

---

# 10. Success Criteria

The product is successful when users can:

- Set up a restaurant in under 10 minutes.
- Create menus without technical knowledge.
- Take and manage orders quickly.
- Process payments accurately.
- Coordinate kitchen and bar efficiently.
- Manage daily operations from a single application.
