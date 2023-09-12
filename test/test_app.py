import pytest

def inc(x):
    return x + 1

def test_answer():
    assert inc(4) == 5
    
def test_answer_error():
    assert not inc(3) == 5