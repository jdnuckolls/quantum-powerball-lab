# Concepts taught by Quantum Powerball Lab

## 1. Qubit
A qubit is the basic unit of quantum information. The demo allocates a fresh
qubit initially in the computational basis state |0>.

## 2. Superposition
Applying the Hadamard (`H`) gate to |0> prepares an equal superposition:
`(|0> + |1>)/√2`.

## 3. Measurement
`M(q)` measures the qubit in the computational basis. For this state, Zero and
One each have probability 1/2 in the ideal model.

## 4. Hybrid quantum/classical computation
The measurement is quantum; range checking, uniqueness, sorting, and ticket
formatting are classical. Real quantum applications commonly combine quantum
and classical computation.

## 5. Simulation vs hardware
The local QDK simulator reproduces the mathematical behavior of the quantum
program on classical hardware. That is different from executing on a physical
QPU.

## 6. Statistical validation
A correct random sampler should approach the expected distribution as sample
size grows. Statistical testing validates the sampler; it does not predict a
future lottery drawing.

## 7. QIR and targets
Quantum Intermediate Representation (QIR) provides an intermediate form that
can participate in target-specific quantum compilation/execution workflows.

## 8. Fault tolerance
Physical qubits are noisy. Quantum error correction encodes logical qubits
using physical resources so computations can be made more reliable.

## 9. Resource estimation
The QDK Resource Estimator models the application together with hardware,
error-correction, distillation, and error-budget assumptions to estimate
fault-tolerant resources.

## The sentence to remember

**Quantum randomness is real; quantum prediction of an independent lottery
drawing is not what this program does.**
