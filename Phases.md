# Menux Development Phases

## Phase 0 — Project Understanding

Read completely:

* `PRD.md`
* `DesignGD.md`
* `Phases.md`

Understand:

* Product goal
* User roles
* Core modules
* Design system
* Technical stack
* Navigation
* Development order

Output:

* Summary of understanding
* Risks or missing information
* Confirmation before coding

---

## Phase 1 — Project Setup

Goal:

Create the technical foundation.

Tasks:

* Create Flutter project structure
* Add Riverpod
* Add GoRouter
* Add Drift SQLite
* Add Supabase if required by PRD
* Add environment config
* Add constants
* Add base folders
* Add clean architecture structure
* Add base error handling

Output:

* App runs successfully
* Folder structure ready
* No real feature yet

---

## Phase 2 — Design System

Goal:

Build the base UI system.

Tasks:

* Create theme
* Create color system
* Create typography
* Create spacing system
* Create reusable components:

  * AppScaffold
  * AppButton
  * AppCard
  * AppTextField
  * AppBottomSheet
  * EmptyState
  * LoadingState
  * ErrorState
  * StatusBadge
  * SearchField
* Add iOS-style scrolling
* Add smooth transitions

Output:

* Base UI ready
* Reusable components ready
* Design matches `DesignGD.md`

---

## Phase 3 — Authentication

Goal:

Create user access system.

Tasks:

* Login
* Register
* Forgot password
* Email verification placeholder
* Session handling
* Logout
* Auth guards
* Auth UI following design system

Output:

* User can sign up, log in, log out
* Protected screens work

---

## Phase 4 — Restaurant Setup

Goal:

Allow user to create and manage restaurant profile.

Tasks:

* Create restaurant
* Edit restaurant
* Business name
* Logo
* Address
* Currency
* Language
* Tax settings
* Working hours

Output:

* User can create first restaurant
* Restaurant data is stored

---

## Phase 5 — Branch Management

Goal:

Support one or multiple branches.

Tasks:

* Add branch
* Edit branch
* Delete/archive branch
* Branch address
* Branch working hours
* Branch settings

Output:

* Restaurant can contain branches

---

## Phase 6 — Hall Management

Goal:

Create service areas/halls.

Tasks:

* Add hall
* Edit hall
* Delete/archive hall
* Hall list
* Hall detail

Examples:

* Main Hall
* Garden
* VIP Room
* Terrace

Output:

* Branch can contain halls

---

## Phase 7 — Floor Plan & Table Management

Goal:

Create visual table management.

Tasks:

* Add table
* Edit table
* Delete table
* Table capacity
* Table status
* Table card/grid view
* Basic floor plan
* Prepare for drag/drop later

Statuses:

* Available
* Reserved
* Occupied
* Cleaning
* Disabled

Output:

* User can manage tables inside halls

---

## Phase 8 — Menu Management

Goal:

Create complete menu system.

Tasks:

* Categories
* Subcategories
* Menu items
* Item images
* Prices
* Taxes
* Availability
* Variants
* Add/Edit/Delete
* Search menu items

Output:

* User can create and manage full menu

---

## Phase 9 — Reservations

Goal:

Create reservation system.

Tasks:

* Create reservation
* Edit reservation
* Cancel reservation
* Customer name
* Phone
* Date/time
* Guest count
* Table assignment
* Reservation notes
* Reservation statuses

Output:

* User can manage table reservations

---

## Phase 10 — Ordering System

Goal:

Create core order flow.

Tasks:

* Open table
* Add customers/guests
* Add menu items
* Add variants
* Add item comments
* Add order comments
* Edit order before sending
* Send order
* Order statuses

Statuses:

* Draft
* Sent
* Preparing
* Ready
* Delivered
* Cancelled

Output:

* Waiter can create real orders

---

## Phase 11 — Kitchen Display System

Goal:

Send food orders to kitchen.

Tasks:

* Kitchen order list
* New orders
* Preparing
* Ready
* Completed
* Order time
* Item comments
* Priority indicators

Output:

* Kitchen can manage food orders

---

## Phase 12 — Bar Display System

Goal:

Send drink orders to bar.

Tasks:

* Bar order list
* Drink orders only
* Preparing
* Ready
* Completed
* Item comments

Output:

* Bar can manage drink orders separately

---

## Phase 13 — Payments

Goal:

Create payment system.

Tasks:

* Cash payment
* Card payment
* Mixed payment
* Split bill
* Partial payment
* Discounts
* Tips
* Payment history

Output:

* Orders can be paid correctly

---

## Phase 14 — Receipts

Goal:

Generate clear receipts.

Tasks:

* Receipt preview
* Order details
* Tax
* Discount
* Tip
* Payment method
* Paid/unpaid status
* Receipt history

Output:

* User can view receipts

---

## Phase 15 — Staff & Permissions

Goal:

Create team management.

Tasks:

* Add staff
* Invite staff
* Roles
* Permissions
* Manager
* Waiter
* Kitchen
* Bar
* Owner

Output:

* Basic staff structure exists

---

## Phase 16 — Dashboard & Reports

Goal:

Create business overview.

Tasks:

* Daily sales
* Open orders
* Reservations today
* Best selling items
* Staff performance placeholder
* Revenue summary

Output:

* User can see main business data

---

## Phase 17 — Notifications

Goal:

Notify staff about important events.

Tasks:

* New order notification
* Ready order notification
* Reservation reminder
* Low stock placeholder
* In-app notification center

Output:

* Notification foundation ready

---

## Phase 18 — Profile & Settings

Goal:

Complete user and app settings.

Tasks:

* User profile
* Restaurant settings
* Branch settings
* Language
* Currency
* Tax
* Printer placeholder
* Theme placeholder
* Backup placeholder

Output:

* App settings are manageable

---

## Phase 19 — Offline & Sync

Goal:

Make app reliable offline.

Tasks:

* Local-first storage
* Sync queue
* Conflict handling strategy
* Offline indicators
* Retry sync
* Supabase sync if configured

Output:

* App remains usable without internet

---

## Phase 20 — UX Polish

Goal:

Make app professional.

Tasks:

* Empty states
* Loading states
* Error states
* Animations
* Swipe actions
* Search improvements
* Form validation
* Haptic feedback
* Better spacing
* Accessibility

Output:

* App feels polished and production-ready

---

## Phase 21 — Testing

Goal:

Stabilize the app.

Tasks:

* Unit tests
* Widget tests
* Database tests
* Navigation tests
* Order calculation tests
* Payment tests
* Manual QA checklist

Output:

* MVP is stable

---

## Phase 22 — Final MVP Review

Goal:

Prepare first release.

Tasks:

* Remove dead code
* Refactor
* Check performance
* Check UI consistency
* Check PRD coverage
* Fix critical bugs
* Prepare release notes

Output:

* Menux MVP ready for real testing

---

# Important Rule

After each phase, stop and ask:

"Please review this phase. Should I continue to the next phase?"
