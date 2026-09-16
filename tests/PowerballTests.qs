namespace QuantumPowerballLab.Tests {
    import QuantumPowerballLab.*;
    import Std.Diagnostics.Fact;

    @Test()
    operation TicketHasFiveWhiteBalls() : Unit {
        let (whiteBalls, _) = GenerateQuantumTicket();
        Fact(Length(whiteBalls) == 5, "A ticket must contain exactly five white balls.");
    }

    @Test()
    operation TicketValuesAreInRange() : Unit {
        let (whiteBalls, powerball) = GenerateQuantumTicket();

        for n in whiteBalls {
            Fact(n >= 1 and n <= 69, "White ball outside 1..69.");
        }
        Fact(powerball >= 1 and powerball <= 26, "Powerball outside 1..26.");
    }

    @Test()
    operation WhiteBallsAreUnique() : Unit {
        let (whiteBalls, _) = GenerateQuantumTicket();

        for i in 0..Length(whiteBalls) - 1 {
            for j in i + 1..Length(whiteBalls) - 1 {
                Fact(whiteBalls[i] != whiteBalls[j], "White balls must be unique.");
            }
        }
    }
}
