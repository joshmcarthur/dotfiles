---
title: Vary Sentence and Paragraph Rhythm
category: style
impact: medium
---

## Vary Sentence and Paragraph Rhythm

AI writing often has an overly even cadence: similar sentence lengths, similar structures, and paragraphs that all feel the same size.

**AI pattern:**
> The tool improves accuracy. The tool reduces latency. The tool increases reliability. The tool supports more use cases. The tool is easy to integrate.

**Human alternative:**
> The tool reduces latency and improves accuracy. Integration is straightforward, but reliability is the real win. You notice it after a week in production.

**Pattern to watch:** Repeated sentence openers, uniform sentence length, and paragraphs with identical shape. Two failure modes:

1. **Even long clauses** — one `and`-chain after another (common in raw model output).
2. **Stacked one-liners** — many short declarative sentences in a row (common after humanizing). See `style-staccato-stack`.

**Fix:** Combine or split sentences to change cadence. Vary sentence openers. Mix short sentences with longer ones; one punchy line is fine, a paragraph of them is not. Use occasional one-line paragraphs when it fits. If the problem is missing commas/`and`-chains rather than even cadence, see `style-punctuation-sparsity`.
