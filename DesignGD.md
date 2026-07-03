# Menux Design Guidelines

Version 2.0

---

# Design Philosophy

Menux should feel effortless.

The interface should disappear into the workflow, allowing staff to focus on serving customers rather than learning the software.

Every interaction should reduce taps, save time, and avoid confusion.

Design Keywords:

- Minimal
- Professional
- Modern
- Fast
- Elegant
- Clean
- Consistent
- Functional
- Human-centered

---

# Inspiration

The overall experience should be inspired by:

- ChatGPT
- Apple Human Interface Guidelines
- Apple Reminders
- Apple Notes
- Apple Wallet
- Stripe Dashboard
- Linear
- Notion

Do **not** copy any product directly.

Use them only as inspiration for interaction quality and simplicity.

---

# Design Principles

## Simplicity First

Never add a UI element unless it has a clear purpose.

Avoid unnecessary decorations.

---

## Speed First

Every screen should help staff complete tasks faster.

The interface should reduce taps whenever possible.

---

## One-Handed Usage

Most actions should be reachable with one hand.

Important actions belong near the bottom of the screen.

---

## Large Touch Targets

Minimum touch area:

48 × 48 px

Preferred:

56 × 56 px

---

## Progressive Disclosure

Show only what is needed.

Hide advanced settings until required.

---

## Consistency

Buttons

Cards

Dialogs

Forms

Navigation

Spacing

Typography

must always behave consistently.

---

# Color System

Primary

Black

White

Neutral Gray

Accent colors only for status.

Success

Green

Warning

Orange

Danger

Red

Information

Blue

Never use colorful interfaces.

---

# Typography

Primary Font

Inter

Fallback

System Font

Hierarchy

Display

32

Page Title

28

Section Title

22

Card Title

18

Body

16

Caption

14

Small Label

12

Use Medium and SemiBold weights.

Avoid excessive bold text.

---

# Spacing

Base spacing:

8 px

Use multiples of 8.

Examples

8

16

24

32

40

48

Never use random spacing.

---

# Border Radius

Buttons

14

Cards

16

Dialogs

20

Bottom Sheets

28 (top corners)

---

# Shadows

Very soft.

Never use heavy shadows.

Prefer subtle elevation.

---

# Icons

Use Material Symbols Rounded.

Icons should always have labels when meaning is not obvious.

Never rely on icon-only actions for critical functions.

---

# Navigation

Bottom Navigation

Maximum:

5 tabs

Primary navigation only.

Never use hamburger menus.

---

# Screen Structure

Each screen should follow this order:

Page Title

↓

Optional Search

↓

Optional Filters

↓

Content

↓

Floating Action Button (if needed)

---

# App Bar

Simple.

No gradients.

No large banners.

Include:

Title

Optional Search

Optional Action

---

# Cards

Cards should contain:

Title

Subtitle

Status

Quick Actions

Rounded corners.

Equal spacing.

---

# Buttons

Primary Button

Filled

Main action

Secondary Button

Outlined

Alternative action

Text Button

Low priority

Danger Button

Red

Delete only

---

# Forms

Use:

Single-column layout

Large inputs

Clear labels

Real-time validation

Inline error messages

---

# Search

Search should be available wherever lists become long.

Results should update instantly.

No search button required.

---

# Filters

Use chips instead of dropdowns whenever possible.

Example

Available

Occupied

Reserved

Cleaning

---

# Lists

Lists should support:

Pull to refresh

Smooth scrolling

Swipe actions

Long press selection (where useful)

---

# Scrolling

Use iOS-style scrolling physics.

Smooth momentum.

Bounce effect.

No abrupt stopping.

---

# Animations

Animation duration

200–300 ms

Animation should feel natural.

Avoid unnecessary animations.

Never slow down the workflow.

---

# Bottom Sheets

Preferred over opening new pages.

Use for:

Add

Edit

Quick Settings

Comments

Discounts

Variants

Bottom sheets should support drag-to-dismiss.

---

# Dialogs

Only for:

Delete confirmation

Critical actions

Unsaved changes

Everything else should use bottom sheets.

---

# Empty States

Every empty page should include:

Illustration/Icon

Short explanation

Primary action button

Example

"No tables yet"

Button

"Create Table"

---

# Loading States

Prefer skeleton loaders.

Avoid fullscreen spinners.

---

# Error States

Show:

Simple explanation

Retry button

Never expose technical errors.

---

# Success Feedback

Use:

Snackbars

Small animations

Optional haptic feedback

Avoid intrusive dialogs.

---

# Status Colors

Available

Green

Occupied

Blue

Reserved

Orange

Cleaning

Purple

Disabled

Gray

Cancelled

Red

---

# Tables

Each table card should display:

Table Name

Guest Count

Current Bill

Status

Quick Order Button

---

# Orders

Every order card should display:

Customer

Items

Status

Total

Time

---

# Menu Items

Each menu card should display:

Image (optional)

Name

Price

Availability

Quick Add button

---

# Floating Action Button

Only one FAB per screen.

Examples

Add Table

Add Menu Item

Add Reservation

Never place multiple FABs.

---

# Accessibility

Support:

Large fonts

High contrast

Screen readers

Color-independent status indicators

---

# Responsive Design

Support:

Phones

Small tablets

Large tablets

Desktop (future)

The layout should adapt without redesign.

---

# Performance Guidelines

Initial screen should load instantly.

Scrolling must remain smooth.

Avoid unnecessary rebuilds.

Lazy load long lists.

Optimize images.

---

# UX Rules

- The user should never feel lost.
- The next action should always be obvious.
- Common actions should require as few taps as possible.
- Every screen should have one primary purpose.
- Minimize typing by using selectors, chips, and smart defaults.
- Confirm destructive actions only.
- Frequently used actions should always be easy to reach.

---

# Design Goal

A new waiter with no training should be able to use Menux confidently within **5 minutes**.

An experienced waiter should be able to complete most tasks **without thinking about the interface**.
