namespace QuantumPowerballLab {
    import Std.Convert.ResultArrayAsInt;
    import Std.Diagnostics.Fact;
    import Std.Math.BitSizeI;

    operation QuantumRandomBit() : Result {
        use q = Qubit();
        H(q);
        let result = M(q);
        Reset(q);
        return result;
    }

    /// Samples uniformly from 0..maxInclusive using quantum measurement
    /// plus rejection sampling. The local QDK simulator emulates the qubit;
    /// on compatible hardware, the same quantum operation can target a QPU.
    operation QuantumRandomInt(maxInclusive : Int) : Int {
        if maxInclusive <= 0 {
            return 0;
        }

        let nBits = BitSizeI(maxInclusive);
        mutable bits : Result[] = [];

        for _ in 1..nBits {
            set bits += [QuantumRandomBit()];
        }

        let sample = ResultArrayAsInt(bits);
        if sample > maxInclusive {
            return QuantumRandomInt(maxInclusive);
        }
        return sample;
    }

    operation QuantumRandomIntInRange(minInclusive : Int, maxInclusive : Int) : Int {
        return minInclusive + QuantumRandomInt(maxInclusive - minInclusive);
    }

    function ContainsInt(values : Int[], value : Int) : Bool {
        for item in values {
            if item == value {
                return true;
            }
        }
        return false;
    }

    function SortInts(values : Int[]) : Int[] {
        mutable result = values;
        let n = Length(result);

        if n > 1 {
            for i in 0..n - 2 {
                for j in 0..n - 2 - i {
                    if result[j] > result[j + 1] {
                        let temp = result[j];
                        set result w/= j <- result[j + 1];
                        set result w/= j + 1 <- temp;
                    }
                }
            }
        }
        return result;
    }

    operation GenerateQuantumTicket() : (Int[], Int) {
        mutable whiteBalls : Int[] = [];

        while Length(whiteBalls) < 5 {
            let candidate = QuantumRandomIntInRange(1, 69);
            if not ContainsInt(whiteBalls, candidate) {
                set whiteBalls += [candidate];
            }
        }

        let powerball = QuantumRandomIntInRange(1, 26);
        return (SortInts(whiteBalls), powerball);
    }

    /// Generates `count` tickets and returns them newest-first.
    operation GenerateRecentTickets(count : Int) : (Int[], Int)[] {
        mutable tickets : (Int[], Int)[] = [];
        for _ in 1..count {
            let ticket = GenerateQuantumTicket();
            set tickets = [ticket] + tickets;
        }
        return tickets;
    }

    /// Teaching mode: exposes the path from qubit measurement to a ticket.
    operation LearningDemo() : Unit {
        Message("QUANTUM POWERBALL LAB — LEARNING MODE");
        Message("--------------------------------------");
        Message("1. Allocate a qubit in |0>.");
        Message("2. Apply H: |0> -> (|0> + |1>)/sqrt(2).");
        Message("3. Measure: the simulator returns Zero or One.");
        let bit = QuantumRandomBit();
        Message($"   Example measured bit: {bit}");
        Message("4. Repeat measurements to form an integer.");
        Message("5. Reject values outside the desired range to preserve uniformity.");
        Message("6. Repeat until five unique white balls and one Powerball exist.");

        let recent = GenerateRecentTickets(5);
        let (whiteBalls, powerball) = recent[0];
        Message($"Quantum ticket: {whiteBalls} | Powerball: {powerball}");
        Message("");
        Message("Recent tickets (newest first):");
        for i in 0..Length(recent) - 1 {
            let (whites, pb) = recent[i];
            Message($"  {whites} | Powerball: {pb}");
        }
        Message("");
        Message("Important: quantum randomness does NOT predict a future lottery drawing.");
    }

    operation SampleWhiteBall() : Int {
        return QuantumRandomIntInRange(1, 69);
    }

    operation SamplePowerball() : Int {
        return QuantumRandomIntInRange(1, 26);
    }

    operation Main() : Unit {
        LearningDemo();
    }
}
