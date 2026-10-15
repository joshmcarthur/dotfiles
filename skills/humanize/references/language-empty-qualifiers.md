---
title: Cut Empty Qualifiers
category: language
impact: high
---

## Cut Empty Qualifiers

AI adds adjectives that narrow nothing. Delete the word and the sentence means the same thing.

**AI pattern:**
> Returns the appropriate handler for the given request, configured as needed.

**Human alternative:**
> Returns the POST handler for `/webhooks/strava`.

**Words to watch:** the appropriate/relevant/necessary/proper/desired/corresponding/given/specified X, as appropriate, as needed, if applicable, where appropriate, various (when it does not enumerate)

**Fix:** Name the actual constraint, or drop the qualifier. Dual-adjective padding (`language-dual-adjectives`) is a different tell: paired marketing adjectives, not hollow determiners.
