---
name: django-for-joshmcarthur
description: >-
  Build small, Rails-like Django applications for @joshmcarthur. Use when
  creating a new Django app, scaffolding Django architecture, choosing Django
  packages or infrastructure, adding background jobs, building server-rendered UI,
  or deciding between Django/HTMX/Hotwire/API architectures.
---

# Django Apps for @joshmcarthur

Build Django applications with a Rails-like developer experience: cohesive, HTML-first, convention-driven, and with minimal infrastructure.

The default goal is:

Django 6 + SQLite + server-rendered HTML + Turbo/Stimulus + Django Tasks, with as few external services as possible.

## Trigger conditions

Use this skill when:

* Starting a new Django application.
* Designing or refactoring Django project structure.
* Choosing Django packages or infrastructure.
* Adding background jobs or scheduled work.
* Building a server-rendered Django UI.
* Considering HTMX, Turbo, Stimulus, Hotwire Native, React, or an API.
* Building a Django application that may have an iOS/Android Hotwire Native client.
* The user asks to make Django feel more like Rails.
* Deciding whether a Django concept deserves a separate Django app.

Do not apply these defaults rigidly when the application has explicit requirements that justify a different architecture.

## Core defaults

| Concern | Default |
|---|---|
| Framework | Django 6 |
| Database | SQLite |
| Architecture | One Django app, internally namespaced |
| HTML | Django Templates |
| UI enhancement | Turbo + Stimulus |
| Native clients | Hotwire Native |
| Authentication | django-allauth |
| Admin | Django Admin |
| Background jobs | Django Tasks |
| Task backend | django-ox |
| Scheduling | Lightweight Django-compatible scheduler |
| APIs | None by default |
| Frontend framework | None |
| Cache/broker | None by default |
| Redis | No |
| Celery | No |
| PostgreSQL | No, unless justified |
| React/Next.js | No, unless justified |
| Docker | No, unless useful for deployment/development |

## Workflow

When creating a new application, follow these steps.

### 1. Start minimal

Create:

```
project/
├── manage.py
├── config/
│   ├── settings.py
│   ├── urls.py
│   └── asgi.py
└── app/
    ├── models/
    ├── views/
    ├── forms/
    ├── services/
    ├── tasks/
    ├── components/
    ├── templates/
    ├── static/
    ├── urls.py
    └── admin.py
```

Use a single Django app unless there is a concrete reason to create multiple Django apps.

Django apps are not required to be domain boundaries.

### 2. Use small files

Prefer:

```
models/
├── project.py
├── document.py
└── user.py
```

over:

```
models.py
```

Likewise:

```
views/
├── projects.py
├── documents.py
└── dashboard.py
```

rather than one large views.py.

Re-export models from models/__init__.py so Django and application code can still use:

```python
from app.models import Project
```

### 3. Build HTML-first

Start with:

```
Browser
  ↓
Django view
  ↓
Django template
```

Do not start by designing a REST API or SPA.

Use progressive enhancement for richer interactions.

### 4. Add Turbo + Stimulus

For interactive applications, use:

* Turbo Drive
* Turbo Frames
* Turbo Streams
* Stimulus

Prefer Turbo when a Hotwire Native client is possible.

Use HTMX instead when the application is explicitly web-only and HTMX provides a simpler solution.

### 5. Add authentication

Use django-allauth.

Do not build authentication infrastructure manually unless there is a specific requirement.

### 6. Use Django Admin

Register application models with Django Admin.

Before building an internal CRUD interface, check whether Admin already solves the requirement.

### 7. Add background tasks only when required

Use Django Tasks:

```python
from django.tasks import task

@task
def generate_document(document_id):
    ...
```

Queue with:

```python
generate_document.enqueue(document_id)
```

Use django-ox for database-backed execution.

Do not introduce Celery/Redis for ordinary background work.

### 8. Add scheduling separately

For recurring work, use a lightweight scheduler that invokes Django Tasks.

Keep:

```
scheduler
    ↓
Django Task
    ↓
task backend
```

as separate concerns.

### 9. Add native clients independently

If using Hotwire Native:

```
server/
ios/
android/
```

Keep the native shells separate from the Django project.

The Django server remains the primary application/backend and normally serves HTML rather than a dedicated REST API.

### 10. Add infrastructure only when justified

Before adding a service, ask:

What concrete requirement does this solve that Django + SQLite cannot?

Only then introduce infrastructure such as PostgreSQL, Redis, Celery, object storage, or a frontend build system.

## Architecture rules

### Models

Do:

* Keep models in individual files.
* Put domain behaviour on models when it naturally belongs there.
* Re-export models from models/__init__.py.

Don't:

* Create a service layer merely to wrap every model method.
* Create Django apps just to organise model files.
* Put unrelated models into one enormous file.

### Views

Do:

* Keep views small.
* Let views coordinate requests, forms, services, and templates.
* Split views by resource/feature.

Don't:

* Put substantial business logic into views.
* Build a frontend API unless one is actually required.

### Services

Use services for operations that:

* span multiple models,
* represent meaningful application actions,
* are reused by views/tasks,
* or would otherwise make views complicated.

Prefer simple functions or small classes.

Do not build a generic service-object framework.

### Tasks

Use Django Tasks for:

* expensive work,
* external API calls,
* asynchronous processing,
* imports/exports,
* notifications,
* generation jobs.

Keep task definitions close to the application code they serve.

Do not use Celery unless the requirements genuinely demand it.

### Templates

Prefer server-rendered HTML.

Use Django's template partials and, where useful, django-components.

Keep components focused on presentation.

Do not turn Django templates into a disguised SPA.

## Hotwire rules

If the application may have a Hotwire Native client:

Prefer:

```
Django
  ↓
Turbo
  ↓
Stimulus
  ↓
Hotwire Native
```

over:

```
Django
  ↓
REST API
  ↓
React / native API client
```

Use:

* Turbo Drive for navigation.
* Turbo Frames for independently updating page regions.
* Turbo Streams for server-driven DOM updates.
* Stimulus for small client-side behaviours.
* Hotwire Native for native shells and native-specific UI.

A package such as django-turbo-helper may be used when it meaningfully simplifies Turbo responses.

Do not introduce a large Rails-emulation layer just to reproduce Rails syntax.

## API rules

An API is not the default interface.

Only add one when:

* another application needs it,
* a public API is required,
* a native client genuinely cannot use Hotwire,
* or an integration requires a structured API.

When needed, prefer the smallest suitable solution:

1. Django views for simple endpoints.
2. Django Ninja for a typed API.
3. Django REST Framework when its ecosystem is specifically useful.

Do not install DRF automatically.

## Infrastructure rules

### SQLite

Use SQLite by default.

Move to PostgreSQL when there is a concrete requirement involving:

* concurrency,
* scale,
* PostgreSQL-specific features,
* operational constraints,
* or an external platform requirement.

### Redis

Do not add Redis by default.

First consider:

* SQLite
* Django Tasks
* django-ox
* Django caching
* SSE
* ordinary HTTP

### Celery

Do not add Celery by default.

Use Django Tasks first.

### Docker

Do not Dockerise the development environment merely because Docker is conventional.

Use Docker when it materially simplifies:

* deployment,
* reproducibility,
* required infrastructure,
* or team workflows.

## Dependency rules

Before adding a package:

1. Check whether Django already provides the functionality.
2. Check whether a small package solves it.
3. Prefer a package with a narrow purpose.
4. Avoid infrastructure-heavy packages.
5. Avoid packages that require Redis/Postgres/Node unless necessary.

The desired dependency graph is small.

## Frontend rules

Prefer:

* HTML
* CSS
* Turbo
* Stimulus

before:

* React
* Vue
* Svelte
* Next.js

Use Tailwind if it improves development speed, but don't introduce a frontend build pipeline merely to use a small amount of CSS.

Avoid Webpack/Vite/Node tooling unless the application genuinely requires it.

## Decision hierarchy

When choosing an implementation, prefer:

1. Django built-in
2. Small Django package
3. Simple Python
4. External service
5. New framework/infrastructure

Examples:

**Jobs**

```
Django Tasks
    ↓
django-ox
    ↓
SQLite
```

not automatically:

```
Celery
    ↓
Redis
```

**UI**

```
Django Templates
    ↓
Turbo + Stimulus
```

not automatically:

```
React SPA
```

**Administration**

```
Django Admin
```

not automatically:

```
Custom admin frontend
```

**Data**

```
Django ORM
```

not automatically:

```
Repository/data-access abstraction
```

## Do

* Keep the stack small.
* Prefer Django's built-ins.
* Use SQLite by default.
* Use one Django app with internal filesystem organisation.
* Split models and views into small files.
* Use Django Templates.
* Use Django Admin.
* Use django-allauth.
* Use Django Tasks for background work.
* Prefer django-ox for SQLite-backed task execution.
* Use Turbo + Stimulus for interactive HTML applications.
* Use Hotwire Native when native clients are desired.
* Keep business logic in Python.
* Add infrastructure only when requirements justify it.
* Optimise for an application that is easy to understand months later.

## Don't

* Don't add Redis automatically.
* Don't add Celery automatically.
* Don't add PostgreSQL automatically.
* Don't create a Django app for every domain.
* Don't build a REST API before there is a need for one.
* Don't build a React SPA by default.
* Don't introduce Docker just for convention.
* Don't create a service object for every operation.
* Don't build custom admin screens when Django Admin is sufficient.
* Don't create elaborate abstractions to make Django syntactically identical to Rails.
* Don't optimise for hypothetical scale before the application needs it.

## Final sanity check

Before considering the architecture complete, ask:

* Could this run on SQLite?
* Could I remove Redis?
* Could I remove Celery?
* Could this be server-rendered?
* Could Turbo handle this?
* Could Stimulus handle this?
* Could Django Admin handle this?
* Could Django itself provide this?
* Have I created a Django app that doesn't need to be an app?
* Have I introduced infrastructure without a concrete requirement?

If the answer to any of these suggests unnecessary complexity, simplify the application.
