"""Statistical companion for Quantum Powerball Lab.

Run from the repository root after:
    pip install -r requirements.txt
"""
from pathlib import Path
from collections import Counter
import math

from qdk import qsharp

# Load the Q# project from the repository root. Project callables are namespaced,
# so the most version-resilient way to invoke this sample is qsharp.eval().
qsharp.init(project_root=str(Path(__file__).resolve().parents[1]))

SAMPLES = 10_000

white = [qsharp.eval("QuantumPowerballLab.SampleWhiteBall()") for _ in range(SAMPLES)]
counts = Counter(white)
expected = SAMPLES / 69

chi_square = sum((counts[n] - expected) ** 2 / expected for n in range(1, 70))

print(f"Samples: {SAMPLES:,}")
print(f"Expected per white ball: {expected:.2f}")
print(f"Chi-square statistic (descriptive): {chi_square:.2f}")
print("This experiment checks distribution behavior; it does not improve lottery odds.")

# Optional plot.
try:
    import matplotlib.pyplot as plt
    xs = list(range(1, 70))
    ys = [counts[x] for x in xs]
    plt.figure(figsize=(12, 5))
    plt.bar(xs, ys)
    plt.axhline(expected, linestyle="--")
    plt.xlabel("White ball")
    plt.ylabel("Observed count")
    plt.title("Quantum-sampled Powerball white-ball distribution")
    plt.tight_layout()
    plt.show()
except ImportError:
    pass
