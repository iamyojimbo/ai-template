# Conventions

## Python

Interact with python using `uv`:

- Add a package: `uv add ...`
- Remove a package: `uv remove ...`
- Run a python script `uv run src/file.py`
- Run a python module `uv run -m src.file`
- Run a packaged command `uv run pytest`
- Lint code: `uv ruff check`
- Format code: `uv ruff format`

### Code Style

- Place all source files in the `src/` dir
- Always add typehints to function signatures
- Prefer `list[str]` to `List[str]`

## Logging

- All code should include logging
- It should verify that code is working as expected
- It should be placed so that, when issues arise, we can quickly pinpoint the
  problem, but not so many that we cannot read the code.
- Use the format:

  ```text
  Upload File: state=started id=1, name=test.csv
  Upload File: state=done id=1, name=test.csv
  Upload File: state=error id=1, name=test.csv, reason=timed_out, message=timed out after 5000ms
  ```

## Testing

- Use pytest
- place all test files next to implementation files, with the `_test` suffix.
- All important code should have passing tests
- Never use mocks. Either test a snapshot in a unit test or write an integration
  test.
- Run tests with `uv run pytest`
