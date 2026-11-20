#!/usr/bin/env python3
import subprocess
import sys
from pathlib import Path


def main() -> int:
    if len(sys.argv) < 2:
        print("Usage: python scripts/run_sql.py <sql-file> [<sql-file> ...]", file=sys.stderr)
        return 2

    for name in sys.argv[1:]:
        path = Path(name)
        result = subprocess.run(
            [
                "docker",
                "exec",
                "-i",
                "-e",
                "MYSQL_PWD=123",
                "my-mysql",
                "mysql",
                "-uroot",
                "--default-character-set=utf8mb4",
                "--table",
            ],
            input=path.read_bytes(),
        )
        if result.returncode:
            return result.returncode
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
