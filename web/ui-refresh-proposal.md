# GoAlert UI v2
_Ideas and notes for a refresh of the GoAlert UI_

* What types of things would benefit somebody in an operational view?
* How does the TOC primarily use GoAlert (if at all anymore)?
* What are the most important things to an on-call engineer when they open GoAlert?


## Brainstorming
- Dark mode/more themes
- Allow desktop push notifications
- Convert Profile to Settings/Profile dialog
    - Users list only visible in operational view
- Dashboard/homepage view separate from alerts
- Move rotations view into schedule assignments view
    - Removing visual concept of a rotation only
- Add settings dialog and DB table to save user metadata
- Favor native input controls when possible
- Serve content from beta domain when toggled

---

## Design Notes
### App Bar, Sidebar, and Toolbar
- Remove the sidebar completely, and have a top and bottom toolbar
- Target icons in the bottom toolbar, centered
- Have titles and breadcrumbs, page controls, search, and profile/settings/logout buttons in top toolbar

### Dashboard
- Card grid layout
- Allow customizability that can be saved
- Notice for on-call yes/no/soon

### Alerts
- Use redesign notes
    - Leave out bundling logic (no changes to API)

### Services
- Show heartbeat monitors as graphs like the new alerts style/Grafana

### Escalation Policies
- More helpful visual representation for escalation flow

### Schedules
- Combine rotations visually into schedules view

### Profile
- Profile is a dialog in focused view, page in

## Database Notes
Table names prepended with a * would be new to the current schema.
- **users**
    - status: online | offline | idle | busy
- **\*user_preferences**
    - id = user.id
    - theme: string
    - alert_status_updates: boolean
    - avatar
    - team: uuid
    - dashboard: JSON
- **\*teams**
    - id
    - name
    - services: uuid[]
    - escalation_policies: uuid[]
    - schedules: uuid[]
    - rotations: uuid[]
    - users: uuid[]

---

# GoAlert UI v2 Proposal

## The Big Picture
The idea of giving the UI a refresh stems from GoAlert initially being built with the intention to get n MVP into customers hands, fast, which meant that design came more as an afterthought. Now that GoAlert is stable, open-source, and expanding within the community, we think it’s time that we gave the experience of being woken up at 3 in the morning the attention it deserves.

## Key Concepts
- Keep it simple
- Get with the times
- Design for smaller screens, first
- Combine similar features
- Users shouldn’t need to memorize definitions to understand something
- Support swapping between an operational (like what you’re used to seeing today) and a focused, team oriented view
- Only add to the existing API; don’t introduce any changes to the existing API
- Full test coverage, both error and success states
- 100% Typescript using functional components

## Definitions
**Target.** A blanket term for a service, escalation policy, schedule, rotation, or user
**DP.** Details page; the details page for a target given its unique ID.
**GQL.** GraphQL
**MUI.** Material-UI; the component library used

## Case Study: Whitespace
How much whitespace is too much? Should there be padding around all window edges? Is room left for floating buttons?

### Material UI
All information sourced from material.io
- According to Google’s Material standard, "when designing for the web, replace dp with px (for pixel)."
- Mobile items stretch to full width horizontally
- There is a 4dp padding above body content, below the top toolbar
- Use 24pd padding between components
- Clickable items should have a minimum of 48 x 48 dp

### Airbnb
- Search is in top toolbar
- Uses bottom toolbar for navigation icons
- Floating fab is center bottom
- No use of cards, content is placed inset on a white background
- Fullscreen dialogs swipe up from the bottom
- Fab disappears reaching the bottom of the page (slide down transition)
