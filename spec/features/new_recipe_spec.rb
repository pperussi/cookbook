# frozen_string_literal: true

require 'rails_helper'

feature 'User register recipes' do
  scenario 'succesfully' do
    create(:user)
    create(:recipe_type, name: 'Sobremesa')
    create(:cuisine)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Senha', with: '123456'
    click_on 'entrar'
    click_on 'Cadastrar Receita'

    fill_in 'Título', with: 'Brigadeiro'
    select 'Sobremesa', from: 'Tipo de Receita'
    select 'Brasileira', from: 'Cozinha'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '30'
    fill_in 'Ingredientes', with: 'Leite condensado, ' \
                                  'manteiga e chocolate em pó'
    fill_in 'Como Preparar', with: 'Misture tudo em uma panela, ' \
                                   'deixe no fogo enquanto mexe, ' \
                                   'até começar a desgrudar do fundo'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Brigadeiro')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Sobremesa')
    expect(page).to have_css('p', text: 'Brasileira')
    expect(page).to have_css('p', text: 'Fácil')
    expect(page).to have_css('p', text: '30 minutos')
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: 'Leite condensado, ' \
                                        'manteiga e chocolate em pó')
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text: 'Misture tudo em uma panela, ' \
                                        'deixe no fogo enquanto mexe, ' \
                                        'até começar a desgrudar do fundo')
    expect(page).to have_css('p', text: 'Enviada por test@example.com')
  end

  scenario 'must fill in all fields' do
    create(:user)
    create(:recipe_type, name: 'Sobremesa')
    create(:cuisine)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Senha', with: '123456'
    click_on 'entrar'
    click_on 'Cadastrar Receita'

    fill_in 'Título', with: 'Brigadeiro'
    select 'Sobremesa', from: 'Tipo de Receita'
    select 'Brasileira', from: 'Cozinha'
    fill_in 'Tempo de Preparo', with: '30'
    fill_in 'Ingredientes', with: 'Leite condensado, ' \
                                  'manteiga e chocolate em pó'
    fill_in 'Como Preparar', with: 'Misture tudo em uma panela, ' \
                                   'deixe no fogo enquanto mexe, ' \
                                   'até começar a desgrudar do fundo'
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível cadastrar Receita')
  end
end
