Implementation of Prøst on ARM11
================================

See [thomwiggers.nl/proest/][1].

This is an implementation of Prøst on ARM11. The main unrolled function is in
proest_unrolled.pq. You will need to configure the path to [qhasm][2] in the
Makefile to compile this project. You will need the `nostack` branch of qhasm.

[1]: https://thomwiggers.nl/proest/
[2]: https://github.com/thomwiggers/qhasm/
