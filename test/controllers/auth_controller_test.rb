require "test_helper"

class AuthControllerTest < ActionDispatch::IntegrationTest
  # Setup executado antes de cada teste
  setup do
    # Cria um usuário de teste no banco de dados
    # O AuthController usa email para login
    @user = User.create!(
      email: "auth_test@example.com",  # email para login
      name: "Auth Test User",
      password: "correct_password"  # has_secure_password exige password
    )
  end

  # Teste: Login bem-sucedido com credenciais válidas
  test "should login successfully with valid credentials" do
    # Faz requisição POST para /auth/login com credenciais corretas
    # O AuthController usa a chave :email para login
    post auth_login_url,
         params: { auth: { email: @user.email, password: "correct_password" } },
         as: :json

    # Verifica se resposta foi de sucesso (200)
    assert_response :success

    # Verifica se a resposta contém token
    response_body = JSON.parse(@response.body)
    assert response_body.key?("token"), "Response should contain token"
    assert response_body.key?("user"), "Response should contain user data"
  end

  # Teste: Login com usuário inexistente
  test "should return unauthorized for non-existent user" do
    # Tenta login com email que não existe
    post auth_login_url,
         params: { auth: { email: "non_existent@test.com", password: "any_password" } },
         as: :json

    # Deve retornar 401 (unauthorized)
    assert_response :unauthorized

    response_body = JSON.parse(@response.body)
    assert response_body.key?("message"), "Response should contain message"
  end

  # Teste: Login com senha incorreta
  test "should return unauthorized with wrong password" do
    # Tenta login com senha errada (mas email correto)
    post auth_login_url,
         params: { auth: { email: @user.email, password: "wrong_password" } },
         as: :json

    # Deve retornar 401 (unauthorized)
    assert_response :unauthorized

    response_body = JSON.parse(@response.body)
    assert_equal "Incorrect password", response_body["message"]
  end

  # Teste: Login sem parâmetros (erro de validação)
  # params.require(:auth) falha quando auth não é enviado
  test "should return bad request without parameters" do
    # Tenta login sem enviar params
    post auth_login_url, as: :json

    # Deve retornar erro de params faltantes (400)
    assert_response :bad_request
  end

  # Teste: Login com email que não existe no banco
  test "should return unauthorized for non-existent username" do
    post auth_login_url,
         params: { auth: { email: "non_existent_user@test.com", password: "any_password" } },
         as: :json

    assert_response :unauthorized
    response_body = JSON.parse(@response.body)
    assert_equal "User doesn't exist", response_body["message"]
  end
end
