# Architecture Decisions

This document records the real trade-offs considered for each major component of this platform, not just what was built. Each decision follows the same format: context, options considered, what was chosen, what was given up, and what would change the decision.

---

## Decision 1: Managed PostgreSQL vs. Self-Hosted Database on a VM

### Context
An earlier project in this portfolio (secure 2-tier infrastructure) hosted a database on a self-managed VM inside a private subnet. This project needed a database layer again, and the same approach was reconsidered against alternatives rather than repeated by default.

### Options Considered

**Option A: Self-hosted database on a VM (the previous approach)**
- Full control over the database engine, version, and configuration
- Requires manually applying OS and database patches
- Requires manually configuring backups
- Requires manually configuring high availability if uptime matters
- Lower direct cost at small scale, since it is just a VM

**Option B: Azure Database for PostgreSQL Flexible Server (managed service)**
- Azure handles patching, backups, and offers built-in high-availability options
- Less low-level control over the underlying OS
- Slightly higher direct cost than an equivalent bare VM
- Faster to provision and operate correctly from day one

**Option C: A managed NoSQL option (e.g., Cosmos DB)**
- Considered and ruled out: this platform's data model (orders, customers, relational integrity between them) fits a relational database naturally. Forcing it into a NoSQL model would add complexity without a clear benefit for this use case.

### Decision
Azure Database for PostgreSQL Flexible Server.

### Trade-offs Accepted
- Reduced low-level control over the database host itself
- Slightly higher baseline cost than a bare VM running the same engine
- Dependency on Azure's maintenance windows for patching, rather than controlling that schedule directly

### What Would Change This Decision
If this project required a database engine or extension not supported by the managed service, or if cost at very large scale made self-hosting meaningfully cheaper and the team had dedicated database administration capacity, a self-hosted approach would be reconsidered.
