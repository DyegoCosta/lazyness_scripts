require './users'
require 'rubygems'
require 'capybara/dsl'

Capybara.default_wait_time = 15

@session = Capybara::Session.new(:selenium)

@session.visit 'http://www.chinainbox.com.br/'
@session.find('.link-pedir').click

@session.choose 'Usuário já cadastrado'
@session.fill_in 'email', :with => @users[:china_in_box][:login]
@session.fill_in 'senha', :with => @users[:china_in_box][:password]
@session.find('#IdentificaEmailSenha').find('input[name="Submit"]').click

@session.fill_in 'codigo', :with => '04010000'
@session.fill_in 'numero', :with => '82'
@session.fill_in 'complemento', :with => 'Ap. 50'
@session.fill_in 'ponto_ref', :with => 'Metrô Paraíso'
@session.click_on 'Cadastrar'

@session.click_link '- TRADICIONAIS'
product = @session.find(:xpath, '//span//b[contains(., "YAKISOBA DE FRANGO JR")]/..')
product.find('input[name="obs"]').set 'sem champignon'
product.find('button[name="add"]').click
@session.find('img#botao_finalizar').click
@session.find('input[name="pagamento"][value="Cartao"]').click
@session.select 'VISA CREDITO', :from => 'detalhe_cartao'
@session.click_on 'BtnCadastrar'