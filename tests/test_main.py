"""Tests for the main module."""

import pytest

from template_python.main import main


def test_main(capsys: pytest.CaptureFixture[str]) -> None:
    """Test that main runs without error."""
    main()
    captured = capsys.readouterr()
    assert "Hello from template-python!" in captured.out
