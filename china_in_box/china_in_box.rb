require './secrets'
require 'capybara/webkit'
require 'capybara/dsl'

Capybara.default_wait_time = 15
Capybara.javascript_driver = :webkit

s = Capybara::Session.new(:webkit)

product_name = 'YAKISOBA CLÁSSICO'

s.visit 'http://www.chinainbox.com.br'

s.fill_in('txtTexto', with: product_name)
s.find('.btn-search').click

s.find('.btn-peca-online').click

s.fill_in('cep', with: @addresses[:home][:zip_code])
s.fill_in('numero', with: @addresses[:home][:number])
s.find('#btnEnviar').click

s.visit 'https://www.deliverynow.com.br/site/novo/produtos.php'

product = s.find(:xpath, "//div[@class='produtoItem']//label[contains(., '#{product_name}')]/..")
product.fill_in('obs', with: 'sem champignon')
product.find('.botao_adicionar').click

s.find('#div_botao_finalizar a').click

s.fill_in 'email_acesso', with: @secrets[:china_in_box][:login]
s.fill_in 'senha', with: @secrets[:china_in_box][:password]
s.find('#Entrar').click

s.find('#Cadastrar').click

s.find('input[name="pagamento"][value="Cartao"]').click
s.select 'VISA CREDITO', from: 'detalhe_cartao'
s.find('#BtnCadastrar').click

s.find(:xpath, '//font[contains(., "Pedido Processado com Sucesso")]')
