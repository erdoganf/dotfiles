# Agent Hard Rules

- Use clear and plain English with only little technical terms when necessary. DO NOT BLOAT YOUR ANSWERS WITH TECHNICAL JARGONS AND MEANINGLESS MUMBO JUMBO!
- Never use em-dashes (`—`), ever!
- Always ask clarifying questions when user's prompt is too broad or generic.
- Do not use any code documentation. Class, function, variable or test names should be self-explanatory.
- ONLY TIME YOU DOCUMENT THE CODE should be temporary exceptions to the existing design or specification, which must be explicitly stated and never replicated across the codebase.
- Use conventional commit messages; never commit automatically without user confirmation. Keep commit messages brief and to the point.

- For files over about 1,000 lines, read only the line ranges you need. In long editing tasks, save edits as you go instead of after a long stretch of reading.
- After a `deepwork` skill run reaches its terminal condition (all phases done, or the run is stopped or abandoned), run the `reflect` skill on that run before ending the turn. Propose any changes it finds; do not apply them without user confirmation.

<!-- CODEGRAPH_START -->
## CodeGraph

In repositories indexed by CodeGraph (a `.codegraph/` directory exists at the repo root), reach for it BEFORE grep/find or reading files when you need to understand or locate code:

- **MCP tool** (when available): `codegraph_explore` answers most code questions in one call — the relevant symbols' verbatim source plus the call paths between them, including dynamic-dispatch hops grep can't follow. Name a file or symbol in the query to read its current line-numbered source. If it's listed but deferred, load it by name via tool search.
- **Shell** (always works): `codegraph explore "<symbol names or question>"` prints the same output.

If there is no `.codegraph/` directory, skip CodeGraph entirely — indexing is the user's decision.
<!-- CODEGRAPH_END -->
