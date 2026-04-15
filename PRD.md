# Product Requirements Document (PRD)
## FamilyGo — Family Activity Discovery & Booking Platform
**Version:** 1.0.0  
**Status:** Draft — Ready for Engineering Review  
**Last Updated:** April 2026  
**Owner:** Product Team  
**Reviewers:** Engineering Lead, Design Lead, QA Lead, CTO

---

## Table of Contents

1. [Product Overview](#1-product-overview)
2. [Problem Statement & Value Proposition](#2-problem-statement--value-proposition)
3. [User Personas](#3-user-personas)
4. [Key Use Cases](#4-key-use-cases)
5. [Feature List — MVP & Future Scope](#5-feature-list--mvp--future-scope)
6. [User Flows & Journeys](#6-user-flows--journeys)
7. [Functional Requirements](#7-functional-requirements)
8. [Non-Functional Requirements](#8-non-functional-requirements)
9. [System Architecture](#9-system-architecture)
10. [Data Models & Storage Design](#10-data-models--storage-design)
11. [Third-Party Integrations](#11-third-party-integrations)
12. [UI/UX Guidelines](#12-uiux-guidelines)
13. [Edge Cases & Failure Scenarios](#13-edge-cases--failure-scenarios)
14. [Analytics & Tracking Plan](#14-analytics--tracking-plan)
15. [Deployment Strategy](#15-deployment-strategy)
16. [Testing Strategy](#16-testing-strategy)
17. [Risks & Mitigation](#17-risks--mitigation)
18. [Milestones & Roadmap](#18-milestones--roadmap)

---

## 1. Product Overview

### 1.1 Vision

FamilyGo is a mobile-first platform that helps parents discover, book, and enjoy the best activities and experiences for their children — instantly, locally, and affordably. It removes the friction of finding age-appropriate, trusted, and available activities by aggregating them in one curated, searchable, bookable interface.

### 1.2 Mission Statement

> *"Give every family 5 minutes to plan a perfect day out, regardless of budget, location, or how old their kids are."*

### 1.3 Strategic Goals

| # | Goal | Success Metric | Target (12 months) |
|---|------|----------------|-------------------|
| G1 | Drive user acquisition | Monthly Active Users (MAU) | 150,000 MAU |
| G2 | Generate transaction revenue | Gross Merchandise Value (GMV) | $2M GMV |
| G3 | Build supply-side depth | Verified partner venues | 500+ venues |
| G4 | Retain families | 30-day retention rate | ≥ 40% |
| G5 | Enable loyalty loop | Rewards redemption rate | ≥ 25% of eligible users |

### 1.4 Platforms

| Platform | Priority | Target Version |
|----------|----------|----------------|
| Android | P0 | Android 7.1+ (API 25+) |
| iOS | P0 | iOS 14.0+ |
| Web (Flutter Web) | P2 | Modern browsers — secondary to native apps |

### 1.5 Supported Languages (MVP)

- English (default)
- Arabic (RTL layout support required from day one)

---

## 2. Problem Statement & Value Proposition

### 2.1 Problem Statement

Parents in urban markets face a fragmented discovery experience when looking for things to do with their children:

- **Discovery is scattered.** Activity information lives across social media, Google searches, review sites, WhatsApp groups, and venue-specific apps with no aggregation.
- **Trust is unclear.** There is no reliable source for knowing if a venue is appropriate for a specific age group, open today, and worth the price.
- **Booking is broken.** Most venues require a phone call or walk-in — there is no unified digital booking layer.
- **Deals are missed.** Promotional offers from venues have no distribution channel and expire undiscovered.
- **Planning is time-intensive.** A parent can spend 30–60 minutes researching a single outing, often abandoning the effort.

### 2.2 Value Proposition

| For Parents | For Venue Partners |
|-------------|-------------------|
| Curated, trusted activity listings in one place | Direct digital distribution channel to high-intent parents |
| Age-filtered discovery — no irrelevant results | Booking management and real-time availability |
| Instant booking without calls or queues | Deal publishing tools to drive off-peak traffic |
| Loyalty rewards on every booking | Analytics on impressions, clicks, and conversions |
| Saved favourites and wishlist management | Ratings and review aggregation |

### 2.3 Competitive Differentiation

| Feature | FamilyGo | Generic Search | Social Media | Venue Apps |
|---------|----------|---------------|-------------|-----------|
| Age-filtered discovery | ✅ | ❌ | ❌ | Partial |
| Real-time booking | ✅ | ❌ | ❌ | Partial |
| Deal aggregation | ✅ | ❌ | ❌ | ❌ |
| Loyalty/rewards | ✅ | ❌ | ❌ | ❌ |
| Verified venue data | ✅ | Unverified | Unverified | ✅ |
| Multi-venue in one app | ✅ | ❌ | ❌ | ❌ |

---

## 3. User Personas

### Persona 1 — Sara, The Busy Parent
- **Age:** 34  
- **Location:** Dubai, UAE  
- **Children:** Two kids aged 4 and 7  
- **Tech comfort:** High — daily smartphone user  
- **Behaviour:** Searches for activities on weekends, often last-minute. Prioritises safety, cleanliness, and age-appropriateness.  
- **Pain points:** Too many irrelevant results; unsure what is suitable for different age groups; hates calling venues to check availability.  
- **Goal:** Find a verified, bookable activity within 10 minutes for a specific Saturday.  
- **Key features needed:** Age filter, same-day availability, venue photos, reviews, instant booking.

---

### Persona 2 — Ahmed, The Deal Hunter
- **Age:** 29  
- **Location:** Sharjah, UAE  
- **Children:** One child aged 3  
- **Tech comfort:** High  
- **Behaviour:** Price-sensitive. Looks for promotions, BOGO deals, and off-peak discounts. Shares deals in family WhatsApp groups.  
- **Pain points:** Deals expire before he finds them. Discount apps show irrelevant adult-focused offers.  
- **Goal:** Get maximum value per outing. Earn rewards on every booking.  
- **Key features needed:** Deals section, Rewards programme, share-with-friends, price sorting.

---

### Persona 3 — Nadia, The Planner
- **Age:** 38  
- **Location:** Abu Dhabi, UAE  
- **Children:** Three kids aged 6, 9, and 12  
- **Tech comfort:** Medium  
- **Behaviour:** Plans outings 1–2 weeks in advance. Reads reviews carefully. Saves wishlists. Buys birthday packages.  
- **Pain points:** Can't find experiences that work simultaneously for different age groups. Birthday party bookings require too much back-and-forth.  
- **Goal:** Plan a structured outing for a group of kids of varied ages.  
- **Key features needed:** Multi-age filtering, birthday packages, group bookings, advance scheduling.

---

### Persona 4 — Venue Manager (B2B)
- **Name:** Omar  
- **Role:** Operations Manager at a trampoline park  
- **Goal:** Fill off-peak slots, promote birthday packages, and view booking analytics.  
- **Pain points:** Low digital visibility; reliance on walk-ins; no direct marketing channel.  
- **Key features needed:** Venue dashboard (web), deal creation tools, booking management, review moderation.

> **Note:** Persona 4 uses a separate Venue Partner web dashboard (out of scope for this mobile PRD but an integration dependency).

---

## 4. Key Use Cases

| ID | Use Case | Persona | Priority |
|----|----------|---------|----------|
| UC-01 | Discover activities by location and age | Sara | P0 |
| UC-02 | Search by keyword, category, or mood | Sara / Ahmed | P0 |
| UC-03 | Book a venue slot for a specific date and time | Sara | P0 |
| UC-04 | Browse and claim deals | Ahmed | P0 |
| UC-05 | Register and manage user profile | All | P0 |
| UC-06 | View and manage bookings | Sara | P0 |
| UC-07 | Earn and redeem rewards points | Ahmed | P1 |
| UC-08 | Save venues to a wishlist | Nadia | P1 |
| UC-09 | Read and write venue reviews | Sara / Nadia | P1 |
| UC-10 | Book a birthday party package | Nadia | P1 |
| UC-11 | View venue on a map | All | P1 |
| UC-12 | Share a venue or deal with contacts | Ahmed | P1 |
| UC-13 | Receive personalised activity recommendations | Sara | P2 |
| UC-14 | Buy a multi-venue pass (FamilyGo Pass) | Ahmed | P2 |
| UC-15 | View and download booking receipts | All | P1 |

---

## 5. Feature List — MVP & Future Scope

### 5.1 MVP Features (Phase 1 — First Shippable Release)

#### Authentication & Onboarding
- [ ] Email/password registration and login
- [ ] Google Sign-In
- [ ] Facebook Login
- [ ] Apple Sign-In (required on iOS)
- [ ] Onboarding carousel (3 screens, skippable)
- [ ] Children profile setup (name, DOB — used for age filtering)
- [ ] Password reset via email OTP

#### Discovery & Search
- [ ] Home feed — curated sections (Featured, Near You, Top Rated, Deals, By Category)
- [ ] Full-text search with instant results (debounced, 300ms)
- [ ] Filter panel: age range, category, price range, distance radius, rating, open now
- [ ] Category browse screen (18 categories defined in taxonomy)
- [ ] Activity listing card — photo, name, rating, distance, price, age range
- [ ] Venue detail screen — full gallery, description, amenities, opening hours, map, reviews, available slots

#### Booking
- [ ] Date and time slot selection
- [ ] Guest count selector (adults + children)
- [ ] Booking summary with price breakdown
- [ ] Payment screen (card input, saved cards, Apple Pay / Google Pay)
- [ ] Booking confirmation screen with QR code
- [ ] Booking history screen (upcoming, past, cancelled)
- [ ] Cancel booking (subject to cancellation policy per venue)

#### Deals & Offers
- [ ] Deals listing screen (filterable by category, expiry)
- [ ] Deal detail screen (terms, redemption instructions)
- [ ] Deal claim — generates single-use code
- [ ] Expiry countdown timer on deal cards

#### User Account
- [ ] Profile screen (photo, name, email, phone)
- [ ] Children profiles management (add, edit, delete)
- [ ] Saved payment methods
- [ ] Notification preferences
- [ ] Language toggle (EN / AR)
- [ ] Help & Support (FAQ + contact)
- [ ] Logout / delete account

#### Notifications
- [ ] Push notifications — booking confirmation, reminder (24h before), deal expiry alerts
- [ ] In-app notification centre
- [ ] Deep link from notification to relevant screen

#### Maps
- [ ] Venue location map on detail screen
- [ ] "Near me" map view with venue pins
- [ ] Get directions (opens native maps app)

---

### 5.2 Post-MVP Features (Phase 2–3)

#### Rewards Programme
- [ ] Points earning on every booking (configurable rate per venue)
- [ ] Points balance widget on home and profile
- [ ] Rewards catalogue — redeem points for discounts, vouchers, free entries
- [ ] Referral programme — earn points for inviting friends
- [ ] Points expiry notifications
- [ ] Tier system (Bronze → Silver → Gold → Platinum)

#### FamilyGo Pass
- [ ] Pass product listing screen
- [ ] Pass purchase flow (monthly / annual options)
- [ ] Pass benefits per venue (unlimited entry, discounted entry, etc.)
- [ ] Pass status and usage history
- [ ] Pass-included venues badge on listing cards

#### Advanced Features
- [ ] Wishlist / saved activities (with sharing)
- [ ] Reviews and ratings — write, read, report abuse
- [ ] Birthday party booking flow (custom package builder)
- [ ] Group booking support (multiple attendees)
- [ ] Activity bundles (multi-venue itinerary builder)
- [ ] AI-powered personalised recommendations (based on booking history and children's ages)
- [ ] Photo upload by user to venue gallery (moderated)
- [ ] Event calendar (ticketed events at venues)
- [ ] Offline mode — cached listings and booking history viewable without internet
- [ ] Accessibility mode toggle (larger text, high contrast)

---

## 6. User Flows & Journeys

### 6.1 New User Onboarding Flow

```
App Launch
    │
    ├── [First-time user] → Splash Screen (2s) → Onboarding Carousel (3 slides)
    │       │
    │       └── "Get Started" → Registration Screen
    │               ├── Email/Password → OTP Email Verification → Add Children → Home
    │               ├── Google Sign-In → Add Children → Home
    │               ├── Facebook Login → Add Children → Home
    │               └── Apple Sign-In → Add Children → Home
    │
    └── [Returning user] → Splash Screen → Home (auto-authenticated via secure token)
```

**Add Children Flow:**
```
Add Children Screen
    │
    ├── Add child: Name + Date of Birth
    ├── Option to add more (up to 5 children)
    ├── "Skip for now" → shown age-agnostic results until set
    └── "Done" → Permission Request (Location) → Home
```

---

### 6.2 Discovery → Booking Flow (Core Happy Path)

```
Home Screen
    │
    ├── Tap venue card / search result → Venue Detail Screen
    │       │
    │       ├── Scroll gallery, read description, check amenities, read reviews
    │       ├── Tap "Book Now" → Availability Calendar
    │       │       │
    │       │       ├── Select date → Select time slot (show available/sold-out slots)
    │       │       ├── Select guest count (adults + children)
    │       │       └── Tap "Continue" → Booking Summary Screen
    │       │               │
    │       │               ├── Review: venue, date, time, guests, price breakdown
    │       │               ├── Apply promo code (optional)
    │       │               ├── Select saved card / add new card / Apple Pay / Google Pay
    │       │               └── Tap "Confirm & Pay" → Payment Processing
    │       │                       │
    │       │                       ├── [Success] → Booking Confirmation Screen
    │       │                       │       ├── QR code (venue scans on arrival)
    │       │                       │       ├── "Add to Calendar" button
    │       │                       │       ├── "Share Booking" button
    │       │                       │       └── "View My Bookings" button
    │       │                       │
    │       │                       └── [Failure] → Payment Failed Screen
    │       │                               ├── Error reason (declined, timeout, 3DS required)
    │       │                               └── Retry / Change Payment Method
    │       │
    │       └── Tap "Save" (heart icon) → Added to Wishlist (requires login)
    │
    └── Tap search bar → Search Screen
            ├── Recent searches
            ├── Popular categories
            └── Type query → Instant results (debounced 300ms API call)
                    └── Filter → Filter Bottom Sheet
                            ├── Age range slider
                            ├── Category checkboxes
                            ├── Price range slider
                            ├── Distance radius (1km–50km)
                            ├── Rating minimum
                            └── "Open Now" toggle
```

---

### 6.3 Deal Claim Flow

```
Deals Screen (tab or home section)
    │
    ├── Browse deals by category / expiry
    ├── Tap deal card → Deal Detail Screen
    │       ├── Deal description, terms & conditions
    │       ├── Expiry countdown
    │       ├── "Claim Deal" button → (requires login)
    │       │       └── Claimed Deal Screen
    │       │               ├── Unique one-time code
    │       │               ├── Redemption instructions
    │       │               └── "Add to Wallet" (iOS/Android wallet pass — Phase 2)
    │       └── "Book with this deal" → Booking flow with deal pre-applied
    │
    └── Claimed deals accessible in Account → My Deals
```

---

### 6.4 Account & Children Profile Flow

```
Account Tab
    │
    ├── Profile: edit name, photo, phone number
    ├── My Children
    │       ├── List of children with ages
    │       ├── Add child: name + DOB
    │       ├── Edit / delete child profile
    │       └── Children profiles drive age-filtering globally in the app
    │
    ├── My Bookings
    │       ├── Upcoming bookings (with QR codes)
    │       ├── Past bookings (view receipt, re-book, review)
    │       └── Cancelled bookings
    │
    ├── My Deals (claimed deals, active + expired)
    ├── Saved Venues (wishlist)
    ├── Rewards (Phase 2)
    ├── Settings
    │       ├── Notifications (granular toggles per type)
    │       ├── Language (EN / AR)
    │       └── Payment Methods
    └── Logout / Delete Account
```

---

## 7. Functional Requirements

### 7.1 Authentication Module

| ID | Requirement | Priority |
|----|-------------|----------|
| AUTH-01 | User must be able to register with email + password. Password minimum 8 characters, at least one uppercase, one number. | P0 |
| AUTH-02 | Email verification via 6-digit OTP. OTP expires in 10 minutes. Max 3 resend attempts per hour. | P0 |
| AUTH-03 | Google Sign-In via `google_sign_in` package. Backend must accept Google ID token and return app JWT. | P0 |
| AUTH-04 | Facebook Login via `flutter_facebook_auth`. Same backend flow as Google. | P0 |
| AUTH-05 | Apple Sign-In required on iOS whenever any other social login is present. Conforms to App Store guideline 4.8. | P0 |
| AUTH-06 | Auth tokens: access token (15 min TTL), refresh token (30 days TTL), stored in `flutter_secure_storage`. | P0 |
| AUTH-07 | Automatic token refresh — interceptor in Dio silently refreshes before expiry without user interruption. | P0 |
| AUTH-08 | Password reset via email link. Link expires in 1 hour. Single-use. | P0 |
| AUTH-09 | On logout: clear all tokens from secure storage, clear Riverpod state, navigate to login screen. | P0 |
| AUTH-10 | On account deletion: call DELETE /api/v1/user endpoint, clear local data, navigate to registration. | P1 |
| AUTH-11 | Biometric authentication (FaceID / fingerprint) as an alternative to re-entering credentials on app resume. | P2 |

---

### 7.2 Venue Discovery Module

| ID | Requirement | Priority |
|----|-------------|----------|
| DISC-01 | Home screen sections loaded via single `/api/v1/home-feed` endpoint returning section configs. Sections are backend-configurable without app update. | P0 |
| DISC-02 | Search endpoint: `GET /api/v1/venues/search?q=&age_min=&age_max=&category=&lat=&lng=&radius_km=&price_min=&price_max=&rating_min=&open_now=&sort=&page=&per_page=20`. All filters optional. | P0 |
| DISC-03 | Search input debounced at 300ms before API call fires. Minimum 2 characters to trigger search. | P0 |
| DISC-04 | Venue listing card must display: primary photo, name, category, average rating (1 decimal), review count, distance (if location granted), price-from, age range, open/closed status. | P0 |
| DISC-05 | Venue detail screen loads from `GET /api/v1/venues/{venue_id}`. Must include: gallery (up to 20 images), full description, amenities list, opening hours (by day), location (lat/lng + address), average rating, review count, price range, age range, features tags. | P0 |
| DISC-06 | Category taxonomy is hardcoded in app constants with remote override capability via `/api/v1/config/categories`. | P0 |
| DISC-07 | Infinite scroll pagination on all listing screens. Trigger next page fetch when user scrolls to within 3 items of the end. Show skeleton loaders during fetch. | P0 |
| DISC-08 | "Open Now" filter uses device local time, accounting for timezone. Venue hours stored in UTC on backend. | P0 |
| DISC-09 | Distance calculation uses Haversine formula client-side when lat/lng available. Backend also calculates and returns distance in search results. | P1 |
| DISC-10 | Recently viewed venues stored locally (Hive), last 10, shown on home screen section "Recently Viewed". | P1 |

---

### 7.3 Booking Module

| ID | Requirement | Priority |
|----|-------------|----------|
| BOOK-01 | Availability calendar loads from `GET /api/v1/venues/{id}/availability?from=YYYY-MM-DD&to=YYYY-MM-DD`. Returns available slots per day. | P0 |
| BOOK-02 | Time slot selection shows available / unavailable / sold-out states. Unavailable slots are visible but not tappable. Sold-out slots show "Sold Out" label. | P0 |
| BOOK-03 | Guest count: minimum 1 adult. Maximum enforced by venue's `max_capacity_per_booking`. | P0 |
| BOOK-04 | Booking held for 10 minutes during checkout (slot reservation via `POST /api/v1/bookings/reserve`). Countdown timer visible on checkout screens. If timer expires, user is returned to availability screen with an alert. | P0 |
| BOOK-05 | Price calculation performed server-side. Client sends selected slot, guest count, promo code. Server returns authoritative price breakdown. Client never calculates the final price. | P0 |
| BOOK-06 | Payment: support credit/debit card (Stripe or Telr SDK), Apple Pay (iOS), Google Pay (Android). Do not store raw card numbers in app or on app server. | P0 |
| BOOK-07 | 3D Secure (3DS) authentication must be supported. Present 3DS webview when required by payment gateway. | P0 |
| BOOK-08 | On successful payment: `POST /api/v1/bookings/confirm` with payment intent ID. Backend verifies payment server-to-server before confirming booking. | P0 |
| BOOK-09 | Booking confirmation: unique booking reference (e.g. `FG-2026-XXXXXX`), QR code (encodes booking reference), venue name, date/time, guest count, total paid. | P0 |
| BOOK-10 | QR code generated client-side from booking reference string. Uses `qr_flutter` package. Refresh from server if booking status changes. | P0 |
| BOOK-11 | Booking reminder push notification sent 24 hours before. Deep links to booking detail screen. | P0 |
| BOOK-12 | Cancellation: user can cancel from booking detail screen. Show venue's cancellation policy before confirming. If eligible for refund, initiate via `POST /api/v1/bookings/{id}/cancel`. | P0 |
| BOOK-13 | Refund status tracked and displayed on cancelled booking screen. Refund timeline communicated per payment method (card: 5–7 business days). | P1 |
| BOOK-14 | Receipt downloadable as PDF via `GET /api/v1/bookings/{id}/receipt`. Open with `open_file` package or share via system share sheet. | P1 |

---

### 7.4 Deals Module

| ID | Requirement | Priority |
|----|-------------|----------|
| DEAL-01 | Deals feed: `GET /api/v1/deals?category=&sort=expiry_asc&page=&per_page=20`. | P0 |
| DEAL-02 | Deal card: venue photo, deal title, discount value (e.g. "50% Off" or "Buy 1 Get 1"), expiry date, venue name, category. | P0 |
| DEAL-03 | Claim deal: `POST /api/v1/deals/{id}/claim`. Returns `{ code: "XXXXXX", expires_at, instructions }`. Each code is unique to the user-deal combination. | P0 |
| DEAL-04 | Claimed deal code displayed clearly. Option to copy to clipboard. | P0 |
| DEAL-05 | Expiry countdown shown for deals expiring within 48 hours. Format: `Expires in Xh Ym`. | P0 |
| DEAL-06 | Deals expiring today flagged with "Today Only" badge. | P0 |
| DEAL-07 | Claimed deals persist in `My Deals` section even after expiry (shown as expired). | P1 |

---

### 7.5 User Profile & Account Module

| ID | Requirement | Priority |
|----|-------------|----------|
| PROF-01 | Profile photo upload: compress to max 1MB client-side before upload. Upload to `POST /api/v1/user/avatar`. | P0 |
| PROF-02 | Children profiles: max 5 children per account. Each profile stores: name, date of birth (used to calculate current age dynamically), optional photo. | P0 |
| PROF-03 | Age of children auto-calculated from DOB and used as default age filter on discovery screens. | P0 |
| PROF-04 | Notification preferences: granular toggles for — booking confirmations, booking reminders, new deals, rewards updates, general promotions. Preferences synced to server. | P0 |
| PROF-05 | Saved payment methods: list, set default, delete. Never stored locally — loaded from payment gateway's vault via backend. | P0 |
| PROF-06 | Wishlist: `POST /api/v1/user/wishlist` to add, `DELETE /api/v1/user/wishlist/{venue_id}` to remove. Max 100 items. | P1 |
| PROF-07 | Language toggle: persisted locally in SharedPreferences. Arabic requires full RTL layout without app restart. | P0 |

---

### 7.6 Notifications Module

| ID | Requirement | Priority |
|----|-------------|----------|
| NOTIF-01 | Request push notification permission on first launch after onboarding. Do not request on app open. | P0 |
| NOTIF-02 | Handle foreground push notifications — show in-app banner (custom widget, not system notification). | P0 |
| NOTIF-03 | Handle background push notifications — system notification. Tap navigates via deep link. | P0 |
| NOTIF-04 | Notification centre screen: list of all received notifications, unread count badge on Account tab icon. | P0 |
| NOTIF-05 | Mark notification as read on tap. Mark all as read button. | P0 |
| NOTIF-06 | Notification types and deep link targets: booking_confirmed → `/bookings/{id}`, booking_reminder → `/bookings/{id}`, deal_new → `/deals/{id}`, deal_expiring → `/deals/{id}`, rewards_earned → `/rewards`, promotion → `/home`. | P0 |

---

## 8. Non-Functional Requirements

### 8.1 Performance

| Metric | Requirement |
|--------|-------------|
| App cold start time | < 2.5 seconds on a mid-range device (Snapdragon 665 / A14-class equivalent) |
| Screen transition | All route transitions < 300ms, no dropped frames (target 60fps / 120fps on supported devices) |
| API response time | p95 < 500ms for listing endpoints; p95 < 1s for booking endpoints |
| Search results | First results visible < 800ms from final keystroke |
| Image loading | Placeholder visible immediately; full image loads within 2s on 4G |
| Booking confirmation | Complete booking flow (confirm → QR displayed) < 5 seconds |
| Offline graceful degradation | Cached home feed and booking history viewable without network; network-required features show clear offline indicator |

### 8.2 Scalability

- Backend APIs must handle 10,000 concurrent users at launch; architecture must scale to 100,000 without structural redesign.
- Venue search must support 10,000+ venue records without degradation (requires indexed search — Elasticsearch or equivalent on backend).
- Image delivery via CDN (CloudFront) — no images served directly from app server.
- Stateless API design — horizontal scaling behind load balancer.

### 8.3 Security

| Area | Requirement |
|------|-------------|
| Token storage | Auth tokens stored exclusively in `flutter_secure_storage` (iOS Keychain, Android Keystore). Never in SharedPreferences or Hive unencrypted. |
| API communication | All API calls over HTTPS/TLS 1.2+. Certificate pinning implemented for production build using `dio_certificate_pinner`. |
| Payment data | PCI-DSS compliant: raw card data never touches app server. Use tokenisation via payment gateway. |
| Sensitive fields | No logging of passwords, tokens, card numbers, or personal data in production builds. Debug logging gated by build flavour. |
| Jailbreak/root detection | Warn user (do not block) if device is jailbroken or rooted using `flutter_jailbreak_detection`. Disable biometric auth on compromised devices. |
| Obfuscation | Dart code obfuscated in release builds (`--obfuscate --split-debug-info`). Android ProGuard rules applied. |
| API key management | No API keys hardcoded in source. All keys injected via CI/CD environment variables and loaded via `--dart-define`. |

### 8.4 Reliability & Availability

- App crash-free rate: ≥ 99.5% (monitored via Firebase Crashlytics / Sentry)
- Payment flow crash-free rate: ≥ 99.95% — any crash during payment must not result in a charge without a booking confirmation
- Backend API uptime SLA: 99.9% (enforced in partner API contracts)
- Graceful error handling on all API failures — no unhandled exceptions in production

### 8.5 Accessibility

- WCAG 2.1 Level AA compliance
- All interactive elements have semantic labels (`Semantics` widget) for screen reader support
- Minimum tap target size: 44×44 logical pixels
- Text does not rely on colour alone to convey meaning
- App usable at 200% system font scale without layout breakage
- All images have descriptive `semanticLabel`

### 8.6 Localisation

- All user-facing strings externalised — no hardcoded strings in UI code
- RTL layout fully supported from day one using Flutter's built-in directionality system
- Date/time formatting locale-aware using `intl` package
- Currency formatting locale-aware (AED for UAE, extensible)
- App Store / Play Store listings in both EN and AR

---

## 9. System Architecture

### 9.1 Flutter Frontend Architecture

**Pattern:** Clean Architecture + Feature-first folder structure + Riverpod for state management

```
lib/
├── main.dart
├── app.dart                          # MaterialApp, router, providers
├── core/
│   ├── constants/                    # app_constants, api_endpoints, route_names
│   ├── di/                           # dependency injection (provider overrides, service locator)
│   ├── errors/                       # AppException, Failure classes, error handler
│   ├── extensions/                   # BuildContext, String, DateTime extensions
│   ├── network/                      # Dio client, interceptors, connectivity checker
│   ├── router/                       # GoRouter configuration, route guards
│   ├── services/                     # analytics_service, notification_service, storage_service
│   ├── theme/                        # AppTheme, typography, color palette
│   └── utils/                        # validators, formatters, helpers
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasources/          # auth_remote_datasource, auth_local_datasource
│   │   │   ├── models/               # user_model.dart, auth_response_model.dart
│   │   │   └── repositories/        # auth_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/            # user_entity.dart
│   │   │   ├── repositories/        # auth_repository.dart (abstract)
│   │   │   └── usecases/            # login_usecase, register_usecase, logout_usecase
│   │   └── presentation/
│   │       ├── providers/           # auth_provider.dart (Riverpod AsyncNotifier)
│   │       ├── screens/             # login_screen, register_screen, otp_screen
│   │       └── widgets/             # social_login_buttons, password_field
│   │
│   ├── discovery/
│   ├── venue_detail/
│   ├── booking/
│   ├── deals/
│   ├── account/
│   ├── notifications/
│   └── rewards/                      # Phase 2
│
├── shared/
│   ├── widgets/                      # app_button, app_card, venue_card, loading_shimmer
│   └── models/                       # pagination_model, api_response_model
│
└── generated/
    └── l10n/                         # Auto-generated localisation files
```

### 9.2 State Management — Riverpod

| State Type | Riverpod Provider Type | Example |
|-----------|----------------------|---------|
| Auth state (global) | `AsyncNotifierProvider` | `authProvider` |
| Venue list (paginated) | `AsyncNotifierProvider<List<Venue>>` | `venueListProvider` |
| Search query | `StateProvider<String>` | `searchQueryProvider` |
| Active filters | `StateNotifierProvider<FilterState>` | `filterProvider` |
| Current booking session | `NotifierProvider<BookingSessionNotifier>` | `bookingSessionProvider` |
| User profile | `AsyncNotifierProvider<UserProfile>` | `userProfileProvider` |
| Cart/checkout | `NotifierProvider<CheckoutNotifier>` | `checkoutProvider` |

All providers scoped appropriately — global providers in `ProviderScope` at app root; feature-local providers auto-disposed.

### 9.3 Navigation

**Package:** `go_router`

| Route | Path | Auth Required |
|-------|------|--------------|
| Splash | `/` | No |
| Onboarding | `/onboarding` | No |
| Login | `/auth/login` | No |
| Register | `/auth/register` | No |
| OTP Verify | `/auth/verify` | No |
| Home | `/home` | Yes |
| Search | `/search` | No |
| Venue Detail | `/venues/:id` | No |
| Booking Flow | `/venues/:id/book` | Yes |
| Booking Confirm | `/bookings/:id/confirm` | Yes |
| My Bookings | `/bookings` | Yes |
| Deals | `/deals` | No |
| Deal Detail | `/deals/:id` | No |
| Account | `/account` | Yes |
| Notifications | `/notifications` | Yes |

Route guards implemented via `GoRouter.redirect` — unauthenticated users redirected to `/auth/login` with `from` query param for post-login redirect.

### 9.4 Backend Assumptions

The backend is a **RESTful API** built on **ASP.NET Core** (C#), deployed on cloud infrastructure with the following assumed design:

- **Base URL:** `https://api.familygo.app/api/v1`
- **Auth:** Bearer JWT (access token in Authorization header)
- **Versioning:** URI versioning (`/v1`, `/v2`)
- **Pagination:** `{ data: [], meta: { page, per_page, total, total_pages } }`
- **Error format:** `{ error: { code: "VENUE_NOT_FOUND", message: "...", details: {} } }`
- **Rate limiting:** 100 req/min per user, 1000 req/min per IP
- **Real-time:** WebSocket or Server-Sent Events for booking slot availability updates (Phase 2)

### 9.5 Dependency Graph (Simplified)

```
Presentation Layer (Screens / Widgets)
        ↓ watches
Riverpod Providers (AsyncNotifiers / Notifiers)
        ↓ calls
Use Cases (Domain Layer)
        ↓ calls
Repository Interfaces (Domain Layer)
        ↑ implemented by
Repository Implementations (Data Layer)
        ↓ delegates to
Remote Datasource (Dio → REST API)
Local Datasource (Hive / SecureStorage / SharedPreferences)
```

---

## 10. Data Models & Storage Design

### 10.1 Core Data Models

#### User
```dart
@freezed
class User with _$User {
  factory User({
    required String id,
    required String email,
    String? displayName,
    String? avatarUrl,
    String? phoneNumber,
    required List<ChildProfile> children,
    required UserPreferences preferences,
    required DateTime createdAt,
    DateTime? lastLoginAt,
  }) = _User;
}
```

#### ChildProfile
```dart
@freezed
class ChildProfile with _$ChildProfile {
  factory ChildProfile({
    required String id,
    required String name,
    required DateTime dateOfBirth,
    String? avatarUrl,
  }) = _ChildProfile;

  // Computed — not stored
  int get age => DateTime.now().difference(dateOfBirth).inDays ~/ 365;
}
```

#### Venue
```dart
@freezed
class Venue with _$Venue {
  factory Venue({
    required String id,
    required String name,
    required String description,
    required VenueCategory category,
    required List<String> photoUrls,
    required Address address,
    required GeoPoint location,
    required OpeningHours openingHours,
    required PriceRange priceRange,
    required AgeRange ageRange,
    required double averageRating,
    required int reviewCount,
    required List<String> amenities,
    required List<String> tags,
    bool? isOpen,             // Computed by client
    double? distanceKm,       // Populated from search results
  }) = _Venue;
}
```

#### Booking
```dart
@freezed
class Booking with _$Booking {
  factory Booking({
    required String id,
    required String reference,        // e.g. "FG-2026-A3KX9"
    required String venueId,
    required String venueName,
    required String venuePhotoUrl,
    required DateTime slotDate,
    required TimeOfDay slotTime,
    required int adultCount,
    required int childCount,
    required BookingStatus status,    // upcoming, completed, cancelled
    required Money totalAmount,
    required Money amountPaid,
    String? cancellationReason,
    required DateTime createdAt,
  }) = _Booking;
}

enum BookingStatus { upcoming, completed, cancelled, refunded }
```

#### Deal
```dart
@freezed
class Deal with _$Deal {
  factory Deal({
    required String id,
    required String venueId,
    required String venueName,
    required String venuePhotoUrl,
    required String title,
    required String description,
    required String terms,
    required DealType type,           // percentage, bogo, fixed_amount
    double? discountPercentage,
    double? discountAmount,
    required DateTime expiresAt,
    bool? isClaimed,
    String? claimedCode,
  }) = _Deal;
}
```

### 10.2 Local Storage Design

| Store | Package | Data Stored | TTL |
|-------|---------|-------------|-----|
| Secure Storage | `flutter_secure_storage` | Access token, Refresh token, biometric keys | Session-based |
| Hive Box: `user` | `hive_flutter` | Serialised User object | Until logout |
| Hive Box: `venues_cache` | `hive_flutter` | Last-fetched venue listings per category | 30 minutes |
| Hive Box: `bookings_cache` | `hive_flutter` | User's bookings list | 15 minutes |
| Hive Box: `recent_venues` | `hive_flutter` | Last 10 viewed venue IDs + basic data | Permanent (local) |
| SharedPreferences | `shared_preferences` | Language, notification prefs, onboarding seen flag, filter defaults | Permanent |
| File Cache | `flutter_cache_manager` | Downloaded images | 7 days |

**Cache invalidation strategy:**
- All Hive caches store a `cachedAt` timestamp alongside data.
- On load: if `DateTime.now() - cachedAt > TTL`, fetch from API and update cache.
- On pull-to-refresh: force-fetch regardless of cache age.
- On logout: clear all Hive boxes except `recent_venues` (non-sensitive).

---

## 11. Third-Party Integrations

### 11.1 Integration Map

| Service | Purpose | Flutter Package | Environment |
|---------|---------|----------------|-------------|
| Firebase Auth | Identity management | `firebase_auth` | All |
| Firebase Crashlytics | Crash reporting | `firebase_crashlytics` | Staging + Prod |
| Firebase Analytics | Event tracking | `firebase_analytics` | Staging + Prod |
| Firebase Messaging | Push notifications (FCM) | `firebase_messaging` | All |
| Google Sign-In | Social auth | `google_sign_in` | All |
| Facebook Login | Social auth | `flutter_facebook_auth` | All |
| Apple Sign-In | Social auth (iOS) | `sign_in_with_apple` | All |
| OneSignal | Advanced push + in-app messaging | `onesignal_flutter` | Staging + Prod |
| Stripe / Telr | Payment processing | `flutter_stripe` or `telr_flutter` | All (test mode in Dev) |
| Google Maps | Map display, venue locations | `google_maps_flutter` | All |
| Geolocator | Device GPS | `geolocator` | All |
| Sentry | Error + performance monitoring | `sentry_flutter` | Staging + Prod |
| Adjust / AppsFlyer | Mobile attribution (MMP) | `adjust_sdk` | Prod only |
| Branch.io | Deep linking | `flutter_branch_sdk` | Staging + Prod |

### 11.2 Environment-Specific Configuration

All third-party API keys injected via `--dart-define` at build time. Never committed to source control.

```bash
# Example build command (CI/CD)
flutter build apk \
  --release \
  --obfuscate \
  --split-debug-info=build/debug-info \
  --dart-define=FIREBASE_API_KEY=$FIREBASE_API_KEY \
  --dart-define=GOOGLE_MAPS_KEY=$GOOGLE_MAPS_KEY \
  --dart-define=STRIPE_PK=$STRIPE_PK \
  --dart-define=API_BASE_URL=$API_BASE_URL \
  --dart-define=SENTRY_DSN=$SENTRY_DSN \
  --dart-define=ONESIGNAL_APP_ID=$ONESIGNAL_APP_ID
```

### 11.3 Payment Integration Detail

**Primary gateway for UAE market: Telr**

| Step | Action | Actor |
|------|--------|-------|
| 1 | App calls `POST /api/v1/payments/create-intent` with booking details | App → Backend |
| 2 | Backend creates payment intent with Telr, returns `{ intent_id, client_secret }` | Backend → Telr |
| 3 | App presents Telr SDK payment sheet using `client_secret` | App |
| 4 | User enters card details (handled entirely by Telr SDK — PCI scope of app server is minimised) | User |
| 5 | Telr processes payment, calls backend webhook | Telr → Backend |
| 6 | App polls `GET /api/v1/payments/{intent_id}/status` or listens via socket | App |
| 7 | On success: app confirms booking via `POST /api/v1/bookings/confirm` | App → Backend |
| 8 | Backend verifies payment status server-to-server before confirming | Backend → Telr |

**Fallback:** If 3DS is required, Telr SDK handles it natively within the payment sheet — no custom WebView needed.

---

## 12. UI/UX Guidelines

### 12.1 Design System

**Design tool:** Figma  
**Component library:** Custom, built on Material 3 Design System

#### Color Palette

| Token | Light Mode | Dark Mode | Usage |
|-------|-----------|-----------|-------|
| `color.primary` | `#FF6B35` | `#FF8C61` | CTAs, active states, primary actions |
| `color.primary.container` | `#FFE8DF` | `#4A1E0A` | Chip backgrounds, selected states |
| `color.secondary` | `#2D7DD2` | `#5BA0E8` | Links, secondary actions |
| `color.surface` | `#FFFFFF` | `#1A1A1A` | Cards, sheets, dialogs |
| `color.background` | `#F5F5F0` | `#121212` | App background |
| `color.error` | `#D32F2F` | `#EF9A9A` | Errors, validation, warnings |
| `color.on.primary` | `#FFFFFF` | `#FFFFFF` | Text on primary |
| `color.text.primary` | `#1A1A1A` | `#F5F5F5` | Main body text |
| `color.text.secondary` | `#757575` | `#B0B0B0` | Subtitles, labels |
| `color.text.tertiary` | `#BDBDBD` | `#616161` | Hints, placeholders |

#### Typography

| Style | Font | Size | Weight | Line Height |
|-------|------|------|--------|-------------|
| `heading.xl` | Poppins | 28sp | 700 | 36sp |
| `heading.lg` | Poppins | 22sp | 600 | 30sp |
| `heading.md` | Poppins | 18sp | 600 | 26sp |
| `heading.sm` | Poppins | 15sp | 600 | 22sp |
| `body.lg` | Inter | 16sp | 400 | 24sp |
| `body.md` | Inter | 14sp | 400 | 22sp |
| `body.sm` | Inter | 12sp | 400 | 18sp |
| `label` | Inter | 12sp | 500 | 16sp |
| `caption` | Inter | 11sp | 400 | 15sp |

For Arabic: use **Cairo** font family as the substitute. All size/weight/line-height values remain the same.

#### Spacing System

8-point grid. All margins, paddings, and gaps must be multiples of 4 (4, 8, 12, 16, 20, 24, 32, 40, 48, 64).

#### Border Radius

| Token | Value | Usage |
|-------|-------|-------|
| `radius.sm` | 4dp | Chips, badges |
| `radius.md` | 8dp | Input fields, small cards |
| `radius.lg` | 12dp | Cards, bottom sheets |
| `radius.xl` | 16dp | Feature cards, modals |
| `radius.full` | 999dp | Buttons, pills, avatars |

#### Elevation / Shadow

Prefer flat design. Use 1dp and 2dp elevation shadows only. No heavy drop shadows.

### 12.2 Component Guidelines

- **VenueCard:** Aspect ratio 4:3 for photo, rounded corners 12dp, subtle shadow 2dp. Skeleton loader must match exact dimensions.
- **Primary Button:** Height 52dp, full-width, border-radius 999dp (pill), `color.primary` background. Loading state replaces text with `CircularProgressIndicator` (white, size 20dp).
- **Bottom Sheet:** Use `DraggableScrollableSheet` for filter and booking panels. Max height 92% of screen.
- **App Bar:** Transparent background with surface tint on scroll. No heavy border.
- **Tab Bar:** Bottom navigation with 4 tabs: Home, Search, Deals, Account. Active icon + label in `color.primary`. Inactive in `color.text.secondary`.
- **Empty States:** Every list screen must have a meaningful empty state illustration + message + action button. Never show a blank white screen.
- **Error States:** Network error screens include a "Try Again" button that retriggers the last API call.
- **Loading:** Shimmer skeleton loaders on all content screens. No spinner-only loading states for lists.

### 12.3 Responsiveness

- Primary target: 375dp–430dp screen width (iPhone SE 3rd gen to iPhone 16 Pro Max range, equivalent Android)
- Tablet support (P2): adaptive layout for 600dp+ — dual-panel layout on venue detail
- Use `LayoutBuilder` and `MediaQuery` for breakpoint-sensitive layouts
- Never use hardcoded pixel values for widths — use `double.infinity`, `Flexible`, or `Expanded`

### 12.4 Accessibility Standards

- All interactive widgets must have `Semantics` label, hint, and button role
- Screen reader test required before every release using TalkBack (Android) and VoiceOver (iOS)
- Colour contrast ratio: ≥ 4.5:1 for body text, ≥ 3:1 for large text and UI components
- Focus traversal order must follow visual reading order
- No time-limited interactions without an option to extend (excluding deal countdown timers — those are informational)

---

## 13. Edge Cases & Failure Scenarios

### 13.1 Network & Connectivity

| Scenario | Expected Behaviour |
|----------|-------------------|
| No internet on app launch | Show cached home feed (Hive). Banner: "You're offline — showing cached content". API-dependent actions (booking, claiming deals) show appropriate disabled state. |
| Internet lost mid-booking | If payment not yet initiated: show offline dialog, offer to save progress and resume. If payment initiated: do NOT retry automatically — show "Check your bookings" screen to verify status. |
| API timeout (> 10s) | Cancel request, show timeout error with retry button. Log to Sentry. |
| Server 5xx error | Show generic error screen. Do not expose technical details. Log full response to Sentry. |
| Partial API response | Validate response schema client-side with Freezed. If required fields missing, treat as error, log to Sentry. |

### 13.2 Authentication

| Scenario | Expected Behaviour |
|----------|-------------------|
| Access token expired | Dio interceptor silently refreshes token. If refresh fails (token revoked), redirect to login screen. |
| Refresh token expired | Clear all auth data, navigate to login, show "Session expired" snackbar. |
| Duplicate email on social login | Backend returns `ACCOUNT_ALREADY_EXISTS` error — present "Link accounts" prompt or "Login with email" suggestion. |
| Apple Sign-In returns no email (user hid it) | Accept Apple-generated relay email. Store it as user's email — do not require real email. |

### 13.3 Payment

| Scenario | Expected Behaviour |
|----------|-------------------|
| Payment declined | Show specific reason if provided by gateway (insufficient funds, card expired). Offer to try a different card. |
| 3DS timeout | User dismissed 3DS or it timed out. Release slot reservation, inform user payment failed, offer retry. |
| Payment succeeded but booking confirmation API failed | Show "Payment received but booking pending" screen. Trigger retry logic (3 attempts, exponential backoff). If still failing, flag for manual resolution. Send user an email with payment confirmation and pending status. |
| Double tap on "Confirm & Pay" | Button disables immediately on first tap. Idempotency key sent with payment request. Backend prevents duplicate charges. |
| Slot sold out between reserve and confirm | Very rare (reservation holds slot). If it occurs: refund initiated automatically, inform user with alternative available slots. |

### 13.4 Booking

| Scenario | Expected Behaviour |
|----------|-------------------|
| Reservation timer expires during checkout | Modal: "Your slot reservation has expired". Option: "Check Availability Again". Navigate back to slot selection on confirm. |
| Venue cancels booking | Push notification to user. Full refund initiated. In-app notification with "Find Similar Venues" CTA. |
| User cancels within free cancellation window | Instant refund to original payment method. Update booking status to `cancelled`. |
| User cancels outside free cancellation window | Show cancellation policy. Require confirmation. Partial or zero refund per policy. |

### 13.5 Content & Data

| Scenario | Expected Behaviour |
|----------|-------------------|
| Venue photo fails to load | Show category-specific placeholder image. Log broken URL to monitoring. |
| Search returns 0 results | Empty state: "No results for [query]". Suggest: broaden filters, clear age filter, check spelling. Do not show "No results" for network errors — distinguish. |
| Location permission denied | Graceful fallback: all listings shown without distance sorting. "Enable Location" prompt in account settings. Do not block app usage. |
| Child profile DOB in future | Validation: DOB must be in past and within last 18 years. Show validation error inline. |

---

## 14. Analytics & Tracking Plan

### 14.1 Event Taxonomy

**Naming convention:** `[screen]_[action]_[object]`  
**Tool:** Firebase Analytics + custom events to OneSignal user properties

---

#### Authentication Events

| Event Name | Trigger | Parameters |
|-----------|---------|------------|
| `auth_signup_started` | User taps "Get Started" | `method: email\|google\|facebook\|apple` |
| `auth_signup_completed` | Registration successful | `method`, `has_children: bool` |
| `auth_login_success` | Login successful | `method` |
| `auth_login_failed` | Login attempt fails | `method`, `error_code` |

#### Discovery Events

| Event Name | Trigger | Parameters |
|-----------|---------|------------|
| `home_viewed` | Home screen appears | `section_count` |
| `search_initiated` | User focuses search bar | — |
| `search_completed` | Search results returned | `query`, `result_count`, `filters_applied: bool` |
| `filter_applied` | Filter panel applied | `filters: { age_range, category, price_max, radius_km, open_now }` |
| `venue_card_tapped` | Venue card tapped in any list | `venue_id`, `venue_name`, `source_screen`, `position_in_list` |
| `venue_detail_viewed` | Venue detail screen shown | `venue_id`, `venue_name`, `category` |
| `venue_photos_scrolled` | User swipes venue gallery | `venue_id`, `photo_count_viewed` |
| `venue_saved` | Wishlist heart tapped | `venue_id` |
| `venue_unsaved` | Wishlist heart un-tapped | `venue_id` |
| `map_opened` | Map tab or map view opened | `context: home\|venue_detail` |
| `get_directions_tapped` | "Get Directions" button | `venue_id` |

#### Booking Events

| Event Name | Trigger | Parameters |
|-----------|---------|------------|
| `booking_initiated` | "Book Now" tapped | `venue_id`, `venue_name` |
| `booking_date_selected` | Date picked on calendar | `venue_id`, `days_in_advance` |
| `booking_slot_selected` | Time slot picked | `venue_id`, `slot_time` |
| `booking_summary_viewed` | Booking summary screen shown | `venue_id`, `total_amount`, `guest_count` |
| `booking_promo_applied` | Promo code successfully applied | `promo_code`, `discount_amount` |
| `booking_payment_started` | "Confirm & Pay" tapped | `venue_id`, `payment_method`, `total_amount` |
| `booking_completed` | Booking confirmed | `venue_id`, `booking_id`, `total_amount`, `payment_method` |
| `booking_failed` | Payment or booking failed | `venue_id`, `error_code`, `payment_method` |
| `booking_cancelled` | User cancels booking | `booking_id`, `days_until_visit`, `refund_eligible: bool` |

#### Deals Events

| Event Name | Trigger | Parameters |
|-----------|---------|------------|
| `deal_viewed` | Deal detail screen shown | `deal_id`, `deal_type`, `venue_id` |
| `deal_claimed` | Deal successfully claimed | `deal_id`, `deal_type`, `venue_id` |
| `deal_code_copied` | Copy button on deal code | `deal_id` |

#### Funnel Analysis (Critical Funnel)

```
venue_detail_viewed
    ↓
booking_initiated         (conversion: target ≥ 35%)
    ↓
booking_slot_selected     (drop-off watch point)
    ↓
booking_summary_viewed    (conversion: target ≥ 70%)
    ↓
booking_payment_started   (conversion: target ≥ 85%)
    ↓
booking_completed         (conversion: target ≥ 90%)
```

### 14.2 User Properties

Set on every session for segmentation:

| Property | Values | Source |
|----------|--------|--------|
| `has_children` | true / false | Profile |
| `children_count` | 0–5 | Profile |
| `youngest_child_age` | 0–18 | Computed from profile |
| `oldest_child_age` | 0–18 | Computed from profile |
| `city` | Dubai / Abu Dhabi / Sharjah / etc. | Location or profile |
| `language` | en / ar | App setting |
| `auth_method` | email / google / facebook / apple | Auth |
| `total_bookings` | Integer | Updated post-booking |
| `is_rewards_member` | true / false | Phase 2 |

---

## 15. Deployment Strategy

### 15.1 Environments

| Environment | Purpose | API Base URL | Firebase Project |
|------------|---------|-------------|-----------------|
| Development | Local dev, feature testing | `http://localhost:5000/api/v1` | `familygo-dev` |
| Staging | QA testing, stakeholder review | `https://api-staging.familygo.app/api/v1` | `familygo-staging` |
| Production | Live users | `https://api.familygo.app/api/v1` | `familygo-prod` |

### 15.2 Build Flavours (Flutter)

```dart
// lib/core/config/app_config.dart
enum Flavor { development, staging, production }

class AppConfig {
  static late Flavor flavor;
  static late String apiBaseUrl;
  static late String sentryDsn;
  static late bool enableAnalytics;
  static late bool enableCrashReporting;
}
```

```yaml
# pubspec.yaml flavours via flutter_flavorizr
flavors:
  development:
    app:
      name: "FamilyGo Dev"
    android:
      applicationId: "app.familygo.dev"
    ios:
      bundleId: "app.familygo.dev"
  staging:
    app:
      name: "FamilyGo Staging"
    android:
      applicationId: "app.familygo.staging"
    ios:
      bundleId: "app.familygo.staging"
  production:
    app:
      name: "FamilyGo"
    android:
      applicationId: "app.familygo"
    ios:
      bundleId: "app.familygo"
```

### 15.3 CI/CD Pipeline

**Platform:** GitHub Actions (or Codemagic as alternative)

#### Pull Request Pipeline (Every PR)

```yaml
jobs:
  pr_checks:
    - Checkout code
    - Setup Flutter (pinned version via .flutter-version or FVM)
    - flutter pub get
    - dart format --check .
    - flutter analyze --fatal-infos
    - flutter test --coverage
    - Upload coverage to Codecov (fail if < 70%)
    - Build APK (debug, development flavour) — smoke build test
```

#### Staging Pipeline (Merge to `develop`)

```yaml
jobs:
  staging_deploy:
    - All PR checks (above)
    - flutter build apk --flavor staging --release (Android)
    - flutter build ipa --flavor staging --release (iOS)
    - Upload to Firebase App Distribution (Android + iOS)
    - Notify QA team via Slack
    - Upload debug symbols to Sentry
```

#### Production Pipeline (Merge to `main` + manual approval gate)

```yaml
jobs:
  production_release:
    - All checks pass on staging build
    - Manual approval required (Product + Engineering Lead)
    - flutter build appbundle --flavor production --release --obfuscate
    - flutter build ipa --flavor production --release --obfuscate
    - Upload to Google Play (internal track → promote to production manually)
    - Upload to App Store Connect (TestFlight → submit for review)
    - Upload debug symbols to Sentry + Firebase Crashlytics
    - Tag release in GitHub (`v1.x.x`)
    - Post release notes to #releases Slack channel
```

### 15.4 Version Management

- **Format:** `MAJOR.MINOR.PATCH` (e.g. `1.2.3`)
- `pubspec.yaml` version format: `1.2.3+45` (build number auto-incremented in CI)
- Build number auto-incremented using CI run number
- Release notes drafted in `CHANGELOG.md` and pulled into store listings via Fastlane

### 15.5 Over-The-Air (OTA) Updates

- Remote config via `firebase_remote_config` for feature flags and non-code config
- Force update mechanism: backend returns `minimum_required_version` in API response headers; app compares and shows force-update dialog if below minimum
- No OTA code delivery (violates App Store guidelines)

---

## 16. Testing Strategy

### 16.1 Test Coverage Targets

| Layer | Coverage Target | Tool |
|-------|----------------|------|
| Domain (use cases, entities) | ≥ 95% | Dart test |
| Data (repository impls, datasources) | ≥ 85% | Mockito + Dart test |
| Presentation (providers, notifiers) | ≥ 80% | Riverpod test + `flutter_test` |
| Widget (critical widgets) | ≥ 70% | `flutter_test` widget tests |
| Integration / E2E (critical flows) | Key user journeys | `integration_test` |

### 16.2 Unit Tests

All use cases tested with mocked repositories. All Riverpod providers tested with `ProviderContainer`. All utility functions and validators tested with edge cases.

```dart
// Example: LoginUseCase test
void main() {
  late LoginUseCase useCase;
  late MockAuthRepository mockRepo;

  setUp(() {
    mockRepo = MockAuthRepository();
    useCase = LoginUseCase(mockRepo);
  });

  test('returns AuthToken on successful login', () async {
    when(mockRepo.login(email: anyNamed('email'), password: anyNamed('password')))
        .thenAnswer((_) async => Right(tAuthToken));

    final result = await useCase(LoginParams(email: tEmail, password: tPassword));

    expect(result, Right(tAuthToken));
    verify(mockRepo.login(email: tEmail, password: tPassword));
    verifyNoMoreInteractions(mockRepo);
  });
}
```

### 16.3 Widget Tests

Cover all shared components: `VenueCard`, `AppButton`, `LoadingShimmer`, `DealCard`, `BookingCard`.

Cover all screen happy paths: Home renders sections, Venue Detail shows correct data, Booking flow progresses through steps.

### 16.4 Integration Tests

**Critical user journeys with `integration_test`:**

| Test ID | Journey | Devices |
|---------|---------|---------|
| IT-01 | Register → add children → view home | Android + iOS |
| IT-02 | Search for venue → apply filters → view detail | Android + iOS |
| IT-03 | Book a venue → complete payment (Stripe test mode) → view QR | Android + iOS |
| IT-04 | Browse deals → claim a deal → view in My Deals | Android |
| IT-05 | View booking history → cancel booking | Android |
| IT-06 | Toggle language → verify RTL layout | Android |

Integration tests run against **staging environment** with test accounts and Stripe test mode.

### 16.5 Performance Testing

- **Flutter DevTools** profiling on physical devices (not simulator) before each release
- Jank test: scroll home feed and venue list at 60fps — no frames > 16ms
- Memory leak test: navigate through all major screens and back; verify no retained references
- `flutter_test` performance benchmarks for critical widgets using `benchmarkWidgets`

### 16.6 Accessibility Testing

- Automated: `flutter_accessibility_lint` in CI
- Manual: TalkBack on Android, VoiceOver on iOS — before every minor release
- Test with system font size at 200% — no clipped text, no overflow

### 16.7 Security Testing

- OWASP Mobile Top 10 review before v1.0 launch
- Penetration test commissioned for payment and auth flows (third-party, before production)
- SSL pinning verification test (attempt MITM with Charles Proxy — app must reject)
- Static analysis with `dart analyze` + custom lint rules for known security patterns

---

## 17. Risks & Mitigation

| Risk ID | Risk | Probability | Impact | Mitigation |
|---------|------|------------|--------|------------|
| R-01 | Payment gateway integration delays (Telr/PayTabs onboarding requires business registration docs) | High | Critical | Start payment gateway application on day 1 of project. Integrate Stripe as fallback. Mock payment layer to unblock booking flow development. |
| R-02 | Venue partner data acquisition — slow to onboard enough venues for launch | High | High | Allocate dedicated business development resource from day 1. Define minimum viable supply (100 venues in target city) as launch gate. Scrape and pre-populate public venue data to seed the catalogue. |
| R-03 | Apple App Store rejection for Apple Sign-In non-compliance | Medium | High | Implement `sign_in_with_apple` in Sprint 1 regardless of other auth features. Review guideline 4.8 before submission. |
| R-04 | App performance on low-end Android devices | Medium | High | Test on physical mid-range Android (Snapdragon 665-class) from Sprint 1. Profile with Flutter DevTools weekly. |
| R-05 | Firebase Dynamic Links deprecated — deep links broken | High (already deprecated) | Medium | Use Branch.io from the start. Do not use Firebase Dynamic Links at any point in this project. |
| R-06 | Scope creep extending Phase 1 timeline | High | Medium | Strict MVP scope freeze after Sprint 2. Change requests go to Phase 2 backlog. |
| R-07 | API versioning mismatch between Flutter app and ASP.NET backend | Medium | High | Contract-first API design (OpenAPI spec shared before Sprint 1). Consumer-Driven Contract Testing (Pact) between frontend and backend teams. |
| R-08 | RTL layout bugs in Arabic discovered late | Medium | Medium | Implement RTL support in Sprint 1 for core navigation and home screen. Dedicated RTL regression test pass before each release. |
| R-09 | 3DS payment flow broken on specific Android OEM | Medium | High | Test 3DS on Samsung, Xiaomi, Huawei (without GMS), and OnePlus devices before launch. |
| R-10 | Play Store data safety section non-compliance | Low | High | Audit all SDKs for data collection before submission. Complete data safety form accurately. |

---

## 18. Milestones & Roadmap

### Phase 0 — Setup & Infrastructure (Weeks 1–2)

**Goal:** Development environment and architecture foundations in place. Zero feature code.

- [ ] Flutter project created with flavour configuration (dev/staging/prod)
- [ ] CI/CD pipeline fully operational (PR checks, staging deploy)
- [ ] Core architecture scaffolded (folder structure, Riverpod setup, Dio client, GoRouter, Hive init)
- [ ] Firebase project setup (all 3 environments: dev/staging/prod)
- [ ] Design system implemented in Flutter (`AppTheme`, typography, colour tokens, base components)
- [ ] API base client with auth interceptors, token refresh, error handling
- [ ] OpenAPI spec received and validated with backend team
- [ ] Development and staging environments accessible to all team members

**Exit criteria:** Any engineer can clone the repo and run a flavoured build in under 10 minutes.

---

### Phase 1 — MVP (Weeks 3–12)

**Sprint 1 (Weeks 3–4): Auth + Onboarding**
- [ ] Splash + onboarding screens
- [ ] Email registration + OTP verification
- [ ] Login screen
- [ ] Google, Facebook, Apple Sign-In
- [ ] Children profile setup
- [ ] Auth state persistence (Riverpod + SecureStorage)
- [ ] Password reset flow

**Sprint 2 (Weeks 5–6): Discovery Core**
- [ ] Home screen with API-driven sections
- [ ] Venue listing card component
- [ ] Shimmer skeleton loading
- [ ] Category browse screen
- [ ] Venue detail screen (all sections)
- [ ] Photo gallery viewer
- [ ] Basic map on venue detail

**Sprint 3 (Weeks 7–8): Search + Filters**
- [ ] Search screen with instant results
- [ ] Filter bottom sheet (age, category, price, distance, open now)
- [ ] Near me location discovery
- [ ] Full-screen map with venue pins
- [ ] Empty + error states for all list screens

**Sprint 4 (Weeks 9–10): Booking Flow**
- [ ] Availability calendar + slot selection
- [ ] Guest count selector
- [ ] Booking summary screen
- [ ] Promo code input
- [ ] Payment integration (Telr SDK or Stripe)
- [ ] 3DS handling
- [ ] Booking confirmation + QR code
- [ ] Slot reservation with countdown timer

**Sprint 5 (Weeks 11–12): Deals + Account + Notifications**
- [ ] Deals listing + detail screen
- [ ] Deal claim flow
- [ ] Booking history (upcoming/past/cancelled)
- [ ] Cancel booking flow
- [ ] Profile management (edit, photo upload)
- [ ] Children profiles CRUD
- [ ] Push notification setup (FCM + OneSignal)
- [ ] In-app notification centre
- [ ] Deep link routing (all notification types)
- [ ] RTL Arabic layout
- [ ] App Store / Play Store submission preparation

**Phase 1 Exit Criteria:**
- All P0 functional requirements passing
- 0 crash-free rate blockers (P1+ severity)
- All critical user journeys passing in integration tests
- Performance benchmarks met on physical devices
- Security review completed for auth and payment flows
- App Store and Play Store listings approved

---

### Phase 2 — Growth Features (Weeks 13–20)

| Feature | Target Sprint |
|---------|--------------|
| Rewards points earning and balance | Sprint 6 |
| Rewards catalogue + redemption | Sprint 6 |
| Referral programme | Sprint 7 |
| Wishlist (save venues) | Sprint 7 |
| Reviews and ratings (read + write) | Sprint 7 |
| Birthday party booking flow | Sprint 8 |
| Receipt PDF download | Sprint 7 |
| Offline mode (cached listings) | Sprint 8 |
| Biometric authentication | Sprint 8 |
| Push notification segmentation (OneSignal) | Sprint 6 |

---

### Phase 3 — Scale & Intelligence (Weeks 21–32)

| Feature | Notes |
|---------|-------|
| FamilyGo Pass (multi-venue subscription) | New revenue stream |
| AI-powered personalised recommendations | Requires booking history data |
| Group bookings | Complex availability logic |
| Event calendar (ticketed events) | New venue content type |
| Flutter Web app | Secondary — web app for pass gifting, receipts |
| Tablet adaptive layout | iPad and Android tablet |
| Activity bundle builder | Multi-venue itinerary planning |
| Venue review photos (user-uploaded) | Requires moderation pipeline |
| Corporate / HR benefits integration | B2B expansion |

---

### Summary Timeline

```
Week 1-2   : Phase 0 — Infrastructure & Setup
Week 3-12  : Phase 1 — MVP Build (10 weeks / 5 sprints)
Week 12    : MVP App Store & Play Store Launch
Week 13-20 : Phase 2 — Growth Features (8 weeks / 4 sprints)
Week 21-32 : Phase 3 — Scale & Intelligence (12 weeks / 6 sprints)
```

---

## Appendix A — API Endpoints Reference (MVP)

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/auth/register` | Email registration |
| POST | `/auth/verify-otp` | OTP verification |
| POST | `/auth/login` | Email login |
| POST | `/auth/social` | Social login (Google/Facebook/Apple) |
| POST | `/auth/refresh` | Token refresh |
| POST | `/auth/forgot-password` | Send password reset email |
| GET | `/home-feed` | Home screen sections |
| GET | `/venues/search` | Search + filter venues |
| GET | `/venues/{id}` | Venue detail |
| GET | `/venues/{id}/availability` | Available slots by date range |
| POST | `/bookings/reserve` | Reserve a slot (10 min hold) |
| POST | `/bookings/confirm` | Confirm after payment |
| GET | `/bookings` | User's bookings list |
| GET | `/bookings/{id}` | Booking detail |
| POST | `/bookings/{id}/cancel` | Cancel booking |
| GET | `/bookings/{id}/receipt` | Download PDF receipt |
| GET | `/deals` | Deals list |
| GET | `/deals/{id}` | Deal detail |
| POST | `/deals/{id}/claim` | Claim a deal |
| GET | `/user/profile` | Get user profile |
| PUT | `/user/profile` | Update profile |
| POST | `/user/avatar` | Upload profile photo |
| GET | `/user/children` | Get children profiles |
| POST | `/user/children` | Add child |
| PUT | `/user/children/{id}` | Update child |
| DELETE | `/user/children/{id}` | Delete child |
| GET | `/user/wishlist` | Get saved venues |
| POST | `/user/wishlist` | Save a venue |
| DELETE | `/user/wishlist/{venue_id}` | Remove from wishlist |
| POST | `/payments/create-intent` | Create payment intent |
| GET | `/payments/{intent_id}/status` | Poll payment status |
| GET | `/notifications` | User notifications list |
| POST | `/notifications/read-all` | Mark all as read |
| GET | `/config/categories` | Remote category config |

---

## Appendix B — Glossary

| Term | Definition |
|------|-----------|
| **Venue** | A physical location offering activities for children (trampoline park, museum, zoo, etc.) |
| **Slot** | A specific date + time combination available for booking at a venue |
| **Reservation** | A temporary (10-minute) hold on a slot during checkout |
| **Booking** | A confirmed, paid reservation with a unique reference and QR code |
| **Deal** | A time-limited promotional offer from a venue, claimed by users for a discount code |
| **Claim** | The act of acquiring a deal code, making it associated with the user's account |
| **Pass** | A recurring subscription product granting access to multiple venues (Phase 2) |
| **Rewards** | A loyalty points programme earned on bookings and redeemed for discounts (Phase 2) |
| **MMP** | Mobile Measurement Partner — a third-party attribution provider (Adjust, AppsFlyer) |
| **3DS** | 3D Secure — an additional authentication step for card payments |
| **OTA** | Over-the-air update — in this context refers only to remote config, not code delivery |
| **RTL** | Right-to-left — text and layout direction for Arabic |

---

*This document is version-controlled in the project repository at `/docs/PRD.md`. All changes must be reviewed by the Product Owner and Engineering Lead before merging.*
