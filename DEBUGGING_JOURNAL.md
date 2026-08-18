# Debugging Journal

Real issues encountered while building this project, how they were found, and how they were resolved. This is not a list of typos — it documents genuine gaps between intent and initial implementation.

---

## Issue 1: Public network access enabled by default, contradicting the architecture decision

**What happened**
The architecture decision for this project's database explicitly called for no public network access. The initial Terraform configuration for the PostgreSQL Flexible Server did not set this property, and Azure's default for this resource is `public_network_access_enabled = true`.

**How it was caught**
Reviewing `terraform plan` output before applying, rather than assuming the resource block matched the documented architecture decision. The plan output showed `public_network_access_enabled = true`, directly contradicting the stated design.

**Root cause**
Azure's provider default for this specific resource does not match the secure-by-default assumption a reviewer might make. Explicitly declaring security-relevant properties, rather than relying on defaults, is necessary even when the intended architecture is already documented elsewhere.

**Fix**
Added `public_network_access_enabled = false` explicitly to the resource block. Confirmed the corrected setting appeared in a fresh `terraform plan` before applying.

**Lesson**
Documenting an architecture decision does not enforce it. The actual Terraform code has to be reviewed against that documentation before deployment, not assumed to already match it.
