Terraform
=========

[Colonize](https://github.com/craigmonson/colonize) is used as organization for Terraform configuration. For now this is experimental to investigate usefulness of this tool.

Conclusions so far:

- Its better than a single directory for everything (fast plan/apply per logical group).
- High number of generated files clutter directories.
- Declaring global used variables in just one place is nice.
