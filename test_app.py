import os
import tempfile
import pytest
from app import app

@pytest.fixture
def client():
    db_fd, app.config['DATABASE'] = tempfile.mkstemp()
    app.config['TESTING'] = True
    client = app.test_client()

    with app.app_context():
        app.init_db()

    yield client

    os.close(db_fd)
    os.unlink(app.config['DATABASE'])

def test_index(client):
    """Testa a rota /"""
    response = client.get('/')
    assert "Hello, World!" in response.data

def test_login(client):
    """Testa a rota /login"""
    response = client.get('/login')
    assert "Login" in response.data

def test_register(client):
    """Testa a rota /register"""
    response = client.get('/register')
    assert "Register" in response.data

# Adicione mais testes para outros endpoints conforme necessário

if __name__ == '__main__':
    pytest.main()
