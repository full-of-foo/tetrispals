  require 'spec_helper'

describe "Static pages" do

  subject { page }

  shared_examples_for "all Static Pages" do
    it { should have_selector('h1',    text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }

    let(:heading) { "Tetris Pals" }
    let(:page_title) { "" }

    it_should_behave_like "all Static Pages"
    it { should_not have_selector 'title', text: '| Home' }
  end

  describe "Help page" do
    before { visit help_path }

    let(:heading) { "Help" }
    let(:page_title) { "" }

    it_should_behave_like "all Static Pages"
  end

  describe "About page" do
    before { visit about_path }

    let(:heading) { "About" }
    let(:page_title) { "" }

    it_should_behave_like "all Static Pages"
  end

  describe "Contact page" do
    before { visit contact_path }

    let(:heading) { "Contact" }
    let(:page_title) { "" }

    it_should_behave_like "all Static Pages"
  end
end