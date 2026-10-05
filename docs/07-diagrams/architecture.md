# Architecture Layers

## Stack

- **UI:** Flutter widgets + Riverpod
- **State:** Riverpod 2.x (code-gen)
- **Domain:** Pure Dart services
- **Persistence:** Drift (SQLite)
- **Future:** Supabase (v2.0)

## Layer Diagram

┌─────────────────────────────────┐
│ Presentation │
│ Screens, Widgets, Providers │
├─────────────────────────────────┤
│ Domain │
│ Models, Services, Inputs │
├─────────────────────────────────┤
│ Data │
│ Repositories, Drift DB │
└─────────────────────────────────┘
│
▼
SQLite (local)

## Data Flow (write)

ser action
↓
Provider method
↓
Domain service (validation, calc)
↓
Repository
↓
Drift table
↓
Stream updates UI

## Data Flow (read)


## Data Flow (read)

Drift table stream
↓
Repository
↓
Provider (cached)
↓
Widget rebuild
