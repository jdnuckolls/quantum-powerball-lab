from pathlib import Path
from qdk import qsharp
from qdk.test_utils import run_tests

ROOT = Path(__file__).resolve().parents[1]
qsharp.init(project_root=str(ROOT))

# Q# projects only auto-load src/; include tests/*.qs for @Test discovery.
for path in sorted((ROOT / "tests").glob("*.qs")):
    qsharp.eval(path.read_text(encoding="utf-8"))

run_tests()
