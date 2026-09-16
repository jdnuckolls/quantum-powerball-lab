"""Fault-tolerant resource-estimation bridge.

The Powerball sampler is intentionally measurement-heavy and adaptive, so it is
primarily a teaching example rather than a compelling fault-tolerant workload.
This file demonstrates the current qdk.qre workflow with a small coherent
Q# operation that can be estimated cleanly.
"""
from qdk import qsharp
import qdk
from qdk.qre.application import QSharpApplication
from qdk.qre.models import GateBased, SurfaceCode, RoundBasedFactory
from qdk.qre import estimate, plot_estimates

qsharp.eval("""
operation ResourceDemo() : Unit {
    use q = Qubit[4];
    H(q[0]);
    CX(q[0], q[1]);
    CX(q[1], q[2]);
    CX(q[2], q[3]);
}
""")

app = QSharpApplication(qdk.code.ResourceDemo)
arch = GateBased(error_rate=1e-4, gate_time=100, measurement_time=500)
isa = SurfaceCode.q() * RoundBasedFactory.q()
results = estimate(app, arch, isa_query=isa, max_error=0.01)

print(results.as_frame())
plot_estimates(results, figsize=(7, 4), runtime_unit="ms")
