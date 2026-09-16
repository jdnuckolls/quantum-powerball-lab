from pathlib import Path
from qdk import qsharp
from qdk.test_utils import run_tests

ROOT = Path(__file__).resolve().parents[1]
qsharp.init(project_root=str(ROOT))

run_tests()
