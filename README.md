# Zelda Dungeons of Infinity v1.1.6 Decomp / Refactor
This private repository serves as a research hub for The Legend of Zelda: Dungeons of Infinity game developed by Justin Bohemier. Version 1.1.6 has a VM build which makes freelance refactoring and optimization possible via UnderTaleModTool.

The scripts have been exported and the repo structure is as follows:

#### data_116_chunked/
This folder contains split json files chunked from original `data_r` and `data_d`. The originals were loaded into a buffer and then stringified, and then parsed, causing a high peak memory at initialization. Chunking the data allows us to lower the peak usage, but in turn causes heap fragmentation and increased object counts---slowing gameplay to a crawl.

#### scripts_116/
This folder contains all the gml scripts exported from the original v1.1.6 build.

## Privacy Policy
This is a **closed private repository**. Do not share data outside of this repository except with authorized collaborators.
