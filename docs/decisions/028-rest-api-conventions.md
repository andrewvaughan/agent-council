---
type: decision
description: REST API design conventions — HTTP method semantics, resource URIs, status codes, and HATEOAS opt-out rationale.
---

# Decision 028: REST API Conventions

<!-- TODO: Update the decision number to match your project's ADR numbering sequence. -->

- **Date**: <!-- TODO: Fill in date -->
- **Council**: Architecture Council
- **Status**: Approved

## Question

What REST API design conventions should all API endpoints follow?

## Context

<!-- TODO: Replace with your project's specific context. The content below is a generic template. -->

A consistent API design improves developer experience, reduces integration bugs, and makes the API surface more predictable. This ADR establishes the baseline conventions for HTTP method semantics, URI structure, status codes, and response envelope formats.

## Decision

All API endpoints must conform to **Richardson Maturity Model Level 2**: proper HTTP method semantics, resource-oriented URIs, and correct HTTP status codes.

### HTTP Methods

| Method | Use |
|--------|-----|
| `GET` | Read-only operations. Query parameters for filtering. Never use POST for reads. |
| `POST` | Create a resource or trigger a non-idempotent action (e.g., sending email). |
| `PUT` | Replace a resource entirely (idempotent). |
| `PATCH` | Partial update of a resource (idempotent). |
| `DELETE` | Remove a resource (idempotent). |

### URI Structure

- Resources are nouns, not verbs: `/users` not `/getUsers`
- Collections are plural: `/users`, `/orders`
- Nested resources for ownership: `/users/{id}/orders`
- Keep URIs lowercase with hyphens: `/api/user-profiles` not `/api/UserProfiles`

### Status Codes

| Code | When to use |
|------|-------------|
| `200 OK` | Successful GET, PUT, PATCH |
| `201 Created` | Successful POST that created a resource |
| `204 No Content` | Successful DELETE or action with no response body |
| `400 Bad Request` | Invalid input, validation failure |
| `401 Unauthorized` | Missing or invalid authentication |
| `403 Forbidden` | Authenticated but not authorized |
| `404 Not Found` | Resource does not exist |
| `409 Conflict` | Duplicate resource or state conflict |
| `422 Unprocessable Entity` | Well-formed request but semantic validation failure |
| `500 Internal Server Error` | Unexpected server-side error |

### HATEOAS Opt-Out

This project does not implement HATEOAS (Hypermedia as the Engine of Application State). The API clients are known and tightly coupled to the server — hypermedia links add complexity without value in this context. This decision can be revisited if the API becomes a public platform consumed by third parties.

## Rationale

Richardson Maturity Level 2 provides a pragmatic balance: enough structure to be predictable and interoperable without the overhead of Level 3 (HATEOAS). It is the de facto standard for production REST APIs.

## References

- [Richardson Maturity Model](https://martinfowler.com/articles/richardsonMaturityModel.html) — Martin Fowler
- [RFC 9110 — HTTP Semantics](https://www.rfc-editor.org/rfc/rfc9110)
